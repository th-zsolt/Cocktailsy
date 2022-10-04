//
//  CocktailsListCV.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 24..
//

import UIKit

class CocktailsListVC: CYDataLoadingVC {
    
    enum Section { case main}
    
    var categoryName: String?
    var cocktailName: String?
    var cocktailBriefs: [CocktailBrief] = []
    var filteredCocktailBriefs: [CocktailBrief] = []
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, CocktailBrief>!

    
    init(cocktailName: String) {
        super.init(nibName: nil, bundle: nil)
        self.cocktailName = cocktailName
        self.categoryName = nil
        title = cocktailName
    }
    
    
    init(categoryName: String) {
        super.init(nibName: nil, bundle: nil)
        self.categoryName = categoryName
        self.cocktailName = nil
        title = categoryName
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        categoryName == nil ? getCocktailsByName(cocktailName: cocktailName!) : getCocktailsByCategoryName(categoryName: categoryName!)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
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
        collectionView.register(CocktailBriefCell.self, forCellWithReuseIdentifier: CocktailBriefCell.reuseID)
    }
    
    
    func getCocktailsByName(cocktailName: String) {
                showLoadingView()
        
        Task {
            do {
                let cocktailBriefs = try await NetworkManager.shared.getCocktailsByName(for: cocktailName)
               updateUI(with: cocktailBriefs)
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
    
    
    func getCocktailsByCategoryName(categoryName: String) {
                showLoadingView()
        
        Task {
            do {
                let cocktailBriefs = try await NetworkManager.shared.getCocktailsByCategoryName(for: categoryName)
               updateUI(with: cocktailBriefs)
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
    
    
    func updateUI(with cocktailBriefs: [CocktailBrief]) {
        self.cocktailBriefs.append(contentsOf: cocktailBriefs)
    
        if self.cocktailBriefs.isEmpty {
            let message = "No cocktail found with this name."
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
            }
        }
        
        self.updateData(on: self.cocktailBriefs)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CocktailBrief>(collectionView: collectionView, cellProvider: { (collectionView, IndexPath, cocktailBrief ) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CocktailBriefCell.reuseID, for: IndexPath) as! CocktailBriefCell
            cell.set(cocktailBrief: cocktailBrief)
            return cell
        })
    }
    
    
    func updateData(on cocktailBriefs: [CocktailBrief]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, CocktailBrief>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cocktailBriefs)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension CocktailsListVC: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredCocktailBriefs : cocktailBriefs
        let cocktailBrief = activeArray[indexPath.item]
        
        let destVC = CocktailInfoVC()
        destVC.cocktailId = cocktailBrief.id
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}


extension CocktailsListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredCocktailBriefs.removeAll()
            updateData(on: cocktailBriefs)
            isSearching = false
            return }
        
        isSearching = true
        filteredCocktailBriefs = cocktailBriefs.filter { $0.drinkName.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredCocktailBriefs)
    }
    
}


extension CocktailsListVC: CocktailInfoVCDelegate {
    
    func didRequestCocktails(for cocktailName: String) {
        self.cocktailName = cocktailName
        title = cocktailName
        cocktailBriefs.removeAll()
        filteredCocktailBriefs.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        //
    }
}
