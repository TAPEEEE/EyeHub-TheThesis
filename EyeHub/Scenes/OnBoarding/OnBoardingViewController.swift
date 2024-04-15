//
//  OnBoardingViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 28/1/2567 BE.
//

import UIKit

class OnBoardingViewController: UIViewController {
    @IBOutlet weak var onboardingView: OnBoarding!
    let modelList = [OnbaordingViewModel(title: "1", description: "vbnvbn", content: .lottieFile(lottie: "")), OnbaordingViewModel(title: "2", description: "vbnvbn", content: .lottieFile(lottie: "")),OnbaordingViewModel(title: "2", description: "vbnvbn", content: .lottieFile(lottie: ""))]
                                                        
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

private extension OnBoardingViewController {
    func commonInit() {
        setUpUI()
        onboardingView.setUp(model: modelList)
    }
    
    func setUpUI() {
        self.view.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
    }
}
