//
//  StartCoordinator.swift
//  AccessTheGallery
//
//  Created by Renilson Moreira on 08/07/22.
//

import Foundation
import UIKit

class StartCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = ContactViewController()
        navigationController.pushViewController(controller, animated: true)
    }
    
    
}
