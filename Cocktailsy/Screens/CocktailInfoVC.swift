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
    let horizontalScrollView = UIScrollView()
    let instructionsView = CYBodyLabel(textAlignment: .left)
    let ingredientListVC = UIView()
    
    var cocktailId : String!
    weak var delegate: CocktailInfoVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBlue
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
    
    
    
    @objc func addButtonTapped() {
//        let favorite = CocktailBrief(id: co, drinkName: <#T##String#>, avatarUrl: <#T##String#>)
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

//        let favorite = Cocktail(id: <#T##String#>, drinkName: <#T##String#>, category: <#T##String#>, alcoholic: <#T##String#>, glass: <#T##String#>, instructions: <#T##String#>, avatarUrl: <#T##String#>, ingredient1: <#T##String?#>, ingredient2: <#T##String?#>, ingredient3: <#T##String?#>, ingredient4: <#T##String?#>, ingredient5: <#T##String?#>, ingredient6: <#T##String?#>, ingredient7: <#T##String?#>, ingredient8: <#T##String?#>, ingredient9: <#T##String?#>, ingredient10: <#T##String?#>, ingredient11: <#T##String?#>, ingredient12: <#T##String?#>, ingredient13: <#T##String?#>, ingredient14: <#T##String?#>, ingredient15: <#T##String?#>, measure1: <#T##String?#>, measure2: <#T##String?#>, measure3: <#T##String?#>, measure4: <#T##String?#>, measure5: <#T##String?#>, measure6: <#T##String?#>, measure7: <#T##String?#>, measure8: <#T##String?#>, measure9: <#T##String?#>, measure10: <#T##String?#>, measure11: <#T##String?#>, measure12: <#T##String?#>, measure13: <#T##String?#>, measure14: <#T##String?#>, measure15: <#T##String?#>)
