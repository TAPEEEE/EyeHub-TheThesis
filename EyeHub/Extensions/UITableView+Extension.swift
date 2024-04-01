//
//  UITableView+Extension.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 31/3/2567 BE.
//

import Foundation
import UIKit

extension UITableView {
    func registerNib(for aClass: AnyClass) {
        register(
            UINib(nibName: String(describing: aClass), bundle: .main),
            forCellReuseIdentifier: String(describing: aClass)
        )
    }
    
    func dequeueReusableCell<T: UITableView>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}
