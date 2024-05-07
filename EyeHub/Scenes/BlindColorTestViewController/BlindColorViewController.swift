//
//  BlindColorViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 7/5/2567 BE.
//

import UIKit

class BlindColorViewController: UIViewController {
    let testData: [BlindColorTestData] = BlindColorTestData.allCases
    var currentTestIndex = 0
    var timer: Timer?
    var totalTime = 5
    var currentTime = 0
    var questionArr: [String] = []
    var correctAnswer: Int?
    var score: Int = 0
    var currentKey: String = "leftEye"
    var testResults: [String: Int] = ["leftEye": 0, "rightEye": 0]
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
    func didSelectRow(indexPath: Int) {
        print("Selected item name: \(indexPath)")
        dismiss(animated: true, completion: nil)
        
        updateTestProgress()
        
        if isCorrectAnswer(indexPath) {
            handleCorrectAnswer()
        }
        
        if isEndOfTest() {
            switchToNextTest()
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

    private func isCorrectAnswer(_ indexPath: Int) -> Bool {
        return correctAnswer == indexPath
    }

    private func handleCorrectAnswer() {
        score += 1
        testResults[currentKey] = score
        debugPrint("✅")
    }

    private func isEndOfTest() -> Bool {
        return currentTestIndex == testData.count && currentKey == "leftEye"
    }

    private func switchToNextTest() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
            startTestWithDelay()
        }
    }
    
    func navigateToSummary() {
        let newViewController = EyeTestsSummaryViewController(testType: .snellen, testResult: testResults)
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

//        testStateLabel.font = FontFamily.Kanit.medium.font(size: testData[currentTestIndex].rawValue)
//        testStateLabel.text = textTestValue.testText
        
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
