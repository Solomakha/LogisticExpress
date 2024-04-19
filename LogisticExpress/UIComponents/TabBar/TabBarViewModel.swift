import Foundation
import UIKit

// Модель для описания вкладки
struct TabBarModel {
    var title: String
    var imageName: String
    var coordinator: Coordinator

    init(title: String, imageName: String, coordinator: Coordinator) {
        self.title = title
        self.imageName = imageName
        self.coordinator = coordinator
    }
}

class TabBarViewModel {
    var tabs: [TabBarModel] = []

    init() {
        setupTabs()
    }

    private func setupTabs() {
            let mainCoordinator = MainScreenCoordinator(navigationController: UINavigationController())
            let mainTab = TabBarModel(title: "Замовлення", imageName: "MainScreen", coordinator: mainCoordinator)
    
            let secondCoordinator = DeliveryScreenCoordinator(navigationController: UINavigationController())
            let secondTab = TabBarModel(title: "Відправки", imageName: "delivery-truck", coordinator: secondCoordinator)
    
            let profileCoordinator = ProfileScreenCoordinator(navigationController: UINavigationController())
            let profileTab = TabBarModel(title: "Профіль", imageName: "user", coordinator: profileCoordinator)
    
            tabs = [mainTab, secondTab, profileTab]
        }
}
