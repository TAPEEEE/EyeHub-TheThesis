//
//  TumblingETestData.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 4/5/2567 BE.
//

import Foundation

enum TumblingETestData: CGFloat {
    case feet70 = 96
    case feet60 = 84
    case feet50 = 72
    case feet40 = 62
    case feet30 = 48
    case feet20 = 38
    case feet15 = 26
    case feet10 = 22
    case feet7 = 16
    case feet4 = 12
    
    static let allCases: [TumblingETestData] = [.feet70, .feet60, .feet50, .feet40, .feet30, .feet20, .feet15, .feet10, .feet7, .feet4]
    
    var fontSizeRawValue: CGFloat {
        return self.rawValue
    }
    
    var wrongRotation: [TransformPosition] {
        switch self {
        case .feet70:
            return [.degree90, .degree270, .degree180]
        case .feet60:
            return [.degree90, .degree180, .degree0]
        case .feet50:
            return [.degree90, .degree270, .degree0]
        case .feet40:
            return [.degree90, .degree270, .degree0]
        case .feet30:
            return [.degree270, .degree180, .degree0]
        case .feet20:
            return [.degree90, .degree270, .degree180]
        case .feet15:
            return [.degree90, .degree270, .degree0]
        case .feet10:
            return [.degree90, .degree180, .degree0]
        case .feet7:
            return [.degree270, .degree180, .degree0]
        case .feet4:
            return [.degree90, .degree270, .degree180]
        }
    }
    
    var testRotation: TransformPosition {
        switch self {
        case .feet70:
            return .degree0
        case .feet60:
            return .degree270
        case .feet50:
            return .degree180
        case .feet40:
            return .degree180
        case .feet30:
            return .degree90
        case .feet20:
            return .degree0
        case .feet15:
            return .degree180
        case .feet10:
            return .degree270
        case .feet7:
            return .degree90
        case .feet4:
            return .degree0
        }
    }
}
