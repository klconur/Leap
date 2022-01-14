//
//  CardViewCell.swift
//  Leap
//
//  Created by ONUR KILIC on 12.01.2022.
//

import UIKit
import SDWebImage

class HorizontalCardViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    static let identifier = "horizontalCell"
    var collectionView: UICollectionView?
    private var isLoading = true
    private var isIconHidden = true
    private var items: [Upcomings]?
    var delegate: CellActionDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.itemSize = CGSize(width: 180, height: 111)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: layout)
        
        addSubview(collectionView!)
        collectionView?.backgroundColor = .clear
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)

        setCollectionViewConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCollectionViewConstraints() {
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setIconHidden(_ hidden: Bool) {
        self.isIconHidden = hidden
    }
    
    func setItems(_ items: [Upcomings]) {
        self.items = items
        isLoading = false
        collectionView?.reloadData()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 210, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = items {
            return data.count
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.checkIcon.isHidden = isIconHidden
        if let data = items {
            cell.cardTitle.text = data[indexPath.row].title
            cell.cardImage.sd_setImage(with: URL(string: data[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "Placeholder"))
            cell.addTapGesture {
                if let delegate = self.delegate {
                    delegate.handleTap(data[indexPath.row].title!)
                }
            }
        }
        return cell
    }
}
