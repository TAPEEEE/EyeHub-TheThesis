//
//  SnellenTestViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 24/4/2567 BE.
//

import UIKit
import PanModal

class SnellenTestViewController: UIViewController {
    let testData: [SnellenTestData] = SnellenTestData.allCases
    var currentTestIndex = 0
    var timer: Timer?
    var totalTime = 1
    var currentTime = 0
    var questionArr: [String] = []
    var correctAnswer: Int?
    var score: Int = 0
    var currentKey: String = "leftEye"
    var testResults: [String: Int] = ["leftEye": 0, "rightEye": 0]
    @IBOutlet weak var testStateLabel: UILabel!
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

extension SnellenTestViewController: NavigationBarDelegate {
    func navigationBackButtonDidTap(_ navigation: NavigationBar) {
        navigationController?.popViewController(animated: true)
    }
}

extension SnellenTestViewController: BottomSheetDelegate {
    func didSelectRow(indexPath: Int, value: String) {
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

private extension SnellenTestViewController {
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
        switchToRightEyeTest()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
            startTestWithDelay()
        }
    }
    
    func navigateToSummary() {
        let newViewController = EyeTestsSummaryViewController(testType: .snellen, testResult: testResults)
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func createQuestion() {
        questionArr.append(contentsOf: testData[currentTestIndex].wrongTestText)
        let randomIndex = Int.random(in: 0..<4)
        correctAnswer = randomIndex
        questionArr.insert(testData[currentTestIndex].testText, at: randomIndex)
        questionArr.append("มองไม่ชัด")
    }
    
    func startTestWithDelay() {
        if currentTestIndex == testData.count && currentKey == "rightEye" {
            navigateToSummary()
            return
        }
        let textTestValue = testData[currentTestIndex]
        testStateLabel.font = FontFamily.Kanit.medium.font(size: testData[currentTestIndex].rawValue)
        testStateLabel.text = textTestValue.testText
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
            presentAnserBottomSheet()
        }
    }
    
    private func presentAnserBottomSheet() {
        let answerBottomSheet = AnswerBottomSheetViewController()
        createQuestion()
        
        answerBottomSheet.delegate = self
        answerBottomSheet.model = self.questionArr
        
        DispatchQueue.main.async {
            self.presentPanModal(answerBottomSheet)
        }
    }
    
    func switchToRightEyeTest() {
        currentKey = "rightEye"
        testStateLabel.text = "สลับข้าง"
        testStateLabel.font = FontFamily.Kanit.medium.font(size: 56)
        score = 0
        currentTestIndex = 0
    }
    
    func setUpUI() {
        progressBarView.progress = 1
        testStackView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        self.view.backgroundColor =  UIColor.white
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        testStateLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        testStateLabel.font = FontFamily.Kanit.medium.font(size: 40)
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
