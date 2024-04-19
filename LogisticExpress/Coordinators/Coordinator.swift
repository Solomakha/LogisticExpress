import Foundation
import UIKit

// Протокол координатора
protocol Coordinator: AnyObject{
    var navigationController: UINavigationController {get set}
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

// Расширение для базовой реализации протокола
extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
