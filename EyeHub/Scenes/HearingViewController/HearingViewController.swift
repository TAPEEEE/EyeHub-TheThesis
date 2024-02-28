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
    
    // MARK: - Properties
    private var viewModel = HearingTestViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        commonInit()
        viewModel.checkHeadphoneConnection()
    }
    
    // MARK: - Private Methods
    private func commonInit() {
        setUpUI()
        headPhoneTriggerTimer()
    }
    
    
    private func headPhoneTriggerTimer() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            self?.viewModel.checkHeadphoneConnection()
        }
    }
    
    private func setupBindings() {
        viewModel.onHeadphoneConnectionChanged = { [weak self] isConnected in
            self?.updateUIForHeadphoneConnection(isConnected)
        }
        
        viewModel.onNavigationBackButtonTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func updateUIForHeadphoneConnection(_ isConnected: Bool) {
        animationView.isHidden = isConnected
        bottomSheetButtonView.buttonState = isConnected ? .active : .disable
        titleLabel.text = isConnected ? "เชื่อมต่อหูฟังสำเร็จ" : "กรุณาเชื่อมต่อหูฟัง"
    }
    
    private func setUpUI() {
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
}

extension HearingViewController: NavigationBarDelegate {
    func navigationBackButtonDidTap(_ navigation: NavigationBar) {
        viewModel.backButtonTapped()
    }
}
