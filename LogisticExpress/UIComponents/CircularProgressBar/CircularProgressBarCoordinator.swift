import Foundation
import UIKit

class CircularProgressBarCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let circularProgressBarViewController = CircularProgressBarViewController()
        circularProgressBarViewController.coordinator = self
        navigationController.pushViewController(circularProgressBarViewController, animated: true)
    }
    
    func showRouteMapPage() {
        let routeMapScreenCoordinator = RouteMapScreenCoordinator(navigationController: navigationController)
        childCoordinators.append(routeMapScreenCoordinator)
        routeMapScreenCoordinator.start()
    }

}
