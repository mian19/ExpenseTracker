//
//  ViewController.swift
//  ExpenseTracker
//
//  Created by Kyzu on 24.12.22.
//

import UIKit

class MainViewController: UIViewController {

    var viewModel: MainViewModel!
    weak var coordinator: AppCoordinator?
    
    var bitcoinExchangeLabel: UILabel!
    var walletLabel: UILabel!
    var topUpButton: UIButton!
    var addTransactionButton: UIButton!
    var transactionsTableView: UITableView!
    
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.init(rgb: 0xd8e2dc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

