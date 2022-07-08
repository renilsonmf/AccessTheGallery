//
//  ComponentTableView.swift
//  AccessTheGallery
//
//  Created by Renilson Moreira on 08/07/22.
//

import Foundation
import UIKit
class ComponentTableView: UITableView {
    private let identifier = "CustomCell"
    weak var delegateTableViewContacts: TableViewMethodsProtocol?
    init(frame: CGRect = .zero, style: UITableView.Style = .plain, delegateClick: TableViewMethodsProtocol) {
        super.init(frame: frame, style: .plain)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = self
        self.dataSource = self
        self.delegateTableViewContacts = delegateClick
        self.register(CustomCell.self, forCellReuseIdentifier: identifier)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
extension ComponentTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegateTableViewContacts?.numberOfRowsInSectionDelegate() ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return delegateTableViewContacts?.cellForRowAtDelegate(tableView: tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return delegateTableViewContacts?.swipeLeftToRightDelegate(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return delegateTableViewContacts?.swipeRightToLeftDelegate(indexPath: indexPath, tableView: tableView)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegateTableViewContacts?.didTapIndexRowDelegate()
    }
}
