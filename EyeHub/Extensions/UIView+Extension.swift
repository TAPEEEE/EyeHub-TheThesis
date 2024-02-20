//
//  UIView+Extension.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 28/1/2567 BE.
//

import UIKit

extension UIView {
    
    var xibName: String {
        return String(describing: type(of: self)).components(separatedBy: ".").first ?? ""
    }
    
    func setupXib() {
        setupXib(xibName: xibName)
    }
    
    func setupXib(xibName: String) {
        let nib = UINib(nibName: xibName, bundle: .main)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.layoutIfNeeded()
        self.addSubview(view)
    }
    
    func dropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 3)
        layer.masksToBounds = false
        
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 3
        layer.shouldRasterize = true
    }
}
