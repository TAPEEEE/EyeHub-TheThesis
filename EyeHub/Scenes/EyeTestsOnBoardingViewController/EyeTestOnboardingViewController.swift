//
//  EyeTestOnboardingViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 9/5/2567 BE.
//

import UIKit

class EyeTestOnboardingViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var buttonView: PrimaryButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var navvigationBar: NavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

extension EyeTestOnboardingViewController: NavigationBarDelegate {
    func navigationBackButtonDidTap(_ navigation: NavigationBar) {
        navigationController?.popViewController(animated: true)
    }
}

extension EyeTestOnboardingViewController {
    func commonInit() {
        setUpUI()
        navvigationBar.delegate = self
        let buttontapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleButtonAction)
        )
        buttonView.addGestureRecognizer(buttontapGesture)
    }
    
    @objc func handleButtonAction() {
        let navigateVc = SnellenTestViewController()
        navigationController?.pushViewController(navigateVc, animated: true)
    }
    
    func setUpUI() {
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
        buttonView.setUp(.textOnly(text: "เริ่มทดสอบ"), type: .primary, size: .large)
        titleLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        titleLabel.font = FontFamily.Kanit.medium.font(size: 18)
        descriptionLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        descriptionLabel.font = FontFamily.Kanit.light.font(size: 16)
        navvigationBar.set(title: "ทดสอบสายตา")
    }
}
