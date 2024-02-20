//
//  NavigationBar.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 15/2/2567 BE.
//

import UIKit

@objc protocol NavigationBarDelegate: AnyObject {
    func navigationBackButtonDidTap(_ navigation: NavigationBar)
    @objc optional func navigationButtonDidTap(_ navigation: NavigationBar)
}

final class NavigationBar: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var navigationLabel: UILabel!
    @IBOutlet weak var navigationButton: UIButton!
   
    weak var delegate: NavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func set(title: String) {
        navigationLabel.text = title
    }
}

// MARK: - Action
extension NavigationBar {
    @IBAction func navigationButtonDidTap(_ sender: Any) {
        delegate?.navigationBackButtonDidTap(self)
    }
}

private extension NavigationBar {
    func commonInit() {
        setupXib()
        setUpView()
        setUpGestureRecognizer()
    }
    
    func setUpView() {
        navigationButton.tintColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        navigationLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        navigationLabel.font = FontFamily.Kanit.medium.font(size: 20)
    }
    
    func setUpGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(navigationButtonDidTap)
        )
        navigationButton.addGestureRecognizer(tapGesture)
    }
}

