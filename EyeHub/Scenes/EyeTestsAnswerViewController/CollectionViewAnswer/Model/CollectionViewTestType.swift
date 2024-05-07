//
//  CollectionViewTestType.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 2/5/2567 BE.
//

import Foundation

enum CollectionViewTestType {
    case landoltC
    case tumblingE
    
    var textValue: String {
        switch self {
        case .landoltC:
            return "C"
        case .tumblingE:
            return "E"
        }
    }
}
