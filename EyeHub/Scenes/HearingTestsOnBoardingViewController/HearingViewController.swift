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
    @IBOutlet weak var firstPageButtonView: PrimaryButton!
    @IBOutlet weak var seccondPageButtonView: PrimaryButton!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var headPhoneView: LottieAnimationView!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var navigationBarView: NavigationBar!
    @IBOutlet weak var onboardingScrollView: UIScrollView!
    @IBOutlet weak var requireHeadphoneView: UIView!
    @IBOutlet weak var requireVolumeView: UIView!
    @IBOutlet weak var onboardingPageControl: UIPageControl!
    
    let contentModel: [onBoardingContent] = [
        onBoardingContent(title: "กรุณาเชื่อมต่อหูฟัง", description: "เชื่อมต่อหูฟังและกดปุ่มถัดไปเพื่อเริ่มทำแบบทดสอบวัด ระดับการได้ยินของหู"),
        onBoardingContent(title: "กรุณาเพิ่มเสียงในระดับสูงสุด", description: "กรุณาปรับเสียงของหูฟังของคุณให้อยู่ในระดับสูงสุดเพื่อใช้ในการทดสอบ")
//        onBoardingContent(title: "กรุณาอยู่ในสถานที่ที่เงียบ", description: "กรุณาอยู่ในสภาพแวดล้อมที่เหมาะสมเพื่อผลการทดสอบที่แม่นยำ")
    ]
    
    private var currentPage = 0 {
        didSet {
            if currentPage == 1 {
                seccondPageButtonView.isHidden = false
                headPhoneView.play()
                headPhoneView.loopMode = .loop
            }
        }
    }
    
    // MARK: - Properties
    private var viewModel = HearingTestViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        commonInit()
        viewModel.checkHeadphoneConnection()
        initialVolumeMax()
        onboardingScrollView.isPagingEnabled = true
        setupNotifications()
    }
    
    func initialVolumeMax() {
        if currentPage != 0 {
            viewModel.checkVolumeMax()
        }
    }
    
    func setupNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(handleRouteChange),
                                       name: AVAudioSession.routeChangeNotification,
                                       object: nil)
    }
    
    @objc func volumeChanged(notification: NSNotification) {
        let volume = notification.userInfo!["AVSystemController_AudioVolumeNotificationParameter"] as! Float
        print("Volume value:\(volume)")

        //Get the slider by its tag
        let volumeView = self.view.viewWithTag(100) as! UISlider
        //Update the slider value to correspond to the volume
        volumeView.value = volume
    }

    deinit {
        // Don't forget to remove the observer
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name("AVSystemController_SystemVolumeDidChangeNotification"),
                                                  object: nil)
    }

    func handleOutputVolumeChange() {
        self.seccondPageButtonView.buttonState = .disable
        self.viewModel.checkVolumeMax()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    @objc func handleRouteChange(notification: Notification) {
        self.viewModel.checkHeadphoneConnection()
    }
    
    let audioSession = AVAudioSession.sharedInstance()

    // MARK: - Private Methods
    private func commonInit() {
        setUpUI()
        let demoButtontapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(demoVoice)
        )
        firstPageButtonView.addGestureRecognizer(demoButtontapGesture)
        let startButton = UITapGestureRecognizer(
            target: self,
            action: #selector(startTestAction)
        )
        seccondPageButtonView.addGestureRecognizer(startButton)
    }
    
    private func setupBindings() {
        viewModel.onHeadphoneConnectionChanged = { [weak self] isConnected in
            self?.updateUIForHeadphoneConnection(isConnected)
        }
        
        viewModel.onVolumeChanged = { [weak self] isMax in
            self?.updateUIForVolumeMax(isMax)
        }
        
        viewModel.onNavigationBackButtonTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func updateUIForHeadphoneConnection(_ isConnected: Bool) {
        animationView.isHidden = isConnected
        firstPageButtonView.buttonState = isConnected ? .active : .disable
    }
    
    private func updateUIForVolumeMax(_ isMax: Bool) {
        seccondPageButtonView.buttonState = isMax ? .active : .disable
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
    
    @objc func startTestAction() {
        let navigationVC = HearingTestViewController()
        navigationController?.pushViewController(navigationVC, animated: true)
    }
    
    private func setUpUI() {
        seccondPageButtonView.setUp(.textOnly(text: "เริ่มทดสอบ"), type: .primary, size: .large)
        seccondPageButtonView.isHidden = true
        animationView.play()
        animationView.loopMode = .loop
        self.view.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        firstPageButtonView.setUp(.textOnly(text: "ถัดไป"), type: .primary, size: .large)
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

