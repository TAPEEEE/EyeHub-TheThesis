//
//  File.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 2/4/2567 BE.
//

import Foundation
import UIKit

struct OnbaordingViewModel {
    let title: String
    let description: String
    let content: contentImage
}

enum contentImage {
    case coverImage(image: UIImage)
    case lottieFile(lottie: String)
}
