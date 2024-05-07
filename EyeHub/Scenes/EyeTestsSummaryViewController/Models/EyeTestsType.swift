//
//  EyeTestsType.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 1/5/2567 BE.
//

import Foundation
import UIKit


enum EyeTestsType {
    case snellen
    case landoltC
    case tumblingE
    
    var coverImage: UIImage {
        switch self {
        case .snellen:
            return UIImage(named: "SnellenIcon2") ?? UIImage()
        case .landoltC:
            return UIImage(named: "CChartIcon") ?? UIImage()
        case .tumblingE:
            return UIImage(named: "EChartIcon") ?? UIImage()
        }
    }
}
