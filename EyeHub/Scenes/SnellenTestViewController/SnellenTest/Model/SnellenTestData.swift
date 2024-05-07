//
//  SnellenTestData.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 21/4/2567 BE.
//

import Foundation

enum SnellenTestData: CGFloat {
    case feet70 = 72
    case feet60 = 64
    case feet50 = 52
    case feet40 = 44
    case feet30 = 32
    case feet20 = 26
    case feet15 = 22
    case feet10 = 16
    case feet7 = 12
    case feet4 = 9
    
    static let allCases: [SnellenTestData] = [.feet70, .feet60, .feet50, .feet40, .feet30, .feet20, .feet15, .feet10, .feet7, .feet4]
    
    var fontSizeRawValue: CGFloat {
        return self.rawValue
    }
    
    var wrongTestText: [String] {
        switch self {
        case .feet70:
            return ["C", "F", "H"]
        case .feet60:
            return ["E R", "F F", "R P"]
        case .feet50:
            return ["T U C", "T O O", "F O Z"]
        case .feet40:
            return ["L R E", "F P E", "L P F"]
        case .feet30:
            return ["B E C", "P B C", "F B G"]
        case .feet20:
            return ["B D F C", "E O F C", "E O F G"]
        case .feet15:
            return ["T R G H", "T R C H", "T P C H"]
        case .feet10:
            return ["H M M I", "R M N K", "H M K I"]
        case .feet7:
            return ["E D R E", "F C R E", "F D P E"]
        case .feet4:
            return ["P O P A", "B O B A", "P O B A"]
        }
    }
    
    var testText: String {
        switch self {
        case .feet70:
            return "E"
        case .feet60:
            return "F P"
        case .feet50:
            return "T O Z"
        case .feet40:
            return "L P E"
        case .feet30:
            return "P E C"
        case .feet20:
            return "E D F C"
        case .feet15:
            return "I R G H"
        case .feet10:
            return "H N M K"
        case .feet7:
            return "F D R E"
        case .feet4:
            return "B O P A"
        }
    }
}
