//
//  Coordinator.swift
//  AccessTheGallery
//
//  Created by Renilson Moreira on 08/07/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
