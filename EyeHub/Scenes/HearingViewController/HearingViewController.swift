//
//  HearingViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 15/2/2567 BE.
//

import UIKit
import AVFAudio
import Lottie

class HearingViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: [UILabel]!
    @IBOutlet weak var bottomSheetButtonView: PrimaryButton!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var navigationBarView: NavigationBar!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

extension HearingViewController: NavigationBarDelegate {
    func navigationBackButtonDidTap(_ navigation: NavigationBar) {
        navigationController?.popViewController(animated: true)
    }
}

private extension HearingViewController {
    
    func commonInit() {
        setUpUI()
        headPhoneTiggerTimer()
        uiTiggerHeadphoneConnected()
    }
    
    func headPhoneTiggerTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { _ in
            self.uiTiggerHeadphoneConnected()
        })
    }
    
    func setUpUI() {
        animationView.play()
        animationView.loopMode = .loop
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
        
        bottomSheetButtonView.setUp(.textOnly(text: "ถัดไป"), type: .primary, size: .large)
        
        titleLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        titleLabel.font = FontFamily.Kanit.medium.font(size: 18)
        
        descriptionLabel.forEach {
            $0.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
            $0.font = FontFamily.Kanit.light.font(size: 14)
        }
        
        navigationBarView.set(title: "ทดสอบระดับการได้ยิน")
        navigationBarView.delegate = self
    }
   
    func uiTiggerHeadphoneConnected() {
        animationView.isHidden = isHeadphoneConnected()
        ? true
        : false
        
        bottomSheetButtonView.buttonState = isHeadphoneConnected() 
        ? .active
        : .disable
        
        titleLabel.text = isHeadphoneConnected()
        ? "เชื่อมต่อหูฟังสำเร็จ"
        : "กรุณาเชื่อมต่อหูฟัง"
    }
    
    func isHeadphoneConnected() -> Bool {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .allowBluetooth)
            
            if audioSession.availableInputs?.first(where: { $0.portType == .bluetoothHFP }) != nil {
                return true
            }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}

