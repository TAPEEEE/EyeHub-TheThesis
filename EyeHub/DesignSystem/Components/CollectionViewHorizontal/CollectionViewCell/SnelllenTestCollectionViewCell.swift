//
//  SnelllenTestCollectionViewCell.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 28/4/2567 BE.
//

import UIKit

class SnelllenTestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        bgView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
        bgView.layer.cornerRadius = EyeHubRadius.radius16
        answerLabel.font = FontFamily.Kanit.light.font(size: 14)
    }
    
    func configure(text: String) {
        answerLabel.text = text
    }
}
