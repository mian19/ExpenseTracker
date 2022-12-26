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
    var popUpView: PopUpViewController!
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.init(rgb: 0xd8e2dc)
        setViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        title = "Expense Tracker"
        viewModel.fetchBTC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getMyWallet()
        viewModel.getDataFromDB()
        transactionsTableView.setContentOffset(.zero, animated: true)
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
        bitcoinExchangeLabel.textColor = UIColor.init(rgb: 0x000000)
        bitcoinExchangeLabel.textAlignment = .right
        bitcoinExchangeLabel.numberOfLines = 2
        bitcoinExchangeLabel.text = viewModel.btcCourse.value
        
        bitcoinExchangeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.adjustSize()).isActive = true
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
        walletLabel.text = "My wallet:\n$\(viewModel.myWallet.value)"
        walletLabel.adjustsFontSizeToFitWidth = true
        walletLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        walletLabel.textColor = UIColor.init(rgb: 0x000000)
        
        walletLabel.topAnchor.constraint(equalTo: bitcoinExchangeLabel.bottomAnchor, constant: 25.adjustSize()).isActive = true
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
        topUpButton.addTarget(self, action: #selector(onTopUpButton), for: .touchUpInside)
        
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
        addTransactionButton.addTarget(self, action: #selector(onAddTransactionButton), for: .touchUpInside)
        
        addTransactionButton.topAnchor.constraint(equalTo: walletLabel.bottomAnchor, constant: 10.adjustSize()).isActive = true
        addTransactionButton.leadingAnchor.constraint(equalTo: walletLabel.leadingAnchor).isActive = true
        addTransactionButton.heightAnchor.constraint(equalToConstant: 40.adjustSize()).isActive = true
        addTransactionButton.widthAnchor.constraint(equalToConstant: 190.adjustSize()).isActive = true
    }
    
    private func setTransactionsTableView() {
        transactionsTableView = UITableView()
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        transactionsTableView.backgroundColor = .clear
        transactionsTableView.showsVerticalScrollIndicator = false
        transactionsTableView.layer.cornerRadius = 15
        transactionsTableView.clipsToBounds = true
        transactionsTableView.register(TransactionViewCell.self, forCellReuseIdentifier: TransactionViewCell.reuseID)
        
        view.addSubview(transactionsTableView)
        transactionsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        transactionsTableView.leadingAnchor.constraint(equalTo: walletLabel.leadingAnchor)
            .isActive = true
        transactionsTableView.trailingAnchor.constraint(equalTo: topUpButton.trailingAnchor).isActive = true
        transactionsTableView.topAnchor.constraint(equalTo: addTransactionButton.bottomAnchor, constant: 20.adjustSize()).isActive = true
        transactionsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10.adjustSize()).isActive = true
        
        let headerView = UILabel()
        headerView.frame = CGRect(x: 0, y: 0, width: transactionsTableView.frame.width, height: 50)
        headerView.backgroundColor = .clear
        headerView.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        headerView.textColor = UIColor.init(rgb: 0x000000)
        headerView.textAlignment = .center
        headerView.text = "My transactions"
        
        transactionsTableView.tableHeaderView = headerView
        transactionsTableView.tableFooterView = UIView()
    }
    
    
    //MARK: - Bindings
    func bindViewModel() {
        viewModel.btcCourse.bind({ newBTC in
            DispatchQueue.main.async {
                self.bitcoinExchangeLabel.text = newBTC
            }
        })
        
        viewModel.myWallet.bind({ newBTC in
            DispatchQueue.main.async {
                self.walletLabel.text = "My wallet:\n$\(newBTC)"
                self.viewModel.getDataFromDB()
                self.transactionsTableView.setContentOffset(.zero, animated: true)
                self.transactionsTableView.reloadData()
            }
        })
    }
    
    //MARK: - Actions
    
    @objc func onTopUpButton() {
        popUpView = PopUpViewController()
        self.addChild(popUpView)
        popUpView.view.frame = self.view.frame
        popUpView.topUpWalletButton.addTarget(self, action: #selector(onTopUpWalletButton), for: .touchUpInside)
        self.view.addSubview(popUpView.view)
    }
    
    @objc func onTopUpWalletButton() {
        if let addedSum = Int(popUpView.textField?.text ?? ""), addedSum != 0 {
            viewModel.addMoney(sum: addedSum)
            popUpView.moveOut()
        } else {
            popUpView.textField?.text = ""
            popUpView.showAlert(title: "Error", message: "amount can't be empty, Zero or text value")
        }
    }
    
    @objc func onAddTransactionButton() {
        if viewModel.myWallet.value > 0 {
            coordinator?.toAddTransaction()
        } else {
            self.showAlert(title: "Error", message: "Top up your wallet!")
        }
    }
    
}

//MARK: - work with table
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.fetchResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.fetchResultController.sections![section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fetchResultController.sections?[section].numberOfObjects ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionViewCell.reuseID, for: indexPath) as! TransactionViewCell
        let person = viewModel.fetchResultController.object(at: indexPath) as! Transaction
        cell.timeLabel.text = person.date.dateForTransCell()
        cell.sumLabel.text = "$" + String(person.amount)
        cell.categoryLabel.text = person.category
        if person.category == "Income" {
            cell.setColorForLabels(color: UIColor.init(rgb: 0x34b334))
        } else {
            cell.setColorForLabels(color: UIColor.init(rgb: 0xfa3901))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
