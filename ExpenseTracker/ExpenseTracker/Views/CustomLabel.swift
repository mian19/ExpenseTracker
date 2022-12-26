//
//  CustomLabel.swift
//  Team Click
//
//  Created by Kyzu on 24.08.22.
//

import UIKit

class CustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(size: CGFloat ) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.adjustsFontSizeToFitWidth = true
        self.font = UIFont.systemFont(ofSize: size, weight: .medium)
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
