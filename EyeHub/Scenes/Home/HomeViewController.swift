//
//  HomeViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 28/1/2567 BE.
//

import HealthKit
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
    @IBOutlet var sectionView: [UIView]!
    @IBOutlet weak var collectionViewHorizontalView: CollectionView!
    @IBOutlet weak var historyTableView: TableView!
    @IBOutlet weak var contentView: UIView!
    
    let collectionMenuList: [HorizontalCollectionViewList] = HorizontalCollectionViewList.allCases
    let tableHistoryList: [TableViewList] = TableViewList.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        let collectionViewModel: [CollectionViewType] = collectionMenuList
            .map {
                .homeScreen(viewModel: HomeScreenCollectionViewCellViewModel(
                    title: $0.cardCell.title,
                    description: $0.cardCell.description,
                    icon: $0.cardCell.icon,
                    cardColor: $0.cardCell.cardColor
                )
                )
            }
        collectionViewHorizontalView.setCollectionView(viewModels: collectionViewModel)
        
        let tableViewModel: [TableViewType] = tableHistoryList
            .map {
                .historyTable(viewModel: HistoryTableViewCellViewModel(
                    title: $0.cardCell.title,
                    icon: $0.cardCell.icon
                )
                )
            }
        historyTableView.setTableView(viewModels: tableViewModel)
    }
}

extension HomeViewController: CollectionViewDelegate {
    func collectionView(_ view: CollectionView, didSelectRowAr index: Int) {
        let menu = collectionMenuList[index]
        let viewController = menu.viewController
            .init(
                nibName: String(describing: menu.viewController.self),
                bundle: .main
            )
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController: TableViewDelegate {
    func tableView(_ view: TableView, didSelectRowAr index: Int) {
        let menu = tableHistoryList[index]
        let viewController = menu.viewController
            .init(
                nibName: String(describing: menu.viewController.self),
                bundle: .main
            )
        navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension HomeViewController {
    func commonInit() {
        getPermission()
        setUpUI()
        let demoButtontapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(demoVoice)
        )
//        btn.addGestureRecognizer(demoButtontapGesture)
        collectionViewHorizontalView.delegate = self
        historyTableView.delegate = self
    }
    
    @objc func demoVoice() {
        let scene = VoiceConceptViewController(nibName: String(describing: VoiceConceptViewController.self), bundle: .main)
        navigationController?.pushViewController(scene, animated: true)
    }
    
    func getPermission() {

        let healthStore = HKHealthStore()

        let headphoneExposureType = HKQuantityType.quantityType(forIdentifier: .headphoneAudioExposure)!

        healthStore.requestAuthorization(toShare: nil, read: [headphoneExposureType]) { (success, error) in
            if success {
                // Authorization granted for reading headphone audio exposure data
                print("Authorization granted for headphone audio exposure")
                // You can now query or retrieve the headphone audio exposure data
            } else {
                // Authorization denied or an error occurred
                print("Authorization denied or an error occurred: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    func setUpUI() {
//        btn.setUp(.textOnly(text: "Demo เสียง"), type: .primary, size: .large)
        collectionViewHorizontalView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
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
            $0.textColor = UIColor(cgColor: EyeHubColor.textDescriptionColor)
            $0.font = FontFamily.Kanit.light.font(size: 14)
        }
        
        sectionView.forEach {
            $0.backgroundColor = UIColor.white
            $0.layer.cornerRadius = EyeHubRadius.radius8
        }
        
        bannerImageView.layer.cornerRadius = EyeHubRadius.radius16
        bannerImageView.image = UIImage(named: "GardientView1")
        bannerImageView.contentMode = .scaleAspectFill
        
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
        self.view.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
    }
}
