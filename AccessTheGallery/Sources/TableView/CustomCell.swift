//
//  CustomCell.swift
//  AccessTheGallery
//
//  Created by Renilson Moreira on 08/07/22.
//

import UIKit
class CustomCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    lazy var iconProfileImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 30
        img.clipsToBounds = true
        return img
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var cellNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    func setupCellContacts(dataImage: Data, name: String, lastName: String, cellNumber: String) {
        iconProfileImage.image = UIImage(data: dataImage)
        nameLabel.text = name + " " + lastName
        cellNumberLabel.text = cellNumber
    }
}
extension CustomCell: ViewCodingProtocol {
    func buildViewHierarchy() {
        addSubview(iconProfileImage)
        addSubview(nameLabel)
        addSubview(cellNumberLabel)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconProfileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            iconProfileImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            iconProfileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            iconProfileImage.heightAnchor.constraint(equalToConstant: 60),
            iconProfileImage.widthAnchor.constraint(equalToConstant: 60),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            nameLabel.leftAnchor.constraint(equalTo: iconProfileImage.rightAnchor, constant: 8),
            cellNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            cellNumberLabel.leftAnchor.constraint(equalTo: iconProfileImage.rightAnchor, constant: 8)
        ])
    }
}
