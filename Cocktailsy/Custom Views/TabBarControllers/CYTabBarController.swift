//
//  CYTabBarController.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 24..
//

import UIKit

class CYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [searchNC(), createCategoriesListNC(), createFavoritesNC()]
    }

    
    func createCategoriesListNC() -> UINavigationController {
        let categoriesListVC = CategoriesListVC()
        categoriesListVC.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "list.dash"), tag: 1)
        
        return UINavigationController(rootViewController: categoriesListVC)
    }
    
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavoritesListVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    
    func searchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
}
