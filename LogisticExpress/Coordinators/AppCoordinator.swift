//import Foundation
//import UIKit
//
//class AppCoordinator: Coordinator {
//    var childCoordinators: [Coordinator] = []
//    var tabBarController: UITabBarController
//    var navigationController: UINavigationController
//
//    init(tabBarController: UITabBarController, navigationController: UINavigationController) {
//        self.tabBarController = tabBarController
//        self.navigationController = navigationController
//    }
//
//    func start() {
//        let mainViewController = MainScreenViewController()
//        mainViewController.tabBarItem = UITabBarItem(title: "Main", image: UIImage(named: "MainScreen"), tag: 0)
//
//        let secondViewController = SecondScreenViewController()
//        secondViewController.tabBarItem = UITabBarItem(title: "Second", image: UIImage(named: "map"), tag: 1)
//
//        let profileViewController = ProfileScreenViewController()
//        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "user"), tag: 2)
//
//        tabBarController.viewControllers = [mainViewController, secondViewController, profileViewController]
//
//        customizeTabBarAppearance()
//
//        navigationController.pushViewController(tabBarController, animated: true)
//    }
//
//    private func customizeTabBarAppearance() {
//        tabBarController.tabBar.barTintColor = UIColor.white
//        tabBarController.tabBar.tintColor = UIColor.white
//        tabBarController.tabBar.unselectedItemTintColor = UIColor.gray
//        tabBarController.tabBar.backgroundColor = .black
//        tabBarController.tabBar.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        tabBarController.tabBar.layer.cornerRadius = 25
//    }
//}


import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var tabBarViewModel: TabBarViewModel
    
    init(tabBarController: UITabBarController, navigationController: UINavigationController, tabBarViewModel: TabBarViewModel) {
            self.tabBarController = tabBarController
            self.navigationController = navigationController
            self.tabBarViewModel = tabBarViewModel
        }
    
    func start() {
        print("Coordinator Start!")
        showMainFlow()
        customizeTabBarAppearance()
    }
    
    func showMainFlow() {
            // Создаем и добавляем координаторы для каждого таба из TabBarViewModel
            for tab in tabBarViewModel.tabs {
                tab.coordinator.start()
                tab.coordinator.navigationController.tabBarItem = UITabBarItem(title: tab.title, image: UIImage(named: tab.imageName), tag: 0)
                
                // Добавляем координаторы в массив childCoordinators
                childCoordinators.append(tab.coordinator)
            }

            // Устанавливаем childCoordinators в tabBarController
            tabBarController.viewControllers = childCoordinators.map { $0.navigationController }
        }
    
    private func customizeTabBarAppearance() {
        
            tabBarController.tabBar.barTintColor = UIColor.black
            tabBarController.tabBar.tintColor = UIColor.white
            tabBarController.tabBar.unselectedItemTintColor = UIColor.gray
            tabBarController.tabBar.backgroundColor = .black
            tabBarController.tabBar.heightAnchor.constraint(equalToConstant: 300).isActive = true
            tabBarController.tabBar.layer.cornerRadius = 25
        }
}
