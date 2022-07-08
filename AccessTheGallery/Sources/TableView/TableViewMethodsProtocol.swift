//
//  TableViewMethodsProtocol.swift
//  AccessTheGallery
//
//  Created by Renilson Moreira on 08/07/22.
//

import Foundation
import UIKit
protocol TableViewMethodsProtocol: NSObject {
    func numberOfRowsInSectionDelegate() -> Int
    func cellForRowAtDelegate(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func didTapIndexRowDelegate()
    func swipeLeftToRightDelegate(indexPath: IndexPath) -> UISwipeActionsConfiguration
    func swipeRightToLeftDelegate(indexPath: IndexPath, tableView: UITableView) -> UISwipeActionsConfiguration
}

///Methods optional
extension TableViewMethodsProtocol {
    func didTapIndexRowDelegate() {
        //
    }
    
    func swipeLeftToRightDelegate(indexPath: IndexPath) -> UISwipeActionsConfiguration {
        return UISwipeActionsConfiguration()
    }
}
