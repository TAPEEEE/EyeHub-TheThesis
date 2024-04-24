//
//  HearingTestViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 5/4/2567 BE.
//

import UIKit
import AVFoundation


//
// ไม่ได้แยก ViewModel
// ไม่ได้แยก ViewModel
// ไม่ได้แยก ViewModel
// ไม่ได้แยก ViewModel
//

class HearingTestViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?
    var decibel: Float = 4
    var currentEarKey = "leftEar"
    let testFrequencies: [TestFrequency] = TestFrequency.allCases
    var testResults: [String: [Int]] = ["leftEar": [], "RightEar": []]
    var currentTestIndex = 0
    var pan: Float = 1.0
    var viewModel = HearingViewModel()
    
    @IBOutlet weak var testStateLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var testCardView: UIView!
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var navigationBarView: NavigationBar!
    @IBOutlet weak var buttonView: UIButton! {
        didSet {
            buttonView.setTitleColor(UIColor.init(white: 1, alpha: 0.3), for: .disabled)
            buttonView.setTitleColor(UIColor.init(white: 1, alpha: 1), for: .normal)
        }
    }
    @IBOutlet var titleLabel: [UILabel]!
    @IBOutlet var descriptionLabel: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonView.isEnabled = false
        startTestWithDelay()
        setUpUI()
    }
    
   
    @IBAction func startTestAction(_ sender: Any) {
        guard currentTestIndex < testFrequencies.count else { return }

        if let currentTime = viewModel.stopSound() {
            appendDecibelValueToArray(decibel: Int(viewModel.calculateDecibel(x: currentTime)))
        }
        currentTestIndex += 1
        
        let progress = Float(currentTestIndex) / Float(testFrequencies.count)
        progressBarView.setProgress(progress, animated: true)
        
        if currentTestIndex == testFrequencies.count && currentEarKey == "leftEar" {
            switchToRightEarTest()
            progressBarView.setProgress(0, animated: true)
        } else if currentTestIndex == testFrequencies.count && currentEarKey == "RightEar" {
            buttonView.isEnabled = false
            navigateToSummary()
            return
        }
        if let resultsArray = testResults[currentEarKey], resultsArray.count == testFrequencies.count {
            return
        }
        buttonView.isEnabled = false
        startTestWithDelay()
    }
    
    func navigateToSummary() {
        let newViewController = HearingTestSummaryViewController(testResult: testResults)
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func appendDecibelValueToArray(decibel: Int) {
        if var existingArray = testResults[currentEarKey] {
            existingArray.append(decibel)
            testResults[currentEarKey] = existingArray
        } else {
            testResults[currentEarKey] = [decibel]
        }
    }
    
    func startTestWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            buttonView.isEnabled = true
            let frequency = testFrequencies[currentTestIndex].stringValue
            testStateLabel.text = frequency + " Hz"
            viewModel.playSound(soundFileName: frequency, pan: pan)
        }
        printTestResults()
    }
    
    func switchToRightEarTest() {
        currentEarKey = "RightEar"
        testStateLabel.text = "ทดสอบหูขวา"
        pan = -1.0
        currentTestIndex = 0
    }
    
    func printTestResults() {
        testResults.forEach { print("\($0): \($1)") }
    }
}

extension HearingTestViewController: NavigationBarDelegate {
    func navigationBackButtonDidTap(_ navigation: NavigationBar) {
        navigationController?.popViewController(animated: true)
    }
}

extension HearingTestViewController {
    func setUpUI() {
        testStateLabel.text = "ทดสอบหูซ้าย"
        self.view.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        testStateLabel.textColor = UIColor(cgColor: EyeHubColor.primaryColor)
        testStateLabel.font = FontFamily.Kanit.medium.font(size: 40)
        testCardView.layer.cornerRadius = EyeHubRadius.radius16
        progressBarView.tintColor = UIColor(cgColor: EyeHubColor.primaryColor)
        progressBarView.progress = 0
        buttonView.layer.backgroundColor = EyeHubColor.orangeColor
        buttonView.layer.cornerRadius = EyeHubRadius.radius16
        buttonView.titleLabel?.font = FontFamily.Kanit.medium.font(size: 24)
        
        titleLabel.forEach {
            $0.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
            $0.font = FontFamily.Kanit.medium.font(size: 18)
        }
        
        descriptionLabel.forEach {
            $0.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
            $0.font = FontFamily.Kanit.light.font(size: 16)
        }
        
        navigationBarView.set(title: "ทดสอบระดับการได้ยิน")
        navigationBarView.delegate = self
    }
}
