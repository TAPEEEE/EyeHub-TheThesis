//
//  TumblingETestViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 4/5/2567 BE.
//

import UIKit
import AVFoundation

class TumblingETestViewController: UIViewController {
    let testData: [TumblingETestData] = TumblingETestData.allCases
    var currentTestIndex = 0
    var timer: Timer?
    var audioPlayer: AVAudioPlayer?
    var totalTime = 1
    var currentTime = 0
    var questionArr: [EandCModel] = []
    var correctAnswer: Int?
    var score: Int = 0
    var currentKey: String = "leftEye"
    var testResults: [String: Int] = ["leftEye": 0, "rightEye": 0]
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var testStackView: UIStackView!
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var navigationBarView: NavigationBar!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet var titleLabel: [UILabel]!
    @IBOutlet var descriptionLabel: [UILabel]!
    private let answerViewController = CollectionViewAnswerBottomSheetViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

extension TumblingETestViewController: NavigationBarDelegate {
    func navigationBackButtonDidTap(_ navigation: NavigationBar) {
        navigationController?.popViewController(animated: true)
    }
}

extension TumblingETestViewController: CollectionViewBottomSheetDelegate {
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

private extension TumblingETestViewController {
    func commonInit() {
        setUpUI()
        playSound(soundFileName: "firstEyeTest")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
            startTestWithDelay()
        }
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
        playSound(soundFileName: "seccondEyeTest")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
            startTestWithDelay()
        }
    }
    
    func navigateToSummary() {
        let newViewController = EyeTestsSummaryViewController(testType: .tumblingE, testResult: testResults)
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func createQuestion() {
        let testRotation = testData[currentTestIndex].testRotation
        let wrongRotations = testData[currentTestIndex].wrongRotation
        
        for rotation in wrongRotations {
            questionArr.append(EandCModel(text: CollectionViewTestType.tumblingE, transform: rotation))
        }
        
        let randomIndex = Int.random(in: 0..<wrongRotations.count + 1)
        correctAnswer = randomIndex
        
        questionArr.insert(EandCModel(text: CollectionViewTestType.tumblingE, transform: testRotation), at: randomIndex)
        answerViewController.model = questionArr
    }
    
    func startTestWithDelay() {
        if currentTestIndex == testData.count && currentKey == "rightEye" {
            navigateToSummary()
            return
        }
        let testValue = testData[currentTestIndex]
        testLabel.font = FontFamily.Kanit.medium.font(size: testData[currentTestIndex].rawValue)
        switch testValue.testRotation {
        case .degree0:
            testLabel.transform = CGAffineTransform(rotationAngle: 0)
        case .degree90:
            testLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        case .degree180:
            testLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        case .degree270:
            testLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        }
        
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
        let answerBottomSheet = CollectionViewAnswerBottomSheetViewController()
        createQuestion()
        
        DispatchQueue.main.async {
            answerBottomSheet.delegate = self
            answerBottomSheet.model = self.questionArr
        }
        presentPanModal(answerBottomSheet)
    }
    
    func switchToRightEyeTest() {
        currentKey = "rightEye"
        //        testStateLabel.text = "สลับข้าง"
        //        testStateLabel.font = FontFamily.Kanit.medium.font(size: 56)
        score = 0
        currentTestIndex = 0
    }
    
    func playSound(soundFileName: String) {
        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else {
            print("Sound file not found.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func setUpUI() {
        progressBarView.progress = 1
        testStackView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        self.view.backgroundColor =  UIColor.white
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        //        testStateLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        //        testStateLabel.font = FontFamily.Kanit.medium.font(size: 40)
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
