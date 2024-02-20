//
//  HomeScreenCollectionViewCell.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 1/2/2567 BE.
//

import UIKit

struct HomeScreenCollectionViewCellViewModel {
    let title: String
    let description: String
    let icon: UIImage
    let cardColor: UIColor
}
class HomeScreenCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        bgView.layer.cornerRadius = EyeHubRadius.radius16
        titleLabel.font = FontFamily.Kanit.medium.font(size: 16)
        descriptionLabel.font = FontFamily.Kanit.light.font(size: 12)
        titleLabel.textColor = UIColor(cgColor: EyeHubColor.backgroundColor)
        descriptionLabel.textColor = UIColor(cgColor: EyeHubColor.backgroundColor)
    }
    
    func configure(viewModel: HomeScreenCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        iconImage.image = viewModel.icon
        bgView.backgroundColor = viewModel.cardColor
    }
}
