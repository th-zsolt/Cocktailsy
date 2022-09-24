//
//  CategoriesListVC.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 24..
//

import UIKit

class CategoriesListVC: UIViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getCategories()
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
            do{
               let categories = try await NetworkManager.shared.getCategories()
                print(categories.count)
            }  catch {
                if let cyError = error as? CYError {
                    presentCYAlert(title: "Bad stuff happened", message: cyError.rawValue, buttonTitle: "Ok")
                } else {
                presentDefaultError()
                }
            
        }
    }
        
        
//        NetworkManager.shared.testCategories() { (followers, errorMessage) in
//            guard let followers = followers else {
//                self.presentCYAlertOnMainThread(title: "Bad Stuff Happend", message: errorMessage!, buttonTitle: "Ok")
//                return
//            }
//
//            print("category.count = \(followers.count)")
//            print(followers)
//        }
    }
}
