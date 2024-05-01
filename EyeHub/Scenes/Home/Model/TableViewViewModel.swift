//
//  TableViewViewModel.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 31/3/2567 BE.
//

import Foundation
import UIKit

enum TableViewList: Int, CaseIterable {
    case eye
    case vision
    case ear
    
    var cardCell: HistoryTableViewCellViewModel {
        switch self {
        case .eye:
            return HistoryTableViewCellViewModel(
                title: "การทดสอบสายตา",
                icon: UIImage(named: "EyeTest16x16") ?? UIImage()
            )
        case .vision:
            return HistoryTableViewCellViewModel(
                title: "การทดสอบการมองเห็น",
                icon: UIImage(named: "ColorTest16x16") ?? UIImage()
            )
        case .ear:
            return HistoryTableViewCellViewModel(
                title: "การทดสอบสุขภาพหู",
                icon: UIImage(named: "EarTest16x16") ?? UIImage()
            )
        }
    }
    
    var viewController: UIViewController.Type {
        switch self {
        case .eye:
            return EyeTestsSummaryViewController.self
        case .vision:
            return HearingTestSummaryViewController.self
        case .ear:
            return HearingViewController.self
        }
    }
}
