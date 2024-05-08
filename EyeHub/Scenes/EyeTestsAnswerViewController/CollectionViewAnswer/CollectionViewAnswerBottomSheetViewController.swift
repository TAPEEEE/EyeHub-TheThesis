//
//  CollectionViewAnswerBottomSheetViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 2/5/2567 BE.
//

import Foundation
import UIKit
import PanModal


protocol CollectionViewBottomSheetDelegate: AnyObject {
    func didSelectRow(indexPath: Int)
}

class CollectionViewAnswerBottomSheetViewController: UIViewController {
    var panScrollable: UIScrollView?
    var model: [EandCModel] = []
    weak var delegate: CollectionViewBottomSheetDelegate?
    var selectedIndexPath: IndexPath?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonView: PrimaryButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        print(model)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(for: BottomSheetAnswerCollectionViewCell.self)
    }
}

extension CollectionViewAnswerBottomSheetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BottomSheetAnswerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomSheetAnswerCollectionViewCell", for: indexPath) as! BottomSheetAnswerCollectionViewCell
        cell.configure(model: model[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        buttonView.buttonState = .active
        if let cell = collectionView.cellForItem(at: indexPath) as? BottomSheetAnswerCollectionViewCell {
            cell.isSelected = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? BottomSheetAnswerCollectionViewCell {
            cell.isSelected = false
        }
    }
}

extension CollectionViewAnswerBottomSheetViewController {
    func commonInit() {
        setUpUI()
    }
    
    func setUpUI() {
        buttonView.setUp(.textOnly(text: "ยืนยันคำตอบ"), type: .primary, size: .large)
        buttonView.buttonState = .disable
        let buttontapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(demoVoice)
        )
        buttonView.addGestureRecognizer(buttontapGesture)
        titleLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        titleLabel.font = FontFamily.Kanit.medium.font(size: 18)
        
        descriptionLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        descriptionLabel.font = FontFamily.Kanit.light.font(size: 16)
    }
    
    @objc func demoVoice() {
        delegate?.didSelectRow(indexPath: selectedIndexPath?.row ?? 0)
    }
}

extension CollectionViewAnswerBottomSheetViewController: PanModalPresentable {
    var shortFormHeight: PanModalHeight {
        return .contentHeight(580)
    }
    
    var allowsDragToDismiss: Bool {
        return false
    }
    
    var panModalBackgroundColor: UIColor {
        return UIColor.black.withAlphaComponent(0.5)
    }
    
    var cornerRadius: CGFloat {
        return EyeHubRadius.radius24
    }
    
    var allowsTapToDismiss: Bool {
        return false
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
}

