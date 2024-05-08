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
    func didSelectRow(indexPath: Int, value: String)
}

class AnswerBottomSheetViewController: UIViewController {
    var panScrollable: UIScrollView?
    var model: [String] = []
    weak var delegate: BottomSheetDelegate?
    var selectedIndexPath: IndexPath?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonView: PrimaryButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(model)
        setupTableView()
        tableView.registerNib(for: BottomSheetTableViewCell.self)
        buttonView.setUp(.textOnly(text: "ยืนยันคำตอบ"), type: .primary, size: .large)
        buttonView.buttonState = .disable
        titleLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        titleLabel.font = FontFamily.Kanit.medium.font(size: 18)
        
        descriptionLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        descriptionLabel.font = FontFamily.Kanit.light.font(size: 16)
        let buttontapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(demoVoice)
        )
        buttonView.addGestureRecognizer(buttontapGesture)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    @objc func demoVoice() {
        delegate?.didSelectRow(indexPath: selectedIndexPath?.row ?? 0, value: model[selectedIndexPath?.row ?? 0])
    }
}

extension AnswerBottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BottomSheetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BottomSheetTableViewCell", for: indexPath) as! BottomSheetTableViewCell
        cell.configure(title: model[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        buttonView.buttonState = .active
    }
}

extension AnswerBottomSheetViewController: PanModalPresentable {
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
