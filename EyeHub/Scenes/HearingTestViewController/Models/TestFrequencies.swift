//
//  TestFrequencies.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 8/4/2567 BE.
//

import Foundation

enum TestFrequency: Int {
    case hz125 = 125
    case hz1000 = 1000
    case hz2000 = 2000
    case hz4000 = 4000
    case hz8000 = 8000
    
    static let allCases: [TestFrequency] = [.hz125, .hz1000, .hz2000, .hz4000, .hz8000]
    
    var stringValue: String {
        return "\(rawValue)"
    }
    
    var doubleValue: Double {
        return Double(rawValue)
    }
}
