//
//  SmallCardViewCell.swift
//  Leap
//
//  Created by ONUR KILIC on 18.01.2022.
//

import UIKit

class SmallCardViewCell: CardViewCell {
   
    static let smallCardIdentifier = "smallCardCell"
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        icon.image = UIImage(named: "Check-Circle")
        titleBottomConstraint.isActive = false
        subtitleLabel.isHidden = true
        cardTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7).isActive = true
    }
}
