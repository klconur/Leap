//
//  CardViewCell.swift
//  Leap
//
//  Created by ONUR KILIC on 12.01.2022.
//

import UIKit
import UIView_Shimmer

class CardViewCell: UITableViewCell, ShimmeringViewProtocol {
    
    static let identifier = "cardCell"
    var containerView = UIView()
    var cardImage = UIImageView()
    var clockIcon = UIImageView()
    var seperatorView = UIView()
    var cardTitle = UILabel()
    var subtitleLabel = UILabel()
    
    var shimmeringAnimatedItems: [UIView] {
            [
                cardImage,
                cardTitle,
                subtitleLabel
            ]
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerView.addSubview(cardImage)
        containerView.addSubview(clockIcon)
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
    
    func configureClockIcon() {
        clockIcon.clipsToBounds = true
        clockIcon.contentMode = .scaleAspectFill
        clockIcon.image = UIImage(named: "Clock")
    }
    
    func configureSeperatorView() {
        seperatorView.backgroundColor = .black
    }
    
    func configureTitle() {
        cardTitle.numberOfLines = 0
        cardTitle.adjustsFontSizeToFitWidth = true
        cardTitle.font = .systemFont(ofSize: 18, weight: .bold)
        cardTitle.text = "Placeholder"
    }
    
    func setContainerConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        containerView.bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    func setImageConstraints() {
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        cardImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        cardImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        cardImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        cardImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    func setClockIconConstraints() {
        clockIcon.translatesAutoresizingMaskIntoConstraints = false
        clockIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        clockIcon.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
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
        cardTitle.leadingAnchor.constraint(equalTo: cardImage.leadingAnchor, constant: 15).isActive = true
        cardTitle.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 8).isActive = true
        cardTitle.preferredMaxLayoutWidth = 180
    }
    
    func configureSubtitle() {
        subtitleLabel.numberOfLines = 0
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.preferredMaxLayoutWidth = 180
        subtitleLabel.text = "Subtitle Placeholder"
    }
    
    func setSubtitleConstraint() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.leadingAnchor.constraint(equalTo: cardTitle.leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: cardTitle.bottomAnchor, constant: 7).isActive = true
    }
}
