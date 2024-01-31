//
//  OnBoardingViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 28/1/2567 BE.
//

import UIKit

class OnBoardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

private extension OnBoardingViewController {
    func commonInit() {
        setUpUI()
    }
    
    func setUpUI() {
        self.view.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
    }
}
