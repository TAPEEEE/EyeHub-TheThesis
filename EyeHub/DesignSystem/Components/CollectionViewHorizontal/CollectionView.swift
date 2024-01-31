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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setCollectionView(viewModels: [CollectionViewType]) {
        self.viewModel = viewModels
    }
    
    private func setUp() {
        setupXib()
//        collectionView.registerNib(for: <#T##AnyClass#>)
    }
}

extension CollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
    
}
