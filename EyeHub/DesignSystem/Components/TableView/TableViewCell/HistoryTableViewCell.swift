//
//  HistoryTableViewCell.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 31/3/2567 BE.
//

import UIKit

struct HistoryTableViewCellViewModel {
    let title: String
    let icon: UIImage
}

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI() {
        cellView.backgroundColor = UIColor(cgColor: EyeHubColor.tintPrimaryColor)
        cellView.layer.cornerRadius = EyeHubRadius.radius8
        titleLabel.font = FontFamily.Kanit.regular.font(size: 16)
        titleLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
    }
    
    func configure(viewModel: HistoryTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        iconImage.image = viewModel.icon
    }
    
    
}
