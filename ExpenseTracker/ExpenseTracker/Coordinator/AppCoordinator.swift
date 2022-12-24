//
//  AppCoordinator.swift
//  ExpenseTracker
//
//  Created by Kyzu on 28.11.22.
//

import Foundation
import UIKit

class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainViewController()
        vc.coordinator = self
        vc.viewModel = MainViewModel()
        navigationController.pushViewController(vc, animated: true)
    }

    func toBack() {
        self.navigationController.popViewController(animated: true)
    }
    
}

