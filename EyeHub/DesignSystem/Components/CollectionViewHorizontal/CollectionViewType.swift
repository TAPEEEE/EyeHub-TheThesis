//
//  CollectionViewType.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 1/2/2567 BE.
//

import Foundation
import UIKit

enum CollectionViewType {
    case homeScreen(viewModel: HomeScreenCollectionViewCellViewModel)
    case snelllenTest(title: String)
    case hospitalNearMe(viewModel: HospitalNearMeModel)
}


struct HospitalNearMeModel {
    var image: String
    var title: String
    var description: String
}
