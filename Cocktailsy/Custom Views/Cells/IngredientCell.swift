//
//  IngredientCell.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 10. 05..
//

import UIKit

class IngredientCell: UICollectionViewCell {

        static let reuseID = "IngredientCell"
        let avatarImageView = CYImageView(frame: .zero)
        let ingredientNameLabel = CYTitleLabel(textAlignment: .center, fontSize: 16)
        

        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    func set(ingredient: String, measure: String) {
        let avatarUrl = "https://www.thecocktaildb.com/images/ingredients/\(ingredient)-Small.png"
        avatarImageView.downloadImage(fromURl: avatarUrl)
        ingredientNameLabel.text = "\(measure) \(ingredient)"
        ingredientNameLabel.numberOfLines = 2
            }
        
        
    private func configure() {
        addSubViews(avatarImageView, ingredientNameLabel)
        let padding: CGFloat = 8
            
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
                
            ingredientNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            ingredientNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            ingredientNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            ingredientNameLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }

