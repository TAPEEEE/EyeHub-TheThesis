//
//  HomeMenuButtonState.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 1/2/2567 BE.
//

import Foundation

public enum HomeMenuButtonState {
    case active
    case disable
}

extension HomeMenuButtonState {
    var alpha: CGFloat {
        switch self {
        case .active:
            return 1
        case .disable:
            return 0.3
        }
    }

    var isUserInteractionEnabled: Bool {
        switch self {
        case .active:
            return true
        case .disable:
            return false
        }
    }
}
