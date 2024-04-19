import Foundation
import UIKit

class TabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: TabBarController

    init(navigationController: UINavigationController, tabBarController: TabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }

    func start() {
        let mainScreenCoordinator = MainScreenCoordinator(navigationController: UINavigationController())
        mainScreenCoordinator.start()
        childCoordinators.append(mainScreenCoordinator)

        let deliveryScreenCoordinator = DeliveryScreenCoordinator(navigationController: UINavigationController())
        deliveryScreenCoordinator.start()
        childCoordinators.append(deliveryScreenCoordinator)
        
        let profileScreenCoordinator = ProfileScreenCoordinator(navigationController: UINavigationController())
        profileScreenCoordinator.start()
        childCoordinators.append(profileScreenCoordinator)
        
        tabBarController.viewControllers = childCoordinators.map { $0.navigationController }
        navigationController.pushViewController(tabBarController, animated: true)
    }
}
