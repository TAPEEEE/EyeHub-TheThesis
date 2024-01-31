//
//  UICollectionView+Extensions.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 1/2/2567 BE.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerNib(for aClass: AnyClass) {
        register(
            UINib(nibName: String(describing: aClass), bundle: .main),
            forCellWithReuseIdentifier: String(describing: aClass)
        )
    }
    
    func dequeueReusableCell<T: UICollectionView>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}
