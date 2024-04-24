//
//  CollectionViewModel.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 1/2/2567 BE.
//

import Foundation
import UIKit

enum HorizontalCollectionViewList: Int, CaseIterable {
    case eye
    case vision
    case ear
    
    var cardCell: HomeScreenCollectionViewCellViewModel {
        switch self {
        case .eye:
            return HomeScreenCollectionViewCellViewModel(
                title: "สายตา",
                description: "ทดสอบความผิดปกติ",
                icon: UIImage(named: "EyeIconCard") ?? UIImage(),
                cardColor: UIColor(cgColor: EyeHubColor.primaryColor)
            )
        case .vision:
            return HomeScreenCollectionViewCellViewModel(
                title: "การมองเห็น",
                description: "ทดสอบการรับรู้สี",
                icon: UIImage(named: "ColorPlateIconCard") ?? UIImage(),
                cardColor: UIColor(cgColor: EyeHubColor.pinkColor)
            )
        case .ear:
            return HomeScreenCollectionViewCellViewModel(
                title: "ระดับการได้ยิน",
                description: "ทดสอบคุณภาพหู",
                icon: UIImage(named: "EarIconCard") ?? UIImage(),
                cardColor: UIColor(cgColor: EyeHubColor.orangeColor)
            )
        }
    }
    
    var viewController: UIViewController.Type {
        switch self {
        case .eye:
            return BottomSheetTestViewController.self
        case .vision:
            return HearingTestSummaryViewController.self
        case .ear:
            return HearingViewController.self
        }
    }
}
