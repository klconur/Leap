//
//  CollectionViewCell.swift
//  Leap
//
//  Created by ONUR KILIC on 12.01.2022.
//

import UIKit
import UIView_Shimmer

class CollectionViewCell: UICollectionViewCell, ShimmeringViewProtocol {

    static let identifier = "collectionViewCell"
    var containerView = UIView()
    var cardImage = UIImageView()
    var checkIcon = UIImageView()
    var seperatorView = UIView()
    var cardTitle = UILabel()
    
    var shimmeringAnimatedItems: [UIView] {
            [
                cardImage,
                cardTitle
            ]
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        containerView.addSubview(cardImage)
        containerView.addSubview(checkIcon)
        containerView.addSubview(seperatorView)
        containerView.addSubview(cardTitle)
        addSubview(containerView)
        configureView()
        configureImageView()
        configureCheckIcon()
        configureSeperatorView()
        configureTitle()
        setContainerConstraints()
        setImageConstraints()
        setCheckIconConstraints()
        setSeperatorConstraints()
        setTitleConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.cornerRadius = 9
        containerView.layer.masksToBounds = true
    }
    
    func configureImageView() {
        cardImage.clipsToBounds = true
        cardImage.contentMode = .scaleAspectFill
    }
    
    func configureCheckIcon() {
        checkIcon.clipsToBounds = true
        checkIcon.contentMode = .scaleAspectFill
        checkIcon.image = UIImage(named: "Check-Circle")
    }
    
    func configureSeperatorView() {
        seperatorView.backgroundColor = .black
    }
    
    func configureTitle() {
        cardTitle.numberOfLines = 0
        cardTitle.adjustsFontSizeToFitWidth = true
        cardTitle.font = .systemFont(ofSize: 17, weight: .bold)
        cardTitle.text = "Placeholder"
    }
    
    func setContainerConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setImageConstraints() {
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        cardImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cardImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        cardImage.widthAnchor.constraint(equalToConstant: 210).isActive = true
    }
    
    func setCheckIconConstraints() {
        checkIcon.translatesAutoresizingMaskIntoConstraints = false
        checkIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9).isActive = true
        checkIcon.topAnchor.constraint(equalTo: topAnchor, constant: 9).isActive = true
    }
    
    func setSeperatorConstraints() {
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        seperatorView.leadingAnchor.constraint(equalTo: cardImage.leadingAnchor).isActive = true
        seperatorView.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor).isActive = true
        seperatorView.topAnchor.constraint(equalTo: cardImage.bottomAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setTitleConstraint() {
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        cardTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        cardTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        cardTitle.preferredMaxLayoutWidth = 180
    }
}
