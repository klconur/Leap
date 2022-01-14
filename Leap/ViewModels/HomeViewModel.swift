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

extension HomeViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .starting:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CardViewCell.identifier, for: indexPath) as? CardViewCell {
                cell.clockIcon.isHidden = false
                if let item = items[indexPath.section] as? HomeViewModelStartingItem, let data = item.item {
                    cell.cardTitle.text = data.title
                    cell.subtitleLabel.text = data.subtitle
                    cell.cardImage.sd_setImage(with: URL(string: data.image ?? ""), placeholderImage: UIImage(named: "Placeholder"))
                }
                return cell
            }
        case .yourUpcomings:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HorizontalCardViewCell.identifier, for: indexPath) as? HorizontalCardViewCell {
                cell.setIconHidden(false)
                if let item = items[indexPath.section] as? HomeViewModelYourUpcomingItem, let data = item.items {
                    cell.setItems(data)
                }
                return cell
            }
        case .upcomings:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HorizontalCardViewCell.identifier, for: indexPath) as? HorizontalCardViewCell {
                cell.setIconHidden(true)
                if let item = items[indexPath.section] as? HomeViewModelUpcomingItem, let data = item.items {
                    cell.setItems(data)
                }
                return cell
            }
        case .explore:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CardViewCell.identifier, for: indexPath) as? CardViewCell {
                cell.clockIcon.isHidden = true
                if let item = items[indexPath.section] as? HomeViewModelExploreItem, let data = item.items {
                    cell.cardTitle.text = data[indexPath.row].title
                    cell.subtitleLabel.text = data[indexPath.row].subtitle
                    cell.cardImage.sd_setImage(with: URL(string: data[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "Placeholder"))
                }
                return cell
            }
        }
        return UITableViewCell()
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
        return 1
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
        return 1
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
}

