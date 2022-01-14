//
//  ViewController.swift
//  Leap
//
//  Created by ONUR KILIC on 12.01.2022.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView?
    fileprivate let viewModel = HomeViewModel()
    private var errorView: UIHostingController<ErrorView>!
    private var apiService : APIService!
    private var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiService =  APIService()
        homeTableView?.dataSource = viewModel
        homeTableView?.estimatedSectionHeaderHeight = 30
        homeTableView?.sectionHeaderHeight = UITableView.automaticDimension
        homeTableView?.rowHeight = UITableView.automaticDimension
        homeTableView?.estimatedRowHeight = UITableView.automaticDimension
        homeTableView?.register(CardViewCell.self, forCellReuseIdentifier: CardViewCell.identifier)
        homeTableView?.register(HorizontalCardViewCell.self, forCellReuseIdentifier: HorizontalCardViewCell.identifier)
        if #available(iOS 15.0, *) {
            homeTableView?.sectionHeaderTopPadding = 0
        }
        viewModel.delegate = self
        addErrorView()
        errorView.view.isHidden = true
        callFuncToGetHomeData()
    }
    
    private func callFuncToGetHomeData() {
        self.apiService.apiToGetHomeData { [self] (data, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    errorView.view.isHidden = false
                }
                return
            }
            if let homeData = data {
                bindTableViewData(homeData)
            }
        }
    }
    
    private func bindTableViewData(_ homeData: Data) {
        if let starting = viewModel.items.first(where: {$0.type == .starting}), let item = starting as? HomeViewModelStartingItem {
            item.item = homeData.starting
        }
        if let yourUpcomings = viewModel.items.first(where: {$0.type == .yourUpcomings}), let item = yourUpcomings as? HomeViewModelYourUpcomingItem {
            item.items = homeData.your_upcomings
        }
        if let upcomings = viewModel.items.first(where: {$0.type == .upcomings}), let item = upcomings as? HomeViewModelUpcomingItem {
            item.items = homeData.upcomings
        }
        if let explore = viewModel.items.first(where: {$0.type == .explore}), let item = explore as? HomeViewModelExploreItem {
            item.items = homeData.explore
        }
        isLoading = false
        DispatchQueue.main.async {
            self.errorView.view.isHidden = true
            self.homeTableView?.reloadData()
        }
    }
    
    private func addErrorView() {
        let view = self.tabBarController?.view
        if let view = view {
            errorView = UIHostingController(rootView: ErrorView(buttonHandler: { [weak self] in
                            self?.tryAgainClicked()
                        }))
            addChild(errorView)
            view.addSubview(errorView.view)
            errorView.view.translatesAutoresizingMaskIntoConstraints = false
            let constraints = [
                errorView.view.topAnchor.constraint(equalTo: view.topAnchor),
                errorView.view.leftAnchor.constraint(equalTo: view.leftAnchor),
                view.bottomAnchor.constraint(equalTo: errorView.view.bottomAnchor),
                view.rightAnchor.constraint(equalTo: errorView.view.rightAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
            errorView.didMove(toParent: self)
        }
    }
    
    private func tryAgainClicked() {
        errorView.view.isHidden = true
        isLoading = true
        callFuncToGetHomeData()
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as? UITableViewHeaderFooterView
        headerView?.textLabel?.text = viewModel.items[section].sectionTitle//sectionText(section)
        headerView?.textLabel?.textColor = .black
        headerView?.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 1 || indexPath.section == 2) {
            return 150
        }
        return 225
    }
    
    func tableView(_ tableView: UITableView,
                                willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
    }
    
}

extension HomeViewController: CellActionDelegate {
    
    func handleTap(_ content: String) {
        let alert = UIAlertController(title: "Alert", message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
