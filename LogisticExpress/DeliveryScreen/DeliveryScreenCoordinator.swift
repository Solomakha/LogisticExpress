//
//  SecondScreenCoordinator.swift
//  LogisticsExpress
//
//  Created by Admin on 04.02.2024.
//

import Foundation
import UIKit

class DeliveryScreenCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let secondScreenViewController = DeliveryScreenViewController()
        secondScreenViewController.coordinator = self
        navigationController.pushViewController(secondScreenViewController, animated: true)
    }
    
    var ordersInfoHandler: (([OrderInfo]) -> Void)?

       // Метод для передачи данных в другие контроллеры
       func passOrdersInfo(_ ordersInfo: [OrderInfo]) {
           ordersInfoHandler?(ordersInfo)
       }

}
