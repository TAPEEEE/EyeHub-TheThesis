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
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet weak var bottomSheetButtonView: PrimaryButton!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var navigationBarView: NavigationBar!
    @IBOutlet weak var onboardingScrollView: UIScrollView!
    @IBOutlet weak var requireHeadphoneView: UIView!
    @IBOutlet weak var requireVolumeView: UIView!
    @IBOutlet weak var onboardingPageControl: UIPageControl!
    
    let contentModel: [onBoardingContent] = [
        onBoardingContent(title: "", description: "เชื่อมต่อหูฟังและกดปุ่มถัดไปเพื่อเริ่มทำแบบทดสอบวัด ระดับการได้ยินของหู"),
        onBoardingContent(title: "กรุณาเพิ่มเสียง", description: "กรุณาปรับเสียงของหูฟังของคุณให้อยู่ในระดับสูงสุดเพื่อใช้ในการทดสอบ"),
        onBoardingContent(title: "กรุณาอยู่ในสถานที่ที่เงียบ", description: "กรุณาอยู่ในสภาพแวดล้อมที่เหมาะสมเพื่อผลการทดสอบที่แม่นยำ")
    ]
    
    private var currentPage = 0 {
        didSet {
            if currentPage > 1 {
                bottomSheetButtonView.setUp(.textOnly(text: "เริ่มทดสอบ"), type: .primary, size: .large)
            }
        }
    }
    
    var hp: Bool = false
    
    // MARK: - Properties
    private var viewModel = HearingTestViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        commonInit()
        viewModel.checkHeadphoneConnection()
        onboardingScrollView.isPagingEnabled = true
        setupNotifications()
    }
    
    func setupNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                       selector: #selector(handleRouteChange),
                       name: AVAudioSession.routeChangeNotification,
                       object: nil)
    }


    @objc func handleRouteChange(notification: Notification) {
        print(viewModel.isHeadphoneConnected())
        self.viewModel.checkHeadphoneConnection()
        self.updateUIForHeadphoneConnection(viewModel.isHeadphoneConnected())
    }
    
    let audioSession = AVAudioSession.sharedInstance()
    
    func listenVolumeButton() {
        do {
            try audioSession.setActive(true)
        } catch {
            print("some error")
        }
        audioSession.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "outputVolume" {
            let vol = AVAudioSession.sharedInstance().outputVolume
            print(vol)
        }
    }
    
    // MARK: - Private Methods
    private func commonInit() {
        setUpUI()
//        headPhoneTriggerTimer()
        let demoButtontapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(demoVoice)
        )
        bottomSheetButtonView.addGestureRecognizer(demoButtontapGesture)
    }
    
//    private func headPhoneTriggerTimer() {
//        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
//            switch self?.currentPage {
//            case 0:
//                self?.viewModel.checkHeadphoneConnection()
//            case 1:
//                self?.listenVolumeButton()
//            default:
//                print("aa")
//            }
//        }
//    }
    
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
    
    func updateBottomSheetContent() {
        titleLabel.text = contentModel[currentPage].title
        descriptionLabel.text = contentModel[currentPage].description
    }
    
    
    func leftButtonTapped() {
        if onboardingScrollView.contentOffset.x < bottomSheetView.frame.width * 2 {
            UIView.animate(withDuration: 0.3, animations: {
                self.onboardingScrollView.contentOffset.x += self.requireHeadphoneView.frame.width
                self.currentPage += 1
                self.updateBottomSheetContent()
            })
        }
    }
    
    @objc func demoVoice() {
        leftButtonTapped()
        onboardingPageControl.currentPage = currentPage
    }
    
    private func setUpUI() {
        animationView.play()
        animationView.loopMode = .loop
        self.view.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        bottomSheetButtonView.setUp(.textOnly(text: "ถัดไป"), type: .primary, size: .large)
        titleLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        titleLabel.font = FontFamily.Kanit.medium.font(size: 18)
        
        descriptionLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        descriptionLabel.font = FontFamily.Kanit.light.font(size: 16)
        
        
        navigationBarView.set(title: "ทดสอบระดับการได้ยิน")
        navigationBarView.delegate = self
    }
}

extension HearingViewController: NavigationBarDelegate {
    func navigationBackButtonDidTap(_ navigation: NavigationBar) {
        viewModel.backButtonTapped()
    }
}
