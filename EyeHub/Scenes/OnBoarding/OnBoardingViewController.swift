//
//  OnBoardingViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 28/1/2567 BE.
//

import UIKit

class OnBoardingViewController: UIViewController, OnBoardingDelegate {
    func navigationBackButtonDidTap(_ navigation: OnBoarding) {
        let scene = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: .main)
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @IBOutlet weak var onboardingView: OnBoarding!
    let modelList = [OnbaordingViewModel(title: "ตรวจสายตาแบบเบื้องต้นด้วยตนเอง", description: "ตรวจสายตาแบบเบื้องต้นด้วยตัวเอง หลากหลายรูปแบบใช้เวลาตรวจไม่นาน", content: "obd1"), OnbaordingViewModel(title: "ตรวจการรับรู้สีและตาบอดสีี", description: "ตรวจปัญหาการรับรู้ทั้งตาบอดสีและการแยกสีเบื้องต้นพร้อมทั้งสรุปผลในที่เดียว", content: "obd2"),OnbaordingViewModel(title: "ตรวจคุณภาพหูตามวัยพร้อมทั้งภาวะหูตึง", description: "ตรวจคุณภาพหูตามวัยและความผิดปกติของหูด้วยกราฟ Audiogram", content: "obd3")]
                                                    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        
    }
}

private extension OnBoardingViewController {
    func commonInit() {
        setUpUI()
        onboardingView.setUp(model: modelList)
        onboardingView.delegate = self
    }
    
    func setUpUI() {
        self.view.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
    }
}
