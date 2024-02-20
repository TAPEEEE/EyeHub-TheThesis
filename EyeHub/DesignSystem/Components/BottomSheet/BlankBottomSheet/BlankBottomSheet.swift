//
//  BlankBottomSheet.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 17/2/2567 BE.
//

import UIKit

final public class BlankBottomSheet: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

extension BlankBottomSheet {
    func commonInit() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = EyeHubRadius.radius40
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

