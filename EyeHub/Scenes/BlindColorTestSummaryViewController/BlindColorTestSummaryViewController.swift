//
//  BlindColorTestSummaryViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 8/5/2567 BE.
//

import UIKit

class BlindColorTestSummaryViewController: UIViewController {
    @IBOutlet weak var navigationBarView: NavigationBar!
    @IBOutlet weak var suggestMessageBoxView: MessageBox!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var coverImage:  UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet var titleLabel: [UILabel]!
    @IBOutlet weak var collectionView: CollectionView!
    var testResult: [BlindColorResult]
    var lastTestResult: BlindColorResult
    var countDict = [BlindColorResult: Int]()
    let collectionMenuList: [HospitalNearMeModel] = [HospitalNearMeModel(image: "hospitalNearMe1", title: "Lesik Center โรงพยาบาลพระราม 9", description: "99 ซอย โรงพยาบาลพระราม 9 ถนนพระราม 9 แขวงบางกะปิ เขตห้วยขวาง กรุงเทพมหานคร 10310"), HospitalNearMeModel(image: "hospitalNearMe", title: "โรงพยาบาลจักษุ รัตนิน", description: "80/1 ถ. สุขุมวิท แขวงคลองเตยเหนือ เขตวัฒนา กรุงเทพมหานคร 10110"), HospitalNearMeModel(image: "hospitalNearMe", title: "โรงพยาบาลจักษุ รัตนิน", description: "80/1 ถ. สุขุมวิท แขวงคลองเตยเหนือ เขตวัฒนา กรุงเทพมหานคร 10110"), HospitalNearMeModel(image: "hospitalNearMe", title: "โรงพยาบาลจักษุ รัตนิน", description: "80/1 ถ. สุขุมวิท แขวงคลองเตยเหนือ เขตวัฒนา กรุงเทพมหานคร 10110")]
    
    init(testResult: [BlindColorResult]) {
        self.testResult = testResult

        for item in testResult {
            if let count = countDict[item] {
                countDict[item] = count + 1
            } else {
                countDict[item] = 1
            }
        }

        var maxCount = 0
        var mostRepeatedCase: BlindColorResult?

        for (key, value) in countDict {
            if value > maxCount {
                maxCount = value
                mostRepeatedCase = key
            }
        }

        if let mostRepeatedCase = mostRepeatedCase {
            print("Case ที่ปรากฏซ้ำกันมากที่สุดคือ \(mostRepeatedCase) และปรากฏ \(maxCount) ครั้ง")
        }
        self.lastTestResult = mostRepeatedCase ?? .normal
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

extension BlindColorTestSummaryViewController: NavigationBarDelegate {
    func navigationBackButtonDidTap(_ navigation: NavigationBar) {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}

extension BlindColorTestSummaryViewController {
    func commonInit() {
        setUpUI()
    }
    
    func resultUpdate() {
        resultLabel.text = lastTestResult.result
        descriptionLabel.text = lastTestResult.description
    }
    
    func setUpUI() {
        let collectionViewModel: [CollectionViewType] = collectionMenuList
            .map {
                .hospitalNearMe(viewModel: HospitalNearMeModel(image: $0.image, title: $0.title, description: $0.description))
            }
        collectionView.setCollectionView(viewModels: collectionViewModel)
        
        self.view.backgroundColor = UIColor.white
        coverImage.image = UIImage(named: "ColorIcon") ?? UIImage()
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

