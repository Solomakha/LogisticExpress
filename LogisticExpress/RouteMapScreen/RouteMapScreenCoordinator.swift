//
//  RouteMapScreenCoordinator.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 13.04.2024.
//

import Foundation
import Foundation
import UIKit

class RouteMapScreenCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let routeMapScreenViewController = RouteMapScreenViewController()
        routeMapScreenViewController.coordinator = self
        navigationController.pushViewController(routeMapScreenViewController, animated: true)
    }
    
}
