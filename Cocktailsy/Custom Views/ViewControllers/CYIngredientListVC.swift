//
//  CYIngredientListVC.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 10. 04..
//

import UIKit

class CYIngredientListVC: CYDataLoadingVC {

    var cocktail: Cocktail!
    
    
    init(cocktail: Cocktail) {
        super.init(nibName: nil, bundle: nil)
        self.cocktail = cocktail
        title = "Ingredient"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
    
}
