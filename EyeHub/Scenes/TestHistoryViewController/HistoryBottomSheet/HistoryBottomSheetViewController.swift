//
//  HistoryBottomSheetViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 9/5/2567 BE.
//

import UIKit
import PanModal

class HistoryBottomSheetViewController: UIViewController {
    var panScrollable: UIScrollView?
    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.font = FontFamily.Kanit.semiBold.font(size: 18)
        textLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
    }
}

extension HistoryBottomSheetViewController: PanModalPresentable {
    var shortFormHeight: PanModalHeight {
        return .contentHeight(260)
    }
    
    var allowsDragToDismiss: Bool {
        return true
    }
    
    var panModalBackgroundColor: UIColor {
        return UIColor.black.withAlphaComponent(0.5)
    }
    
    var cornerRadius: CGFloat {
        return EyeHubRadius.radius24
    }
    
    var allowsTapToDismiss: Bool {
        return true
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
}

