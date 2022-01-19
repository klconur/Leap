//
//  CardViewCell.swift
//  Leap
//
//  Created by ONUR KILIC on 12.01.2022.
//

import UIKit
import UIView_Shimmer

class CardViewCell: UICollectionViewCell, ShimmeringViewProtocol {
    
    static let cardIdentifier = "cardCell"
    var containerView = UIView()
    var cardImage = UIImageView()
    var icon = UIImageView()
    var seperatorView = UIView()
    var cardTitle = UILabel()
    var subtitleLabel = UILabel()
    var titleBottomConstraint: NSLayoutConstraint!
    
    var shimmeringAnimatedItems: [UIView] {
            [
                cardImage,
                cardTitle,
                subtitleLabel
            ]
        }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        containerView.addSubview(cardImage)
        containerView.addSubview(icon)
        containerView.addSubview(seperatorView)
        containerView.addSubview(cardTitle)
        containerView.addSubview(subtitleLabel)
        addSubview(containerView)
        configureView()
        configureImageView()
        configureClockIcon()
        configureSeperatorView()
        configureTitle()
        configureSubtitle()
        setImageConstraints()
        setClockIconConstraints()
        setSeperatorConstraints()
        setTitleConstraint()
        setSubtitleConstraint()
        setContainerConstraints()
      }
    
    required init?(coder _: NSCoder) {
             fatalError("init(coder:) has not been implemented")
         }
    
    private func configureView() {
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.cornerRadius = 9
        containerView.layer.masksToBounds = true
    }
    
    private func configureImageView() {
        cardImage.clipsToBounds = true
        cardImage.contentMode = .scaleAspectFill
    }
    
    private func configureClockIcon() {
        icon.clipsToBounds = true
        icon.contentMode = .scaleAspectFill
        icon.image = UIImage(named: "Clock")
    }
    
    private func configureSeperatorView() {
        seperatorView.backgroundColor = .black
    }
    
    private func configureTitle() {
        cardTitle.numberOfLines = 0
        cardTitle.adjustsFontSizeToFitWidth = true
        cardTitle.font = .systemFont(ofSize: 18, weight: .bold)
        cardTitle.text = "Placeholder"
    }
    
    private func setContainerConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setImageConstraints() {
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        cardImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        cardImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
//        cardImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        cardImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardImage.bottomAnchor.constraint(equalTo: seperatorView.topAnchor).isActive = true
    }
    
    private func setClockIconConstraints() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        icon.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    }
    
    private func setSeperatorConstraints() {
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        seperatorView.leadingAnchor.constraint(equalTo: cardImage.leadingAnchor).isActive = true
        seperatorView.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor).isActive = true
        seperatorView.bottomAnchor.constraint(equalTo: cardTitle.topAnchor, constant: -5).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func setTitleConstraint() {
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        cardTitle.leadingAnchor.constraint(equalTo: cardImage.leadingAnchor, constant: 15).isActive = true
        cardTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleBottomConstraint = cardTitle.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -5)
        titleBottomConstraint.isActive = true
        cardTitle.preferredMaxLayoutWidth = 180
    }
    
    private func configureSubtitle() {
        subtitleLabel.numberOfLines = 0
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.preferredMaxLayoutWidth = 180
        subtitleLabel.text = "Subtitle Placeholder"
    }
    
    private func setSubtitleConstraint() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.leadingAnchor.constraint(equalTo: cardTitle.leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7).isActive = true
    }
}
