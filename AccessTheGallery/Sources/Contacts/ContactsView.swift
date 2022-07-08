//
//  GalleryView.swift
//  AccessTheGallery
//
//  Created by Renilson Moreira on 08/07/22.
//

import Foundation
import UIKit

class ContactsView: UIView {
    
    weak var delegateTableView: TableViewMethodsProtocol?
    weak var delegateSearchBar: UISearchBarDelegate?
    
    init(frame: CGRect = .zero, delegateTableView: TableViewMethodsProtocol, delegateSearchBar: UISearchBarDelegate) {
        super.init(frame: frame)
        self.delegateTableView = delegateTableView
        self.delegateSearchBar = delegateSearchBar
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    lazy var searchBarContacts: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .prominent
        search.placeholder = "Pesquisar.."
        search.sizeToFit()
        search.delegate = delegateSearchBar
        search.backgroundImage = UIImage()
        search.isTranslucent = false
        search.translatesAutoresizingMaskIntoConstraints = false
       return search
    }()
    lazy var tableView: ComponentTableView = {
        let tableView = ComponentTableView(delegateClick: delegateTableView!)
        return tableView
    }()
    lazy var noResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "Nenhum Resultado"
        label.isHidden = true
        label.font = UIFont(name: "Avenir", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var noResultsLabelConstants: [NSLayoutConstraint] = {
        addSubview(noResultsLabel)
        let noResultsLabelConstants: [NSLayoutConstraint] = [
            noResultsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            noResultsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]
        return noResultsLabelConstants
    }()
    func noHasSearchResult(result: Bool) {
        if result {
            NSLayoutConstraint.deactivate(noResultsLabelConstants)
            tableView.isHidden = false
            noResultsLabel.isHidden = true
        }else{
            NSLayoutConstraint.activate(noResultsLabelConstants)
            tableView.isHidden = true
            noResultsLabel.isHidden = false
        }
    }
}
extension ContactsView: ViewCodingProtocol {
    func buildViewHierarchy() {
        addSubview(searchBarContacts)
        addSubview(tableView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBarContacts.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBarContacts.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            searchBarContacts.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: searchBarContacts.bottomAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func additionalSettings() {
        self.backgroundColor = .white
    }
}
