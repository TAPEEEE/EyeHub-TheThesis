import UIKit
import AVFoundation


class EyeTestOnboardingViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var buttonView: PrimaryButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var faceRectangleLayer: CAShapeLayer!
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        setUpCamera()
        configureAudioSession()
        playSound()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playSound()
        // เริ่มการทำงานของ captureSession เมื่อ view จะปรากฏ
        DispatchQueue.global(qos: .userInitiated).async {
            if !(self.captureSession?.isRunning ?? false) {
                self.captureSession.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // หยุดการทำงานของ captureSession
        DispatchQueue.global(qos: .userInitiated).async {
            if self.captureSession?.isRunning ?? false {
                self.captureSession.stopRunning()
            }
        }
    }
    
    func commonInit() {
        setUpUI()
        navigationBar.delegate = self
        let buttontapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleButtonAction)
        )
        buttonView.addGestureRecognizer(buttontapGesture)
    }
    
    @objc func handleButtonAction() {
        let navigateVc = SnellenTestViewController()
        navigationController?.pushViewController(navigateVc, animated: true)
    }
    
    func setUpUI() {
        navigationBar.set(title: "ทดสอบสายตา")
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
        buttonView.setUp(.textOnly(text: "เริ่มทดสอบ"), type: .primary, size: .large)
        titleLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        titleLabel.font = FontFamily.Kanit.medium.font(size: 28)
        descriptionLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        descriptionLabel.font = FontFamily.Kanit.light.font(size: 16)
        navigationBar.set(title: "ทดสอบสายตา")
        buttonView.buttonState = .disable
    }
    
    func playSound() {
            // ตรวจสอบและโหลดไฟล์ MP3 จาก Bundle
            guard let url = Bundle.main.url(forResource: "distaance", withExtension: "mp3") else {
                return
            }

            do {
                // สร้าง AVAudioPlayer instance
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("เกิดข้อผิดพลาดในการเล่นเสียง: \(error.localizedDescription)")
            }
        }
    
    private func setUpCamera() {
        // สร้าง AVCaptureSession
        captureSession = AVCaptureSession()
        
        // เลือกกล้อง (กล้องหน้าในกรณีนี้)
        guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        
        // สร้างอินพุตจากกล้อง
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        // เพิ่มอินพุตไปยัง AVCaptureSession
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        // สร้างและกำหนด AVCaptureMetadataOutput สำหรับตรวจจับใบหน้า
        let metadataOutput = AVCaptureMetadataOutput()
        
        // เพิ่มเอาต์พุตไปยัง AVCaptureSession
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.face] // ตั้งค่าให้ตรวจจับใบหน้า
        } else {
            return
        }
        
        // สร้าง AVCaptureVideoPreviewLayer เพื่อแสดงผลวิดีโอ
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = cameraView.bounds
        previewLayer.videoGravity = .resizeAspectFill
        cameraView.layer.addSublayer(previewLayer)
        
        // สร้าง CAShapeLayer สำหรับวาดกรอบสี่เหลี่ยม
        faceRectangleLayer = CAShapeLayer()
        faceRectangleLayer.strokeColor = UIColor.red.cgColor
        faceRectangleLayer.lineWidth = 4
        faceRectangleLayer.fillColor = UIColor.clear.cgColor
        cameraView.layer.addSublayer(faceRectangleLayer)
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
            
            // เปลี่ยนสีของกรอบสี่เหลี่ยมตามระยะห่าง
            if distanceInCm > 33 {
                faceRectangleLayer.strokeColor = UIColor.red.cgColor
                buttonView.buttonState = .disable
                titleLabel.textColor = .red
                titleLabel.text = "อยู่ห่างเกินไป"
            } else if distanceInCm < 28 {
                faceRectangleLayer.strokeColor = UIColor.red.cgColor
                buttonView.buttonState = .disable
                titleLabel.textColor = .red
                titleLabel.text = "อยู่ใกล้เกินไป"
            } else {
                faceRectangleLayer.strokeColor = UIColor.green.cgColor
                buttonView.buttonState = .active
                titleLabel.text = "กดปุ่มเพื่อทดสอบ"
                titleLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
            }

        } else {
            // หากไม่พบใบหน้า ลบกรอบสี่เหลี่ยม
            faceRectangleLayer.path = nil
            faceRectangleLayer.strokeColor = UIColor.clear.cgColor
        }
    }
}

extension EyeTestOnboardingViewController: NavigationBarDelegate {
    func navigationBackButtonDidTap(_ navigation: NavigationBar) {
        navigationController?.popViewController(animated: true)
    }
}
