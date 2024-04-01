//
//  TableView.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 31/3/2567 BE.
//

import UIKit

protocol TableViewDelegate: AnyObject {
    func tableView(_ view: TableView, didSelectRowAr index: Int)
}

class TableView: UIView {
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: TableViewDelegate?
    private var viewModel: [TableViewType] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setTableView(viewModels: [TableViewType]) {
        self.viewModel = viewModels
    }
    
    private func setUp() {
        setupXib()
        tableView.backgroundColor = .clear
        tableView.registerNib(for: HistoryTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
}

extension TableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel[indexPath.row] {
        case .historyTable(let viewModel):
            let cell: HistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
            cell.configure(viewModel: viewModel)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        delegate?.tableView(self, didSelectRowAr: row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
