//
//  HomeMenuButtonViewModel.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 1/2/2567 BE.
//

import Foundation
import UIKit

public struct HomeMenuButtonViewModel {
    public let tagId: Int
    public let title: String?
    public let state: HomeMenuButtonState
    public let icon: UIImage

    public init(tagId: Int = .zero, title: String?, state: HomeMenuButtonState, icon: UIImage) {
        self.tagId = tagId
        self.title = title
        self.state = state
        self.icon = icon
    }
}
