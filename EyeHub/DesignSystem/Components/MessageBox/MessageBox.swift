//
//  MessageBox.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 16/4/2567 BE.
//

import UIKit

enum MessageBoxType {
    case warning
    case information
}

class MessageBox: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setUp(type: MessageBoxType, title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        configureAppearance(for: type)
    }
    
    private func commonInit() {
        setupXib()
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = EyeHubRadius.radius8
        
        titleLabel.font = FontFamily.Kanit.semiBold.font(size: 16)
        descriptionLabel.font = FontFamily.Kanit.regular.font(size: 14)
    }
    
    private func configureAppearance(for type: MessageBoxType) {
        let primaryColor: CGColor
        let backgroundColor: CGColor
        let textColor: CGColor
        let iconColor: CGColor
        
        switch type {
        case .information:
            primaryColor = EyeHubColor.primaryColor
            backgroundColor = EyeHubColor.tintPrimaryColor
            textColor = EyeHubColor.backgroundPrimaryColor
            iconColor = EyeHubColor.primaryColor
        case .warning:
            primaryColor = EyeHubColor.orangeColor
            backgroundColor = EyeHubColor.tintOrangeColor
            textColor = EyeHubColor.backgroundOrangeColor
            iconColor = EyeHubColor.orangeColor
        }
        
        titleLabel.textColor = UIColor(cgColor: primaryColor)
        contentView.backgroundColor = UIColor(cgColor: backgroundColor)
        contentView.layer.borderColor = primaryColor
        descriptionLabel.textColor = UIColor(cgColor: textColor)
        iconImageView.tintColor = UIColor(cgColor: iconColor)
    }
}
