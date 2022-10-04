//
//  CYCocktailInfoHeaderVC.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 10. 04..
//

import UIKit

class CYCocktailInfoHeaderVC: UIViewController {
    
    let avatarImageView = CYImageView(frame: .zero)
    let cocktailNameLabel = CYTitleLabel(textAlignment: .left, fontSize: 34)
    let categoryLabel = CYSecondaryTitleLabel(fontSize: 18)
    let alcoholicImageView = UIImageView()
    let glassLabel = CYSecondaryTitleLabel(fontSize: 18)
    
    var cocktail: Cocktail!
    
    
    init(cocktail: Cocktail!) {
        super.init(nibName: nil, bundle: nil)
        self.cocktail = cocktail
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubViews(avatarImageView, cocktailNameLabel, categoryLabel, alcoholicImageView, glassLabel)

    }
    
    
    func configureUIElements() {
        avatarImageView.downloadImage(fromURl: cocktail.avatarUrl)
        cocktailNameLabel.text = cocktail.drinkName
        categoryLabel.text = cocktail.category
        glassLabel.text = cocktail.glass
        
        alcoholicImageView.image = SFSymbols.alcoholic
        alcoholicImageView.tintColor = .systemPink
    }
        
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        alcoholicImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            cocktailNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            cocktailNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            cocktailNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cocktailNameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            categoryLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20),
            
            alcoholicImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            alcoholicImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            alcoholicImageView.widthAnchor.constraint(equalToConstant: 20),
            alcoholicImageView.heightAnchor.constraint(equalToConstant: 20),
            
            glassLabel.centerYAnchor.constraint(equalTo: alcoholicImageView.centerYAnchor),
            glassLabel.leadingAnchor.constraint(equalTo: alcoholicImageView.trailingAnchor, constant: 5),
            glassLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            glassLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

}

