//
//  TransactionViewCell.swift
//  ExpenseTracker
//
//  Created by Kyzu on 25.12.22.
//

import UIKit

class TransactionViewCell: UITableViewCell {

    static let reuseID = "TransactionViewCell"
    
    var timeLabel: CustomLabel!
    var sumLabel: CustomLabel!
    var categoryLabel: CustomLabel!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Self.reuseID)
        backgroundColor = .clear
        selectionStyle = .none
        setViews()
    }
    
    private func setViews() {
        setTimeLabel()
        setSumLabel()
        setCategoryLabel()
    }
    
    private func setTimeLabel() {
        timeLabel = CustomLabel.init(size: 20)
        contentView.addSubview(timeLabel)
        
        timeLabel.widthAnchor.constraint(equalToConstant: 75.adjustSize()).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.adjustSize()).isActive = true
    }
    
    private func setSumLabel() {
        sumLabel = CustomLabel.init(size: 20)
        contentView.addSubview(sumLabel)
        
        sumLabel.widthAnchor.constraint(equalToConstant: 175.adjustSize()).isActive = true
        sumLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        sumLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        sumLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 5.adjustSize()).isActive = true
    }
    
    private func setCategoryLabel() {
        categoryLabel = CustomLabel.init(size: 20)
        contentView.addSubview(categoryLabel)
        
        categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5.adjustSize()).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: sumLabel.trailingAnchor, constant: 5.adjustSize()).isActive = true
    }
    
    func setColorForLabels(color: UIColor) {
        [timeLabel, sumLabel, categoryLabel].forEach {$0?.textColor = color}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
