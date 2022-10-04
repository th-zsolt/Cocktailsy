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
        layoutUI()
        configureUIElements()
    }
    
    
    func configureUIElements() {
        avatarImageView.downloadImage(fromURl: cocktail.avatarUrl)
        cocktailNameLabel.text = cocktail.drinkName
        categoryLabel.text = cocktail.category
        glassLabel.text = "Glass: " + cocktail.glass
        
    }
        
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            cocktailNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            cocktailNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            cocktailNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cocktailNameLabel.heightAnchor.constraint(equalToConstant: 38),
        ])
        
        if cocktail.alcoholic == "Alcoholic" {
            
            alcoholicImageView.image = SFSymbols.alcoholic
            alcoholicImageView.tintColor = .systemPink
            alcoholicImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                alcoholicImageView.topAnchor.constraint(equalTo: cocktailNameLabel.bottomAnchor, constant: 8),
                alcoholicImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
                alcoholicImageView.widthAnchor.constraint(equalToConstant: 20),
                alcoholicImageView.heightAnchor.constraint(equalToConstant: 20),
                
                categoryLabel.centerYAnchor.constraint(equalTo: alcoholicImageView.centerYAnchor),
                categoryLabel.leadingAnchor.constraint(equalTo: alcoholicImageView.trailingAnchor, constant: 5),
                categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                categoryLabel.heightAnchor.constraint(equalToConstant: 20),
                
                glassLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
                glassLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
                glassLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                glassLabel.heightAnchor.constraint(equalToConstant: 20),
            ])
            
        } else {
            NSLayoutConstraint.activate([
                categoryLabel.topAnchor.constraint(equalTo: cocktailNameLabel.bottomAnchor, constant: 8),
                categoryLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
                categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                categoryLabel.heightAnchor.constraint(equalToConstant: 20),
                
                glassLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
                glassLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
                glassLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                glassLabel.heightAnchor.constraint(equalToConstant: 20),
            ])
        }
    }

}

