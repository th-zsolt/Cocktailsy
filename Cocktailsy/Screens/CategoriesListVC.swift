//
//  CategoriesListVC.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 24..
//

import UIKit

class CategoriesListVC: CYDataLoadingVC {
    
    let tableView = UITableView()
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        getCategories()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseID)
    }
    
    
    func getCategories() {
        showLoadingView()
        
        Task {
            do {
                let categories = try await NetworkManager.shared.getCategories()
                updateUI(with: categories)
                dismissloadingView()
            }  catch {
                if let cyError = error as? CYError {
                    presentCYAlert(title: "Bad stuff happened", message: cyError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
                
                dismissloadingView()
            }
        }
    }
    
    
    func updateUI(with categories: [Category]) {
        if categories.isEmpty {
            self.showEmptyStateView(with: "Something went wrong", in: self.view)
        } else {
            self.categories = categories
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}
    
    extension CategoriesListVC: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categories.count
        }
    
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseID) as? CategoryCell
                let category = categories[indexPath.row]
                cell?.set(category: category)
                return cell ?? UITableViewCell()
        }
        
        
        func tableView(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath) {
            let category = categories[indexPath.row]
            let destVC = CocktailsListVC(categoryName: category.categoryName)
            
            navigationController?.pushViewController(destVC, animated: true)
        }
}
