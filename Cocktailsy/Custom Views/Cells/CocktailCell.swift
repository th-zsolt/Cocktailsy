//
//  CocktailCell.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 27..
//

import UIKit

class CocktailCell: UICollectionViewCell {

    static let reuseID = "CocktailCell"
    let avatarImageView = CYImageView(frame: .zero)
    let cocktailNameLabel = CYTitleLabel(textAlignment: .center, fontSize: 16)
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(cocktail: Cocktail) {
        avatarImageView.downloadImage(fromURl: cocktail.avatarUrl)
        cocktailNameLabel.text = cocktail.drinkName
        }
    
    
    private func configure() {
        addSubViews(avatarImageView, cocktailNameLabel)
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            cocktailNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            cocktailNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            cocktailNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            cocktailNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

