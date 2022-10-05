//
//  CocktailInfoVC.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 10. 02..
//

import UIKit

protocol CocktailInfoVCDelegate: AnyObject {
    func didRequestCocktails(for cocktailName: String)
}


class CocktailInfoVC: CYDataLoadingVC, UICollectionViewDelegateFlowLayout {

   
    var cocktail: Cocktail?
    var cocktailId : String!
    
    var collectionView: UICollectionView!
    weak var delegate: CocktailInfoVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getCocktailById()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        navigationItem.rightBarButtonItems = [doneButton, addButton]
    }

    
    
    func getCocktailById() {
        Task {
            do {
                let cocktails = try await NetworkManager.shared.getCocktailById(for: cocktailId)
                let cocktail = cocktails[0]
                updateUI(with: cocktail)
            } catch {
                if let cyError = error as? CYError {
                    presentCYAlert(title: "Something went wrong", message: cyError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
            }
        }
    }
    
    
    func updateUI(with cocktail: Cocktail) {
            self.cocktail = cocktail
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.view.bringSubviewToFront(self.collectionView)
                
            }
        }
    
    
    func configureCollectionView() {
      
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView!)
        collectionView.register(IngredientCell.self, forCellWithReuseIdentifier: IngredientCell.reuseID)
        collectionView.register(CInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CInfoHeaderCollectionReusableView.identifier)

    }

    
    @objc func addButtonTapped() {
        if self.cocktail != nil {
            let favorite = CocktailBrief(id: self.cocktail!.id, drinkName: self.cocktail!.drinkName, avatarUrl: self.cocktail!.avatarUrl)
            
            PersistenceManager.updateWith(favorite: favorite, actionType: .add) {
                [weak self] error in
                guard let self = self else { return }
                
                guard let error = error else {
                    DispatchQueue.main.async {
                        self.presentCYAlert(title: "Success!", message: "You have successfully favorited this drink.", buttonTitle: "Ok")
                    }
                    
                    return
                }
                
                DispatchQueue.main.async {
                    self.presentCYAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
    }

    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}


extension CocktailInfoVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cocktail?.ingredients.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if cocktail != nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCell.reuseID, for: indexPath) as! IngredientCell
            let ingredient = cocktail!.ingredients[indexPath.row]
            let measure = indexPath.row > cocktail!.measures.count-1 ? "" :
            cocktail!.measures[indexPath.row]
            cell.set(ingredient: ingredient, measure: measure)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CInfoHeaderCollectionReusableView.identifier, for: indexPath) as! CInfoHeaderCollectionReusableView
        header.configure()
        
        if self.cocktail != nil {
            header.set(cocktail: self.cocktail!)
        }
    
        return header
    }


        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: view.frame.size.width, height: 260)
        }
    
}

