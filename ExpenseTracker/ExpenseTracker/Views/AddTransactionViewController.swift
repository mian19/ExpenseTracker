//
//  AddTransactionViewController.swift
//  ExpenseTracker
//
//  Created by Kyzu on 25.12.22.
//

import UIKit

class AddTransactionViewController: UIViewController {

    var viewModel: AddTransactionViewModel!
    weak var coordinator: AppCoordinator?
    
    var label: UILabel!
    var textField: UITextField!
    var categoriesPicker: UIPickerView!
    var addTransactionButton: UIButton!
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.init(rgb: 0xFFDC80)
        setViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func setViews() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(focus)))
        setLabel()
        setTextField()
        setPicker()
        setAddTransactionButton()
    }
    
    private func setLabel() {
        label = UILabel()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Enter the amount and select category"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.adjustSize()).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.adjustSize()).isActive = true
        label.heightAnchor.constraint(equalToConstant: 25.adjustSize()).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.adjustSize()).isActive = true
    }
    
    private func setTextField() {
        textField = UITextField()
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 18.adjustSize())
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15.adjustSize(), height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.backgroundColor = UIColor.init(rgb: 0xffffff)
        textField.textColor = UIColor.init(rgb: 0x000000)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.keyboardType = .numberPad
        
        textField.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50.adjustSize()).isActive = true
        textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
    }
    
    private func setPicker() {
        categoriesPicker = UIPickerView()
        categoriesPicker.translatesAutoresizingMaskIntoConstraints = false
        
        categoriesPicker.delegate = self
        categoriesPicker.dataSource = self
        view.addSubview(categoriesPicker)
        categoriesPicker.setValue(UIColor.init(rgb: 0x000000), forKeyPath: "textColor")
        
        categoriesPicker.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        categoriesPicker.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
        categoriesPicker.heightAnchor.constraint(equalToConstant: 100.adjustSize()).isActive = true
        categoriesPicker.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
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
        
        addTransactionButton.topAnchor.constraint(equalTo: categoriesPicker.bottomAnchor, constant: 10.adjustSize()).isActive = true
        addTransactionButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        addTransactionButton.heightAnchor.constraint(equalToConstant: 40.adjustSize()).isActive = true
        addTransactionButton.widthAnchor.constraint(equalToConstant: 190.adjustSize()).isActive = true
    }
    
    //MARK: - Bindings
    func bindViewModel() {
        viewModel.isEnoughMoney.bind({ value in
            DispatchQueue.main.async {
                if value == false {
                    self.textField.text = ""
                    self.showAlert(title: "Error", message: "not enough money, top up your wallet!")
                } else {
                    self.coordinator?.toBack()
                }
                    
            }
        })
    }

    // MARK: - Actions
    
    @objc private func focus() {
        view.endEditing(true)
    }
    
    @objc func onAddTransactionButton() {
        if let minusSum = Int(textField?.text ?? ""), minusSum != 0 {
            viewModel.processingTransaction(sum: minusSum)
        } else {
            textField?.text = ""
            showAlert(title: "Error", message: "amount can't be empty, Zero or text value")
        }
    }

}

//MARK: - work with Picker

extension AddTransactionViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return CategoryTrans.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CategoryTrans.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.currentCategory.value = CategoryTrans.allCases[row].rawValue
    }
    
}
