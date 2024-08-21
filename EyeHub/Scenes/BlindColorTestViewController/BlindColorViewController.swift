//
//  BlindColorViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 7/5/2567 BE.
//

import UIKit

class BlindColorViewController: UIViewController {
    private let testData: [BlindColorTestData] = BlindColorTestData.allCases
    private var currentTestIndex = 0
    private var timer: Timer?
    private var totalTime = 3
    private var currentTime = 0
    private var questionArr: [String] = []
    private var testResults: [BlindColorResult] = []
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var testStackView: UIStackView!
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var navigationBarView: NavigationBar!
    @IBOutlet var titleLabel: [UILabel]!
    @IBOutlet var descriptionLabel: [UILabel]!
    private let answerViewController = AnswerBottomSheetViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

extension BlindColorViewController: NavigationBarDelegate {
    func navigationBackButtonDidTap(_ navigation: NavigationBar) {
        navigationController?.popViewController(animated: true)
    }
}

extension BlindColorViewController: BottomSheetDelegate {
    func didSelectRow(indexPath: Int, value: String) {
        updateTestProgress()
        dismiss(animated: true, completion: nil)
        testResults.append(calculate(indexPath: indexPath, value: value))
        if isEndOfTest() {
            navigateToSummary()
        } else {
            startTestWithDelay()
        }
        print(testResults)
    }
}

private extension BlindColorViewController {
    func commonInit() {
        setUpUI()
        startTestWithDelay()
    }
    
    private func updateTestProgress() {
        currentTestIndex += 1
        progressBarView.setProgress(1, animated: false)
        questionArr.removeAll()
    }
    
    private func calculate(indexPath: Int, value: String) -> BlindColorResult {
        let result: BlindColorResult
        switch value {
        case testData[currentTestIndex-1].normal:
            result = .normal
        case testData[currentTestIndex-1].redAndGreenBlind:
            if indexPath != 2  {
                result = .redandbreenBlind
            } else {
                result = .blindColor
            }
        case testData[currentTestIndex-1].blindColor:
            result = .blindColor
        default:
            result = .noneCase
        }
        return result
    }
    
    private func isEndOfTest() -> Bool {
        return currentTestIndex == testData.count
    }
    
    
    func navigateToSummary() {
        let newViewController = BlindColorTestSummaryViewController(testResult: testResults)
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func createQuestion() {
        questionArr.append(contentsOf: testData[currentTestIndex].choiceAnswer)
    }
    
    func startTestWithDelay() {
        if currentTestIndex == testData.count {
            navigateToSummary()
            return
        }
        
        testImage.image = testData[currentTestIndex].imagePlate
        timer?.invalidate()
        currentTime = totalTime
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        currentTime -= 1
        let progress = Float(currentTime) / Float(totalTime)
        UIView.animate(withDuration: 1.0) {
            self.progressBarView.setProgress(progress, animated: true)
        }
        
        if currentTime <= 0 {
            timer?.invalidate()
            presentAnswerBottomSheet()
        }
    }
    
    private func presentAnswerBottomSheet() {
        let answerBottomSheet = AnswerBottomSheetViewController()
        createQuestion()
        answerBottomSheet.delegate = self
        answerBottomSheet.model = self.questionArr
        DispatchQueue.main.async {
            self.presentPanModal(answerBottomSheet)
        }
    }
    
    func setUpUI() {
        testImage.layer.cornerRadius = testImage.frame.height/2
        progressBarView.progress = 1
        testStackView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        self.view.backgroundColor =  UIColor.white
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        progressBarView.tintColor = UIColor(cgColor: EyeHubColor.primaryColor)
        
        titleLabel.forEach {
            $0.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
            $0.font = FontFamily.Kanit.medium.font(size: 18)
        }
        
        descriptionLabel.forEach {
            $0.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
            $0.font = FontFamily.Kanit.light.font(size: 16)
        }
        
        navigationBarView.set(title: "ทดสอบสายตา")
        navigationBarView.delegate = self
    }
}
