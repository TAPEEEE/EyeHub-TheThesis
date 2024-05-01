//
//  EyeTestsSummaryViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 1/5/2567 BE.
//

import UIKit

class EyeTestsSummaryViewController: UIViewController {
    @IBOutlet weak var navigationBarView: NavigationBar!
    @IBOutlet weak var suggestMessageBoxView: MessageBox!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var coverImage:  UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet var titleLabel: [UILabel]!
    var testResult: [String: Int]
    var testType: EyeTestsType
    
    init(testType: EyeTestsType, testResult: [String: Int]) {
        self.testResult = testResult
        self.testType = testType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        resultUpdate()
    }
}

extension EyeTestsSummaryViewController: NavigationBarDelegate {
    func navigationBackButtonDidTap(_ navigation: NavigationBar) {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}

extension EyeTestsSummaryViewController {
    func commonInit() {
        setUpUI()
    }
    
    func resultUpdate() {
        switch testType {
        case .snellen:
            resultLabel.text = SnellenTestResult.evaluate(leftEyeScore: testResult["leftEye"]!, rightEyeScore: testResult["rightEye"]!).title
            descriptionLabel.text = SnellenTestResult.evaluate(leftEyeScore: testResult["leftEye"]!, rightEyeScore: testResult["rightEye"]!).description
        case .landoltC:
            resultLabel.text = SnellenTestResult.evaluate(leftEyeScore: testResult["leftEye"]!, rightEyeScore: testResult["rightEye"]!).title
            descriptionLabel.text = SnellenTestResult.evaluate(leftEyeScore: testResult["leftEye"]!, rightEyeScore: testResult["rightEye"]!).description
        case .tumblingE:
            resultLabel.text = SnellenTestResult.evaluate(leftEyeScore: testResult["leftEye"]!, rightEyeScore: testResult["rightEye"]!).title
            descriptionLabel.text = SnellenTestResult.evaluate(leftEyeScore: testResult["leftEye"]!, rightEyeScore: testResult["rightEye"]!).description
        }
    }
    
    func setUpUI() {
        self.view.backgroundColor = UIColor.white
        coverImage.image = testType.coverImage
        resultLabel.font = FontFamily.Kanit.medium.font(size: 24)
        headingLabel.font = FontFamily.Kanit.medium.font(size: 16)
        descriptionLabel.font = FontFamily.Kanit.regular.font(size: 14)
        
        resultLabel.textColor = UIColor(cgColor: EyeHubColor.pinkColor)
        headingLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        descriptionLabel.textColor = UIColor(cgColor: EyeHubColor.textDescriptionColor)

        suggestMessageBoxView.setUp(type: .warning, title: "การทดสอบเป็นการคัดกรองแบบเบื้องต้นเท่านั้น", description: "เพื่อความถูกต้องแม่นยำมากขึ้นท่านสามารถปรึกษานักทัศนมาตรหรือแพทย์ผู้เชี่ยวชาญเพื่อตรวจอย่างละเอียด")
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        navigationBarView.set(title: "ผลการทดสอบ")
        navigationBarView.delegate = self
    }
}
