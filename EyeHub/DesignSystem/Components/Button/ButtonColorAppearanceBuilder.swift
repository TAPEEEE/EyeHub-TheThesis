//
//  ButtonColorAppearanceBuilder.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 28/1/2567 BE.
//

import UIKit

class ButtonColorAppearanceBuilder {
    func build(type: ButtonType,
               state: ButtonState) -> ButtonAppearance {
        switch type {
        case .primary:
            return makeColorPrimaryAppearance(state: state)
        }
    }
}

// MARK: - Private
private extension ButtonColorAppearanceBuilder {
    func makeColorPrimaryAppearance(state: ButtonState) -> ButtonAppearance {
        switch state {
        case .active:
            return ButtonAppearance(
                backgroundColor: UIColor(cgColor: EyeHubColor.primaryColor),
                textColor: UIColor(cgColor: EyeHubColor.warmWhiteColor),
                borderColor: .clear,
                borderWidth: 0
            )
        case .onPress:
            return ButtonAppearance(
                backgroundColor: UIColor(cgColor: EyeHubColor.backgroundPrimaryColor),
                textColor: UIColor(cgColor: EyeHubColor.warmWhiteColor),
                borderColor: .clear,
                borderWidth: 0
            )
        case .disable:
            return ButtonAppearance(
                backgroundColor: UIColor(cgColor: EyeHubColor.tintPrimaryColor),
                textColor: UIColor(cgColor: EyeHubColor.backgroundPrimaryColor),
                borderColor: .clear,
                borderWidth: 0
            )
        }
    }
}

