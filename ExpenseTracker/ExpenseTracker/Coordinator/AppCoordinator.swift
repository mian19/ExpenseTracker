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
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(rgb: 0x222a68), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 27.adjustSize(), weight: .medium)]
        self.navigationController.navigationBar.barTintColor = UIColor.init(rgb: 0xd8e2dc)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toAddTransaction() {
        let vc = AddTransactionViewController()
        vc.coordinator = self
        vc.viewModel = AddTransactionViewModel()
        navigationController.pushViewController(vc, animated: true)
    }

    func toBack() {
        self.navigationController.popViewController(animated: true)
    }
    
}

