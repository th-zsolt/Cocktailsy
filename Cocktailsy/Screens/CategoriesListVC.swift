//
//  CategoriesListVC.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 24..
//

import UIKit

class CategoriesListVC: CYDataLoadingVC {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
//        getCategories()
        
        let followerListVC = CocktailsListVC(category: "Margarita")
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        //        tableView.delegate = self
        //        tableView.dataSource = self
        //        tableView.removeExcessCells()
        //
        //        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    
    func getCategories() {
        
        Task {
            do {
                let categories = try await NetworkManager.shared.getCategories()
//                updateUI(with: followers)
//                dismissloadingView()
            }  catch {
                if let cyError = error as? CYError {
                    presentCYAlert(title: "Bad stuff happened", message: cyError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
                
//                dismissloadingView()
            }
        }
    }
    
    

    
}
