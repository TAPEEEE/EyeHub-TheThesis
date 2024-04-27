//
//  BottomSheet.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 24/4/2567 BE.
//

import Foundation
import UIKit
import PanModal

protocol BottomSheetDelegate: AnyObject {
    func didSelectRow(indexPath: Int)
}

class BottomSheetViewController: UIViewController {
    var panScrollable: UIScrollView?
    var model: [String] = []
    weak var delegate: BottomSheetDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.registerNib(for: BottomSheetTableViewCell.self)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension BottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "BottomSheetTableViewCell", for: indexPath)
//        cell.
//        return cell
//        
        let cell: BottomSheetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BottomSheetTableViewCell", for: indexPath) as! BottomSheetTableViewCell
        cell.configure(title: model[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRow(indexPath: indexPath.row)
//        dismiss(animated: true, completion: nil)
        
    }
}

extension BottomSheetViewController: PanModalPresentable {
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(UIScreen.main.bounds.height/4)
    }
    
    var allowsDragToDismiss: Bool {
        return false
    }
    
    var allowsTapToDismiss: Bool {
        return false
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
}
