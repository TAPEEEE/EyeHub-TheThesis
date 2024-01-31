//
//  HomeMenuButtonActionState.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 1/2/2567 BE.
//

import Foundation

public enum HomeMenuButtonActionState {
    case begin
    case end
    case cancelled
}

extension HomeMenuButtonActionState {
    var alpha : CGFloat {
        switch self {
        case .begin:
            return 0.5
        case .end, .cancelled:
            return 1
        }
    }
    
    var border : CGFloat {
        switch self {
        case .begin:
            return 2
        case .end, .cancelled:
            return 0
        }
    }
}

