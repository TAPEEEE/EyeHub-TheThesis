//
//  SuggestHospitalCollectionViewCell.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 5/5/2567 BE.
//

import UIKit

class SuggestHospitalCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var contentCardView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func configure(viewModel: HospitalNearMeModel) {
        imageView.image = UIImage(named: viewModel.image) ?? UIImage()
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
    
    func setUpUI() {
        self.layer.cornerRadius = EyeHubRadius.radius20
        contentCardView.backgroundColor = UIColor(cgColor: EyeHubColor.warmWhiteColor)
        titleLabel.font = FontFamily.Kanit.semiBold.font(size: 18)
        descriptionLabel.font = FontFamily.Kanit.regular.font(size: 14)
        titleLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        descriptionLabel.textColor = UIColor(cgColor: EyeHubColor.textDescriptionColor)
    }

}
