//
//  BlindColorTestData.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 6/5/2567 BE.
//

import Foundation
import UIKit

enum BlindColorTestData {
    case plate1
    case plate2
    case plate3
    case plate4
    case plate5
    case plate6
    case plate7
    case plate8
    case plate9
    
    static let allCases: [BlindColorTestData] = [.plate1, .plate2, .plate3, .plate4, .plate5, .plate6, .plate7, .plate8, .plate9]
    
    var choiceAnswer: [String] {
        switch self {
        case .plate1:
            return ["12", "22", "ไม่สามารถอ่านได้"]
        case .plate2:
            return ["29", "70", "ไม่สามารถอ่านได้"]
        case .plate3:
            return ["3", "5", "ไม่สามารถอ่านได้"]
        case .plate4:
            return ["74", "21", "ไม่สามารถอ่านได้"]
        case .plate5:
            return ["45", "22", "ไม่สามารถอ่านได้"]
        case .plate6:
            return ["7", "22", "ไม่สามารถอ่านได้"]
        case .plate7:
            return ["73", "22", "ไม่สามารถอ่านได้"]
        case .plate8:
            return ["12", "45", "ไม่สามารถอ่านได้"]
        case .plate9:
            return ["42", "22", "ไม่สามารถอ่านได้"]
        }
    }
    
    var normal: String {
        switch self {
        case .plate1:
            return "12"
        case .plate2:
            return "29"
        case .plate3:
            return "3"
        case .plate4:
            return "74"
        case .plate5:
            return "45"
        case .plate6:
            return "7"
        case .plate7:
            return "73"
        case .plate8:
            return "ไม่สามารถอ่านได้"
        case .plate9:
            return "42"
        }
    }
    
    var redAndGreenBlind: String {
        switch self {
        case .plate1:
            return "12"
        case .plate2:
            return "70"
        case .plate3:
            return "5"
        case .plate4:
            return "21"
        case .plate5:
            return "ไม่สามารถอ่านได้"
        case .plate6:
            return "ไม่สามารถอ่านได้"
        case .plate7:
            return "ไม่สามารถอ่านได้"
        case .plate8:
            return "45"
        case .plate9:
            return "ไม่สามารถอ่านได้"
        }
    }
    
    var blindColor: String {
        switch self {
        case .plate1:
            return "12"
        case .plate2:
            return "ไม่สามารถอ่านได้"
        case .plate3:
            return "ไม่สามารถอ่านได้"
        case .plate4:
            return "ไม่สามารถอ่านได้"
        case .plate5:
            return "ไม่สามารถอ่านได้"
        case .plate6:
            return "ไม่สามารถอ่านได้"
        case .plate7:
            return "ไม่สามารถอ่านได้"
        case .plate8:
            return "ไม่สามารถอ่านได้"
        case .plate9:
            return "ไม่สามารถอ่านได้"
        }
    }
    
    var imagePlate: UIImage {
        switch self {
        case .plate1:
            return UIImage(named: "plate1") ?? UIImage()
        case .plate2:
            return UIImage(named: "plate2") ?? UIImage()
        case .plate3:
            return UIImage(named: "plate3") ?? UIImage()
        case .plate4:
            return UIImage(named: "plate4") ?? UIImage()
        case .plate5:
            return UIImage(named: "plate5") ?? UIImage()
        case .plate6:
            return UIImage(named: "plate6") ?? UIImage()
        case .plate7:
            return UIImage(named: "plate7") ?? UIImage()
        case .plate8:
            return UIImage(named: "plate8") ?? UIImage()
        case .plate9:
            return UIImage(named: "plate9") ?? UIImage()
        }
    }
}
