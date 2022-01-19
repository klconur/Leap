//
//  HomeViewModel.swift
//  Leap
//
//  Created by ONUR KILIC on 13.01.2022.
//

import UIKit
import SDWebImage

enum HomeViewModelItemType {
    case starting
    case explore
    case upcomings
    case yourUpcomings
}

protocol HomeViewModelItem {
    var type: HomeViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
    func bindData(data: Data)
    func getLayoutSection() -> NSCollectionLayoutSection
    func getCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func getContent(_ index: Int) -> String
}

class HomeViewModel : NSObject {
    
    var items = [HomeViewModelItem]()
    
    override init() {
        super.init()
        
        let startingItem = HomeViewModelStartingItem()
        items.append(startingItem)
        let yourUpcomingItem = HomeViewModelYourUpcomingItem()
        items.append(yourUpcomingItem)
        let upcomingItem = HomeViewModelUpcomingItem()
        items.append(upcomingItem)
        let exploreItem = HomeViewModelExploreItem()
        items.append(exploreItem)
    }
    
}

extension HomeViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as! SectionHeader
             sectionHeader.label.text = items[indexPath.section].sectionTitle
             return sectionHeader
        } else {
             return UICollectionReusableView()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.section]
        return item.getCell(collectionView, indexPath: indexPath)
    }
}

class HomeViewModelStartingItem: HomeViewModelItem {
    
    var item: Starting?
    
    var type: HomeViewModelItemType {
        return .starting
    }
    
    var sectionTitle: String {
        return NSLocalizedString("Starting momentarily", comment: "")
    }
    
    var rowCount: Int {
        return 1
    }
    
    func content() -> String? {
        if let item = item {
            return item.title
        }
        return nil
    }
    
    func bindData(data: Data) {
        item = data.starting
    }
    
    func getLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(230))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        group.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
    
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func getCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewCell.cardIdentifier, for: indexPath) as! CardViewCell
        cell.icon.isHidden = false
        if let item = item {
            cell.cardTitle.text = item.title
            cell.subtitleLabel.text = item.subtitle
            cell.cardImage.sd_setImage(with: URL(string: item.image ?? ""), placeholderImage: UIImage(named: "Placeholder"))
        }
        return cell
    }
    
    func getContent(_ index: Int) -> String {
        if let item = item {
            return item.title ?? ""
        }
        return ""
    }
}

class HomeViewModelYourUpcomingItem: HomeViewModelItem {
    var items: [Upcomings]?
    
    var type: HomeViewModelItemType {
        return .yourUpcomings
    }
    
    var sectionTitle: String {
        return NSLocalizedString("Your upcoming chats", comment: "")
    }
    
    var rowCount: Int {
        if let items = items {
            return items.count
        }
        return 3
    }
    
    func content(_ row: Int) -> String? {
        if let items = items {
            return items[row].title
        }
        return nil
    }
    
    func bindData(data: Data) {
        items = data.your_upcomings
    }
    
    func getLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:
        .fractionalHeight(1))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.top = 5
        item.contentInsets.bottom = 15

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
        heightDimension: .fractionalWidth(0.35))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 8, bottom: 10, trailing: 8)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func getCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallCardViewCell.smallCardIdentifier, for: indexPath) as! SmallCardViewCell
        cell.icon.isHidden = false
        if let items = items {
            cell.cardTitle.text = items[indexPath.row].title
            //cell.subtitleLabel.text = items[index].subtitle
            cell.cardImage.sd_setImage(with: URL(string: items[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "Placeholder"))
        }
        return cell
    }
    
    func getContent(_ index: Int) -> String {
        if let items = items {
            return items[index].title ?? ""
        }
        return ""
    }
}

class HomeViewModelUpcomingItem: HomeViewModelItem {
    var items: [Upcomings]?
    
    var type: HomeViewModelItemType {
        return .upcomings
    }
    
    var sectionTitle: String {
        return NSLocalizedString("Explore upcoming bite size chats", comment: "")
    }
    
    var rowCount: Int {
        if let items = items {
            return items.count
        }
        return 3
    }
    
    func content(_ row: Int) -> String? {
        if let items = items {
            return items[row].title
        }
        return nil
    }
    
    func bindData(data: Data) {
        items = data.upcomings
    }
    
    func getLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:
        .fractionalHeight(1))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.top = 5
        item.contentInsets.bottom = 15

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
        heightDimension: .fractionalWidth(0.35))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func getCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallCardViewCell.smallCardIdentifier, for: indexPath) as! SmallCardViewCell
        cell.icon.isHidden = true
        if let items = items {
            cell.cardTitle.text = items[indexPath.row].title
            cell.cardImage.sd_setImage(with: URL(string: items[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "Placeholder"))
        }
        return cell
    }
    
    func getContent(_ index: Int) -> String {
        if let items = items {
            return items[index].title ?? ""
        }
        return ""
    }
}

class HomeViewModelExploreItem: HomeViewModelItem {
    var items: [Explore]?
    
    var type: HomeViewModelItemType {
        return .explore
    }
    
    var sectionTitle: String {
        return NSLocalizedString("More great bite size chats", comment: "")
    }
    
    var rowCount: Int {
        if let items = items {
            return items.count
        }
        return 3
    }
    
    func content(_ row: Int) -> String? {
        if let items = items {
            return items[row].title
        }
        return nil
    }
    
    func bindData(data: Data) {
        items = data.explore
    }
    
    func getLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func getCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewCell.cardIdentifier, for: indexPath) as! CardViewCell
        cell.icon.isHidden = true
        if let items = items {
            cell.cardTitle.text = items[indexPath.row].title
            cell.subtitleLabel.text = items[indexPath.row].subtitle
            cell.cardImage.sd_setImage(with: URL(string: items[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "Placeholder"))
        }
        return cell
    }
    
    func getContent(_ index: Int) -> String {
        if let items = items {
            return items[index].title ?? ""
        }
        return ""
    }
}

