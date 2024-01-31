//
//  HomeViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 28/1/2567 BE.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var btn: PrimaryButton!
    @IBOutlet var titleLabel: [UILabel]!
    @IBOutlet var descriptionLabel: [UILabel]!
    @IBOutlet var categoriesLabel: [UILabel]!
    @IBOutlet weak var snellenButtonView: HomeMenuButton!
    @IBOutlet weak var landoltCButtonView: HomeMenuButton!
    @IBOutlet weak var TumblingEButtonView: HomeMenuButton!
    @IBOutlet weak var colorButtonView: HomeMenuButton!
    @IBOutlet weak var contrastButtonView: HomeMenuButton!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var categoriesView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

private extension HomeViewController {
    func commonInit() {
        setUpUI()
        let demoButtontapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(demoVoice)
        )
        btn.addGestureRecognizer(demoButtontapGesture)
    }
    
    @objc func demoVoice() {
        let scene = VoiceConceptViewController(nibName: String(describing: VoiceConceptViewController.self), bundle: .main)
        navigationController?.pushViewController(scene, animated: true)
    }
    
    func printText() {
        print("aaa")
    }
    
    func setUpUI() {
        btn.setUp(.textOnly(text: "Demo เสียง"), type: .primary, size: .large)
        
        snellenButtonView.setup(viewModel:
                                    HomeMenuButtonViewModel(
                                        tagId: 1,
                                        title: "Snellen",
                                        state: .active,
                                        icon: UIImage(named: "SnellenIcon") ?? UIImage()
                                    )
        ) { tagId in
            debugPrint("Clickable icon did tapped with tagId: \(tagId)")
        }
        
        landoltCButtonView.setup(viewModel:
                                    HomeMenuButtonViewModel(
                                        tagId: 2,
                                        title: "Landolt C",
                                        state: .active,
                                        icon: UIImage(named: "CChartIcon") ?? UIImage()
                                    )
        ) { tagId in
            debugPrint("Clickable icon did tapped with tagId: \(tagId)")
        }
        
        TumblingEButtonView.setup(viewModel:
                                    HomeMenuButtonViewModel(
                                        tagId: 3,
                                        title: "Tumbling E",
                                        state: .active,
                                        icon: UIImage(named: "EChartIcon") ?? UIImage()
                                    )
        ) { tagId in
            debugPrint("Clickable icon did tapped with tagId: \(tagId)")
        }
        
        colorButtonView.setup(viewModel:
                                    HomeMenuButtonViewModel(
                                        tagId: 4,
                                        title: "Color",
                                        state: .active,
                                        icon: UIImage(named: "ColorIcon") ?? UIImage()
                                    )
        ) { tagId in
            debugPrint("Clickable icon did tapped with tagId: \(tagId)")
        }
        
        contrastButtonView.setup(viewModel:
                                    HomeMenuButtonViewModel(
                                        tagId: 5,
                                        title: "Contrast",
                                        state: .active,
                                        icon: UIImage(named: "ContrastIcon") ?? UIImage()
                                    )
        ) { tagId in
            debugPrint("Clickable icon did tapped with tagId: \(tagId)")
        }
        
        headerLabel.font = FontFamily.Kanit.medium.font(size: 20)
        headerLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        
        titleLabel.forEach {
            $0.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
            $0.font = FontFamily.Kanit.medium.font(size: 16)
        }
        
        descriptionLabel.forEach {
            $0.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
            $0.font = FontFamily.Kanit.light.font(size: 14)
        }
        
        //        categoriesLabel.forEach {
        //            $0.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        //            $0.font = FontFamily.Kanit.medium.font(size: 12)
        //        }
        
        bannerImageView.layer.cornerRadius = EyeHubRadius.radius16
        bannerImageView.image = UIImage(named: "GardientView")
        bannerImageView.contentMode = .scaleAspectFill
        
        categoriesView.backgroundColor = UIColor.white
        categoriesView.layer.cornerRadius = EyeHubRadius.radius8
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
        self.view.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
    }
}
