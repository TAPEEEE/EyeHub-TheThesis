//
//  BottomSheetTestViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 24/4/2567 BE.
//

import UIKit

class BottomSheetTestViewController: UIViewController, BottomSheetDelegate {
    private let bottomSheetVC = BottomSheetViewController()

    @IBAction func btn(_ sender: Any) {
        bottomSheetVC.delegate = self
        bottomSheetVC.modalPresentationStyle = .pageSheet
        bottomSheetVC.preferredContentSize = CGSize(width: UIScreen.main.bounds.height, height: 500)
        present(bottomSheetVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func didSelectRow(indexPath: IndexPath) {
        print("Selected row at index path: \(indexPath)")
        // Handle row selection logic here
    }
}

