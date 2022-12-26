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
    
    convenience init( colorHex: Int, size: CGFloat, fontStyle: String = "Circe-Regular") {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.adjustsFontSizeToFitWidth = true
        self.font = UIFont(name: fontStyle, size: size)
        self.textColor = UIColor.init(rgb: colorHex)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
