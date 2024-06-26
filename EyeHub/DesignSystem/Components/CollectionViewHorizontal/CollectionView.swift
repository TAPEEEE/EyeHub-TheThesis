//
//  CollectionView.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 1/2/2567 BE.
//

import Foundation
import UIKit

protocol CollectionViewDelegate: AnyObject {
    func collectionView(_ view: CollectionView, didSelectRowAr index: Int)
}

class CollectionView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: CollectionViewDelegate?
    private var viewModel: [CollectionViewType] = []
    private let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setCollectionView(viewModels: [CollectionViewType]) {
        self.viewModel = viewModels
    }
    
    private func setUp() {
        setupXib()
        collectionView.backgroundColor = .clear
        collectionView.registerNib(for: HomeScreenCollectionViewCell.self)
        collectionView.registerNib(for: SuggestHospitalCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel[indexPath.row] {
        case .homeScreen(let viewModel):
            let cell: HomeScreenCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeScreenCollectionViewCell", for: indexPath) as! HomeScreenCollectionViewCell
            cell.configure(viewModel: viewModel)
            return cell
        case .snelllenTest(title: let title):
            let cell: SnelllenTestCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SnelllenTestCollectionViewCell", for: indexPath) as! SnelllenTestCollectionViewCell
            cell.configure(text: title)
            return cell
        case .hospitalNearMe(let viewModel):
            let cell: SuggestHospitalCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestHospitalCollectionViewCell", for: indexPath) as! SuggestHospitalCollectionViewCell
            cell.configure(viewModel: viewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        delegate?.collectionView(self, didSelectRowAr: row)
        impactFeedback.impactOccurred()
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
