import Foundation
import UIKit

class ProfileScreenCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let profileViewController = ProfileScreenViewController()
        profileViewController.coordinator = self
        navigationController.pushViewController(profileViewController, animated: false)
    }
}
