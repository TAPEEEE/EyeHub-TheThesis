//
//  BottomSheetAnswerCollectionViewCell.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 3/5/2567 BE.
//

import UIKit

class BottomSheetAnswerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                cardView.backgroundColor = UIColor(cgColor: EyeHubColor.tintPrimaryColor)
                cardView.layer.borderWidth = 4
            } else {
                cardView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
                cardView.layer.borderWidth = 0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func configure(model: EandCModel) {
        switch model.text {
        case .landoltC:
            imageView.image = UIImage(named: "LanDoltCTestChar")
        case .tumblingE:
            imageView.image = UIImage(named: "TumblingETestChar")
        }
        switch model.transform {
        case .degree0:
            return
        case .degree90:
            imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        case .degree180:
            imageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        case .degree270:
            imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        }
    }
    
    func setUpUI() {
        cardView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
        cardView.layer.cornerRadius = EyeHubRadius.radius16
        cardView.layer.borderColor = EyeHubColor.primaryColor
    }

}
