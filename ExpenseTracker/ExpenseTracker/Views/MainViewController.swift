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
        
        setViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func setViews() {
        setBitcoinExchangeLabel()
        setWalletLabel()
        setTopUpButton()
        setAddTransactionButton()
        setTransactionsTableView()
    }
    
    private func setBitcoinExchangeLabel() {
        bitcoinExchangeLabel = UILabel()
        view.addSubview(bitcoinExchangeLabel)
        bitcoinExchangeLabel.translatesAutoresizingMaskIntoConstraints = false
        bitcoinExchangeLabel.textAlignment = .right
        bitcoinExchangeLabel.numberOfLines = 2
        bitcoinExchangeLabel.text = "1 BTC = 16963453.88 USD\n updated: 23.12 at 12:54"
        
        bitcoinExchangeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.adjustSize()).isActive = true
        bitcoinExchangeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.adjustSize()).isActive = true
        bitcoinExchangeLabel.heightAnchor.constraint(equalToConstant: 60.adjustSize()).isActive = true
        bitcoinExchangeLabel.widthAnchor.constraint(equalToConstant: 250.adjustSize()).isActive = true
        
    }
    
    private func setWalletLabel() {
        walletLabel = UILabel()
        view.addSubview(walletLabel)
        walletLabel.translatesAutoresizingMaskIntoConstraints = false
        walletLabel.textAlignment = .left
        walletLabel.numberOfLines = 2
        walletLabel.text = "My wallet:\n$2324241241"
        walletLabel.adjustsFontSizeToFitWidth = true
        walletLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        
        walletLabel.topAnchor.constraint(equalTo: bitcoinExchangeLabel.bottomAnchor, constant: 30.adjustSize()).isActive = true
        walletLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.adjustSize()).isActive = true
        walletLabel.heightAnchor.constraint(equalToConstant: 80.adjustSize()).isActive = true
        walletLabel.widthAnchor.constraint(equalToConstant: 200.adjustSize()).isActive = true
    }
    
    private func setTopUpButton() {
        topUpButton = UIButton()
        view.addSubview(topUpButton)
        topUpButton.translatesAutoresizingMaskIntoConstraints = false
        topUpButton.setTitle("Top up", for: .normal)
        topUpButton.layer.cornerRadius = 10.adjustSize()
        topUpButton.clipsToBounds = true
        topUpButton.backgroundColor = UIColor.init(rgb: 0x4a6c6f)
        topUpButton.topAnchor.constraint(equalTo: walletLabel.topAnchor).isActive = true
        topUpButton.trailingAnchor.constraint(equalTo: bitcoinExchangeLabel.trailingAnchor).isActive = true
        topUpButton.heightAnchor.constraint(equalTo: walletLabel.heightAnchor).isActive = true
        topUpButton.widthAnchor.constraint(equalToConstant: 80.adjustSize()).isActive = true
    }
    
    private func setAddTransactionButton() {
        addTransactionButton = UIButton()
        view.addSubview(addTransactionButton)
        addTransactionButton.translatesAutoresizingMaskIntoConstraints = false
        addTransactionButton.setTitle("Add transaction", for: .normal)
        addTransactionButton.layer.cornerRadius = 10.adjustSize()
        addTransactionButton.clipsToBounds = true
        addTransactionButton.backgroundColor = UIColor.init(rgb: 0x4a6c6f)
        addTransactionButton.topAnchor.constraint(equalTo: walletLabel.bottomAnchor, constant: 10.adjustSize()).isActive = true
        addTransactionButton.leadingAnchor.constraint(equalTo: walletLabel.leadingAnchor).isActive = true
        addTransactionButton.heightAnchor.constraint(equalToConstant: 40.adjustSize()).isActive = true
        addTransactionButton.widthAnchor.constraint(equalToConstant: 150.adjustSize()).isActive = true
    }
    
    private func setTransactionsTableView() {
        transactionsTableView = UITableView()
        transactionsTableView.backgroundColor = .red
        view.addSubview(transactionsTableView)
        transactionsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        transactionsTableView.leadingAnchor.constraint(equalTo: walletLabel.leadingAnchor)
        .isActive = true
        transactionsTableView.trailingAnchor.constraint(equalTo: topUpButton.trailingAnchor).isActive = true
        transactionsTableView.topAnchor.constraint(equalTo: addTransactionButton.bottomAnchor, constant: 20.adjustSize()).isActive = true
        transactionsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10.adjustSize()).isActive = true
    }
    

    



}

