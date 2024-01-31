//
//  ButtonSize.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 28/1/2567 BE.
//

import UIKit

private enum Constants {
    static let iconSizeLarge: CGFloat = 32
    static let iconSizeMedium: CGFloat = 24
    static let iconSizeSmall: CGFloat = 16
}

public enum ButtonSize {
    case large
    case medium
    case small

    var iconImageSize: CGSize {
        switch self {
        case .large:
            return CGSize(width: Constants.iconSizeLarge, height: Constants.iconSizeLarge)
        case .medium:
            return CGSize(width: Constants.iconSizeMedium, height: Constants.iconSizeMedium)
        case .small:
            return CGSize(width: Constants.iconSizeSmall, height: Constants.iconSizeSmall)
        }
    }

    var containerMinHeight: CGFloat {
        switch self {
        case .large:
            return 48
        case .medium:
            return 40
        case .small:
            return 32
        }
    }
}

