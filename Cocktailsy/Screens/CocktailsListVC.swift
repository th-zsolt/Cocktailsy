//
//  CocktailsListCV.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 24..
//

import UIKit

class CocktailsListVC: CYDataLoadingVC {
    
    enum Section { case main}
    
    var category: String?
    var cocktailName: String?
    var cocktails: [Cocktail] = []
    var filteredCocktails: [Cocktail] = []
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Cocktail>!

    
    init(cocktailName: String) {
        super.init(nibName: nil, bundle: nil)
        self.cocktailName = cocktailName
        self.category = nil
        title = cocktailName
    }
    
    
    init(category: String) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
        self.cocktailName = nil
        title = category
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getCocktailsByName(cocktailName: "Margarita", page: 1)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CocktailCell.self, forCellWithReuseIdentifier: CocktailCell.reuseID)
    }
    
    
    func getCocktailsByName(cocktailName: String, page: Int) {
        //        showLoadingView()
        //        isLoadingMoreFollowers = true
        
        Task {
            do {
                let cocktails = try await NetworkManager.shared.getCocktailsByName(for: cocktailName, page: page)
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
    
    
    func updateUI(with cocktails: [Cocktail]) {
        self.cocktails.append(contentsOf: cocktails)
    
        if self.cocktails.isEmpty {
            let message = "No cocktail found with this name."
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
            }
        }
        
        self.updateData(on: self.cocktails)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Cocktail>(collectionView: collectionView, cellProvider: { (collectionView, IndexPath, cocktail ) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CocktailCell.reuseID, for: IndexPath) as! CocktailCell
            cell.set(cocktail: cocktail)
            return cell
        })
    }
    
    
    func updateData(on cocktails: [Cocktail]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Cocktail>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cocktails)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    
    @objc func addButtonTapped() {
        showLoadingView()
        
//        Task {
//            do {
//                let user = try await NetworkManager.shared.getUserInfo(for: username)
//                addUserToFavorites(user: user)
//                dismissloadingView()
//            } catch {
//                if let gfError = error as? GFError {
//                    presentGFAlert(title: "Something went wrong", message:                     gfError.rawValue, buttonTitle: "Ok")
//                } else {
//                    presentDefaultError()
//                }
//
//                dismissloadingView()
//            }
//        }
    }
    
    
//    func addCocktailToFavorites(user: User) {
//        let favorite = Cocktail(id: <#T##String#>, drinkName: <#T##String#>, category: <#T##String#>, alcoholic: <#T##String#>, glass: <#T##String#>, instructions: <#T##String#>, avatarUrl: <#T##String#>, ingredient1: <#T##String?#>, ingredient2: <#T##String?#>, ingredient3: <#T##String?#>, ingredient4: <#T##String?#>, ingredient5: <#T##String?#>, ingredient6: <#T##String?#>, ingredient7: <#T##String?#>, ingredient8: <#T##String?#>, ingredient9: <#T##String?#>, ingredient10: <#T##String?#>, ingredient11: <#T##String?#>, ingredient12: <#T##String?#>, ingredient13: <#T##String?#>, ingredient14: <#T##String?#>, ingredient15: <#T##String?#>, measure1: <#T##String?#>, measure2: <#T##String?#>, measure3: <#T##String?#>, measure4: <#T##String?#>, measure5: <#T##String?#>, measure6: <#T##String?#>, measure7: <#T##String?#>, measure8: <#T##String?#>, measure9: <#T##String?#>, measure10: <#T##String?#>, measure11: <#T##String?#>, measure12: <#T##String?#>, measure13: <#T##String?#>, measure14: <#T##String?#>, measure15: <#T##String?#>)
//
//        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
//            guard let self = self else { return }
//
//            guard let error = error else {
//                DispatchQueue.main.async {
//                    self.presentCYAlert(title: "Success!", message: "You have successfully favorited this cocktail.", buttonTitle: "Ok")
//                }
//
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.presentCYAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
//            }
//        }
//    }
}

extension CocktailsListVC: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredCocktails : cocktails
        let follower = activeArray[indexPath.item]
        
//        let destVC = UserInfoVC()
//        destVC.cocktail =
//        destVC.delegate = self
//        let navController = UINavigationController(rootViewController: destVC)
//        present(navController, animated: true)
    }
}


extension CocktailsListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredCocktails.removeAll()
            updateData(on: cocktails)
            isSearching = false
            return }
        
        isSearching = true
        filteredCocktails = cocktails.filter { $0.drinkName.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredCocktails)
    }
    
}


//extension CocktailsListVC: UserInfoVCDelegate {
//
//    func didRequestFollowers(for cocktail: String) {
//        self.cocktail = cocktail
//        title = cocktail
//        page = 1
//        followers.removeAll()
//        filteredFollowers.removeAll()
//        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
//        getCocktailsByName(cocktailName: cocktail, page: 1)
//    }
//}
