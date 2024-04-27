//
//  BottomSheetTableViewCell.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 28/4/2567 BE.
//

import UIKit

class BottomSheetTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI() {
        bgView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
        bgView.layer.cornerRadius = EyeHubRadius.radius16
        checkMarkImageView.image = UIImage(systemName: "circle")
        checkMarkImageView.tintColor = UIColor(cgColor: EyeHubColor.primaryColor)
        titleLabel.font = FontFamily.Kanit.semiBold.font(size: 18)
        titleLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        bgView.layer.borderWidth = 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isSelected {
            bgView.layer.borderWidth = 2
            bgView.layer.borderColor = EyeHubColor.primaryColor
            checkMarkImageView.image = UIImage(systemName: "checkmark.circle.fill")
            bgView.backgroundColor = UIColor(cgColor: EyeHubColor.tintPrimaryColor)
        } else {
            setUpUI()
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
}
