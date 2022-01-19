//
//  ViewController.swift
//  Leap
//
//  Created by ONUR KILIC on 12.01.2022.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView?
    fileprivate let viewModel = HomeViewModel()
    private var errorView: UIHostingController<ErrorView>!
    private var apiService : APIService!
    private var isLoading = true
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiService =  APIService()
        homeCollectionView?.dataSource = viewModel
        homeCollectionView?.collectionViewLayout = createLayout()
        homeCollectionView?.register(CardViewCell.self, forCellWithReuseIdentifier: CardViewCell.cardIdentifier)
        homeCollectionView?.register(SmallCardViewCell.self, forCellWithReuseIdentifier: SmallCardViewCell.smallCardIdentifier)
        homeCollectionView?.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
        addErrorView()
        errorView.view.isHidden = true
        callFuncToGetHomeData()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, env -> NSCollectionLayoutSection? in
            return self.viewModel.items[sectionNumber].getLayoutSection()
        }
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
        viewModel.items.forEach { item in
            item.bindData(data: homeData)
        }
        isLoading = false
        DispatchQueue.main.async {
            self.errorView.view.isHidden = true
            self.homeCollectionView?.reloadData()
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
            
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let content = viewModel.items[indexPath.section].getContent(indexPath.row)
        let alert = UIAlertController(title: "Alert", message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
