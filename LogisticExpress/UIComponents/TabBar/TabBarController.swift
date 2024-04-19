//
//  TabBarController.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 03.03.2024.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    var viewModel: TabBarViewModel! {
        didSet {
            setupTabs()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Необходимо установить viewModel перед загрузкой view
        viewModel = TabBarViewModel()
    }
    
    private func setupTabs() {
        viewControllers = viewModel.tabs.map { model in
            let navigationController = model.coordinator.navigationController
            navigationController.tabBarItem = UITabBarItem(title: model.title, image: UIImage(named: model.imageName), tag: 0)
            return navigationController
        }
    }
}
