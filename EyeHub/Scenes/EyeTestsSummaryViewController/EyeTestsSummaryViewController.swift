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
    @IBOutlet weak var collectionView: CollectionView!
    var testResult: [String: Int]
    var testType: EyeTestsType
    let collectionMenuList: [HospitalNearMeModel] = [HospitalNearMeModel(image: "hospitalNearMe1", title: "Lesik Center โรงพยาบาลพระราม 9", description: "99 ซอย โรงพยาบาลพระราม 9 ถนนพระราม 9 แขวงบางกะปิ เขตห้วยขวาง กรุงเทพมหานคร 10310"), HospitalNearMeModel(image: "hospitalNearMe", title: "โรงพยาบาลจักษุ รัตนิน", description: "80/1 ถ. สุขุมวิท แขวงคลองเตยเหนือ เขตวัฒนา กรุงเทพมหานคร 10110"), HospitalNearMeModel(image: "hospitalNearMe", title: "โรงพยาบาลจักษุ รัตนิน", description: "80/1 ถ. สุขุมวิท แขวงคลองเตยเหนือ เขตวัฒนา กรุงเทพมหานคร 10110"), HospitalNearMeModel(image: "hospitalNearMe", title: "โรงพยาบาลจักษุ รัตนิน", description: "80/1 ถ. สุขุมวิท แขวงคลองเตยเหนือ เขตวัฒนา กรุงเทพมหานคร 10110")]
    
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
        var title = ""
        var description = ""
        
        if let leftEyeScore = testResult["leftEye"], let rightEyeScore = testResult["rightEye"] {
            let result = SnellenTestResult.evaluate(leftEyeScore: leftEyeScore, rightEyeScore: rightEyeScore)
            title = result.title
            description = result.description
            
            resultLabel.text = title
            descriptionLabel.text = description
        }
        
        UserDefaults.standard.set(title, forKey: "titleHistoryEyeTest")
        UserDefaults.standard.set(description, forKey: "descriptionHistoryEyeTest")
    }
    
    func setUpUI() {
        let collectionViewModel: [CollectionViewType] = collectionMenuList
            .map {
                .hospitalNearMe(viewModel: HospitalNearMeModel(image: $0.image, title: $0.title, description: $0.description))
            }
        collectionView.setCollectionView(viewModels: collectionViewModel)
        
        self.view.backgroundColor = UIColor.white
        coverImage.image = testType.coverImage
        resultLabel.font = FontFamily.Kanit.medium.font(size: 24)
        headingLabel.font = FontFamily.Kanit.medium.font(size: 16)
        descriptionLabel.font = FontFamily.Kanit.regular.font(size: 14)
        titleLabel.forEach {
            $0.font = FontFamily.Kanit.medium.font(size: 18)
            $0.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        }
        resultLabel.textColor = UIColor(cgColor: EyeHubColor.pinkColor)
        headingLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        descriptionLabel.textColor = UIColor(cgColor: EyeHubColor.textDescriptionColor)

        suggestMessageBoxView.setUp(type: .warning, title: "การทดสอบเป็นการคัดกรองแบบเบื้องต้นเท่านั้น", description: "เพื่อความถูกต้องแม่นยำมากขึ้นท่านสามารถปรึกษานักทัศนมาตรหรือแพทย์ผู้เชี่ยวชาญเพื่อตรวจอย่างละเอียด")
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        navigationBarView.set(title: "ผลการทดสอบ")
        navigationBarView.delegate = self
    }
}
