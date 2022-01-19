//
//  SectionHeader.swift
//  Leap
//
//  Created by ONUR KILIC on 18.01.2022.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let identifier = "sectionHeader"

    var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        label.sizeToFit()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
   }

   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
     
}
