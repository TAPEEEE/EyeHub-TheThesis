//
//  CameraView.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 20/8/2567 BE.
//

import AVFoundation
import UIKit

class CameraView: UIView, AVCaptureMetadataOutputObjectsDelegate {
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureSession: AVCaptureSession!
    var faceRectangleLayer: CAShapeLayer!
    var overlayView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupCamera()
        setupOverlay()
        setupFaceRectangleLayer()
    }

    private func setupCamera() {
        // 1. สร้าง AVCaptureSession
        captureSession = AVCaptureSession()

        // 2. เลือกกล้อง (กล้องหน้าในกรณีนี้)
        guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }

        // 3. สร้างอินพุตจากกล้อง
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        // 4. เพิ่มอินพุตไปยัง AVCaptureSession
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }

        // 5. สร้างและกำหนด AVCaptureMetadataOutput สำหรับตรวจจับใบหน้า
        let metadataOutput = AVCaptureMetadataOutput()
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.face] // ตั้งค่าให้ตรวจจับใบหน้า
        } else {
            return
        }

        // 6. สร้าง AVCaptureVideoPreviewLayer เพื่อแสดงผลวิดีโอ
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        self.layer.addSublayer(previewLayer)

        // 7. เรียกใช้งาน startRunning() บน Background Thread
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }

    private func setupOverlay() {
        // 8. สร้าง UIView สำหรับ overlay ที่จะวางทับกล้องและมีช่องวงกลมตรงกลาง
        overlayView = UIView(frame: self.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.addSubview(overlayView)
    }

    private func setupFaceRectangleLayer() {
        // 9. สร้าง CAShapeLayer สำหรับวาดกรอบสี่เหลี่ยม
        faceRectangleLayer = CAShapeLayer()
        faceRectangleLayer.strokeColor = UIColor.red.cgColor
        faceRectangleLayer.lineWidth = 2
        faceRectangleLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(faceRectangleLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // คำนวณขนาดของ previewLayer ให้เป็นสี่เหลี่ยมจัตุรัส
        let sideLength = min(self.bounds.width, self.bounds.height)
        let rect = CGRect(x: (self.bounds.width - sideLength) / 2, y: (self.bounds.height - sideLength) / 2, width: sideLength, height: sideLength)
        previewLayer.frame = rect
        
        // ปรับขนาดของ overlayView ให้ครอบคลุมทั้งหมด
        overlayView.frame = self.bounds
        
        // ปรับขนาดและตำแหน่งของ faceRectangleLayer ให้ตรงกับ previewLayer
        faceRectangleLayer.frame = previewLayer.frame
        faceRectangleLayer.setNeedsDisplay()
        
        // สร้างมาสก์สำหรับ overlayView
        let path = UIBezierPath(rect: overlayView.bounds)
        let circleRadius: CGFloat = 200
        let circlePath = UIBezierPath(ovalIn: CGRect(x: overlayView.bounds.midX - circleRadius, y: overlayView.bounds.midY - circleRadius, width: circleRadius * 2, height: circleRadius * 2))
        path.append(circlePath)
        path.usesEvenOddFillRule = true
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        
        overlayView.layer.mask = maskLayer
    }


    // ฟังก์ชันที่เรียกเมื่อเจอใบหน้า
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let faceObject = metadataObject as? AVMetadataFaceObject else { return }

            // แปลงตำแหน่งของใบหน้าให้เป็นตำแหน่งบนหน้าจอ
            let faceBounds = previewLayer.transformedMetadataObject(for: faceObject)?.bounds

            // วาดกรอบสี่เหลี่ยมรอบใบหน้า
            faceRectangleLayer.path = UIBezierPath(rect: faceBounds!).cgPath

            // สมมติให้ขนาดเฉลี่ยของใบหน้าเป็น 18 cm
            let averageFaceHeightInCm: CGFloat = 18.0
            let faceHeightInPixels = faceBounds!.height
            let screenHeightInCm: CGFloat = UIScreen.main.bounds.height / UIScreen.main.scale // ความสูงของจอในหน่วย cm

            // คำนวณระยะห่างโดยใช้สูตร
            let distanceInCm = (averageFaceHeightInCm * screenHeightInCm) / faceHeightInPixels

            if distanceInCm > 33 {
                faceRectangleLayer.strokeColor = UIColor.red.cgColor
            } else if distanceInCm < 28 {
                faceRectangleLayer.strokeColor = UIColor.red.cgColor
            } else {
                faceRectangleLayer.strokeColor = UIColor.green.cgColor // เปลี่ยนเป็นสีเขียว
                print("ระยะห่างระหว่างหน้าจอกับใบหน้า: \(distanceInCm) cm (อยู่ในช่วงที่กำหนด)")
            }

        } else {
            // หากไม่พบใบหน้า ลบกรอบสี่เหลี่ยม
            faceRectangleLayer.path = nil
        }
    }
}
