//
//  PopUpView.swift
//  ExpenseTracker
//
//  Created by Kyzu on 24.12.22.
//

import UIKit

class PopUpViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    var contentView: UIView!
    var label: UILabel!
    var textField: UITextField!
    var topUpWalletButton: UIButton!
    var cancelButton: UIButton!
    
    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        view = customView
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(focus)))
        view.addSubview(scrollView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(rgb: 0x000000, a: 0.7)
        registerForKeyboardNotifications()
        setViews()
        moveIn()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize =  CGSize(width: view.bounds.width, height: view.bounds.height)
    }
    
    private func setViews() {
        setScrollView()
        setContentView()
        setLabel()
        setTextField()
        setTopUpWalletButton()
        setCancelButton()
    }
    
    private func setScrollView() {
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setContentView() {
        contentView = UIView()
        contentView.backgroundColor = UIColor.init(rgb: 0x93b7be)
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        contentView.frame.size = CGSize(width: 300.adjustSize(), height: 300.adjustSize())
        contentView.center = view.center
        scrollView.addSubview(contentView)
    }
    
    private func setLabel() {
        label = UILabel()
        scrollView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Enter the amount $:"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30.adjustSize()).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.adjustSize()).isActive = true
        label.heightAnchor.constraint(equalToConstant: 25.adjustSize()).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.adjustSize()).isActive = true
    }
    
    private func setTextField() {
        textField = UITextField()
        scrollView.addSubview(textField)
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
    
    private func setTopUpWalletButton() {
        topUpWalletButton = UIButton()
        scrollView.addSubview(topUpWalletButton)
        topUpWalletButton.translatesAutoresizingMaskIntoConstraints = false
        topUpWalletButton.setTitle("Top up", for: .normal)
        topUpWalletButton.layer.cornerRadius = 10.adjustSize()
        topUpWalletButton.clipsToBounds = true
        topUpWalletButton.backgroundColor = UIColor.init(rgb: 0x4a6c6f)
        
        topUpWalletButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.adjustSize()).isActive = true
        topUpWalletButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        topUpWalletButton.heightAnchor.constraint(equalToConstant: 40.adjustSize()).isActive = true
        topUpWalletButton.widthAnchor.constraint(equalToConstant: 100.adjustSize()).isActive = true
    }
    
    private func setCancelButton() {
        cancelButton = UIButton()
        scrollView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.layer.cornerRadius = 10.adjustSize()
        cancelButton.clipsToBounds = true
        cancelButton.backgroundColor = UIColor.init(rgb: 0x4a6c6f)
        cancelButton.addTarget(self, action: #selector(onCancelButton), for: .touchUpInside)
        
        cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.adjustSize()).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 40.adjustSize()).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100.adjustSize()).isActive = true
    }

    //MARK: - Actions
    @objc private func focus() {
        scrollView.endEditing(true)
    }
    
    @objc private func onCancelButton() {
        moveOut()
    }
    
    //MARK: - effects for appearing
    func moveIn() {
        self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        self.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.24) {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0
        }
    }
    
    func moveOut() {
        UIView.animate(withDuration: 0.24, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            self.view.alpha = 0.0
        }) { _ in
            self.view.removeFromSuperview()
        }
    }
    
    //MARK: - moveKeyboard
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(_ notification: Notification) {
        
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let offset = view.frame.maxY - contentView.frame.maxY
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
        } else {
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: keyboardViewEndFrame.height - offset + 20)
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
}
