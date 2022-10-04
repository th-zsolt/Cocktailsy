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


class CocktailInfoVC: CYDataLoadingVC {

    let scrollView = UIScrollView()
    let contentView = UIView()
    let headerView = UIView()
//    let horizontalScrollView = UIScrollView()
    let instructionsView = CYBodyLabel(textAlignment: .left)
    let ingredientView = UIView()
    var itemViews: [UIView ] = []
    
    var cocktailId : String!
    weak var delegate: CocktailInfoVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getCocktailById()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = addButton
    }
    
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)    
        ])
    }
    
    
    func getCocktailById() {
        Task {
            do {
                let cocktails = try await NetworkManager.shared.getCocktailById(for: cocktailId)
                let cocktail = cocktails[0]
//                print(cocktail)
                configureUIElements(with: cocktail)
            } catch {
                if let cyError = error as? CYError {
                    presentCYAlert(title: "Something went wrong", message: cyError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
            }
        }
    }
    
    
    func configureUIElements(with cocktail: Cocktail) {
        self.add(childVC: CYCocktailInfoHeaderVC(cocktail: cocktail), to: self.headerView)
//        self.add(childVC: CYIngredientListVC(cocktail: cocktail), to: self.ingredientView)
    }
    
    
    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140

        itemViews = [headerView]
        
//
////        itemViews = [headerView, instructionsView, ingredientView]
//
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            ])
        }
//
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),

//            instructionsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
//            instructionsView.heightAnchor.constraint(equalToConstant: itemHeight),


//            ingredientView.topAnchor.constraint(equalTo: instructionsView.bottomAnchor, constant: padding),
//            ingredientView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc func addButtonTapped() {
//    let favorite = Cocktail(id: <#T##String#>, drinkName: <#T##String#>, category: <#T##String#>, alcoholic: <#T##String#>, glass: <#T##String#>, instructions: <#T##String#>, avatarUrl: <#T##String#>, ingredient1: <#T##String?#>, ingredient2: <#T##String?#>, ingredient3: <#T##String?#>, ingredient4: <#T##String?#>, ingredient5: <#T##String?#>, ingredient6: <#T##String?#>, ingredient7: <#T##String?#>, ingredient8: <#T##String?#>, ingredient9: <#T##String?#>, ingredient10: <#T##String?#>, ingredient11: <#T##String?#>, ingredient12: <#T##String?#>, ingredient13: <#T##String?#>, ingredient14: <#T##String?#>, ingredient15: <#T##String?#>, measure1: <#T##String?#>, measure2: <#T##String?#>, measure3: <#T##String?#>, measure4: <#T##String?#>, measure5: <#T##String?#>, measure6: <#T##String?#>, measure7: <#T##String?#>, measure8: <#T##String?#>, measure9: <#T##String?#>, measure10: <#T##String?#>, measure11: <#T##String?#>, measure12: <#T##String?#>, measure13: <#T##String?#>, measure14: <#T##String?#>, measure15: <#T##String?#>)
    }

    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}


