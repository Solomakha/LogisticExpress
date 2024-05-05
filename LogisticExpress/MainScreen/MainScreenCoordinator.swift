import Foundation
import UIKit

class MainScreenCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainScreenViewController = MainScreenViewController()
        mainScreenViewController.coordinator = self
        navigationController.pushViewController(mainScreenViewController, animated: true)
    }
    
    func showOrderDetailsPage() {
        let orderDetailsScreenCoordinator = OrderDetailsScreenCoordinator(navigationController: navigationController)
        childCoordinators.append(orderDetailsScreenCoordinator)
        orderDetailsScreenCoordinator.start()
    }

}
