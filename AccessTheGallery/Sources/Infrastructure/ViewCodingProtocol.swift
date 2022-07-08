//
//  ViewCodingProtocol.swift
//  AccessTheGallery
//
//  Created by Renilson Moreira on 08/07/22.
//

import Foundation

protocol ViewCodingProtocol {
    func buildViewHierarchy()
    func setupConstraints()
    func additionalSettings()
}

extension ViewCodingProtocol {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        additionalSettings()
    }
    
    func additionalSettings() {
        //
    }
}
