//
//  OrderDetailsScreenCoordinator.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 03.03.2024.
//

import Foundation
import UIKit

class OrderDetailsScreenCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let orderDetailsScreenViewController = OrderDetailsViewController()
        orderDetailsScreenViewController.coordinator = self
        navigationController.pushViewController(orderDetailsScreenViewController, animated: true)
    }
    
    func showProfilePage() {
        let profileScreenCoordinator = ProfileScreenCoordinator(navigationController: navigationController)
        childCoordinators.append(profileScreenCoordinator)
        profileScreenCoordinator.start()
    }
}
