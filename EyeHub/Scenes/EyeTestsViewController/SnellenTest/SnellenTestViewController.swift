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
    var totalTime = 5
    var currentTime = 0
    var questionArr: [String] = []
    var correctAnswer: Int?
    var score: Int = 0
    @IBOutlet weak var testStateLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var testStackView: UIStackView!
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
    private let answerViewController = BottomSheetViewController()
    
    @IBAction func testButtonAction(_ sender: Any) {
        if currentTestIndex+1 <= testData.count {
//            let answerBottomSheet = BottomSheetViewController()
//            createQuestion()
//            answerBottomSheet.delegate = self
//            answerBottomSheet.model = questionArr
//            presentPanModal(answerBottomSheet)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
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
    func didSelectRow(indexPath: Int) {
        print("Selected item name: \(indexPath)")
//        currentTestIndex += 1
//        progressBarView.setProgress(1, animated: false)
//        questionArr.removeAll()
//        startTestWithDelay()
//        if correctAnswer == indexPath {
//            score += 1
//            debugPrint("ตอบถูก")
//        }
//        debugPrint("คะแนนซ \(score)")
    }
}

extension SnellenTestViewController {
    func commonInit() {
        setUpUI()
        startTestWithDelay()
    }
    
    func createQuestion() {
        questionArr.append(contentsOf: testData[currentTestIndex].wrongTestText)
        let randomIndex = Int.random(in: 0..<4)
        correctAnswer = randomIndex
        questionArr.insert(testData[currentTestIndex].testText, at: randomIndex)
        questionArr.append("ไม่แน่ใจ")
    }
    
    func startTestWithDelay() {
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
        let answerBottomSheet = BottomSheetViewController()
        createQuestion()
        answerBottomSheet.delegate = self
        answerBottomSheet.model = questionArr
        presentPanModal(answerBottomSheet)
    }
    
    func setUpUI() {
        progressBarView.progress = 1
        buttonView.isEnabled = false
        testStackView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        self.view.backgroundColor =  UIColor.white
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        testStateLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        testStateLabel.font = FontFamily.Kanit.medium.font(size: 40)
        progressBarView.tintColor = UIColor(cgColor: EyeHubColor.primaryColor)
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
        
        navigationBarView.set(title: "ทดสอบสายตา")
        navigationBarView.delegate = self
    }
}