//
//  CInfoHeaderCollectionReusableView.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2023. 07. 12..
//

import UIKit

class CInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "CInfoHeaderCollectionReusableView"
    
    let avatarImageView = CYImageView(frame: .zero)
    let cocktailNameLabel = CYTitleLabel(textAlignment: .left, fontSize: 34)
    let categoryLabel = CYSecondaryTitleLabel(fontSize: 18)
    let alcoholicImageView = UIImageView()
    let glassLabel = CYSecondaryTitleLabel(fontSize: 18)
    let instructionsLabel = CYBodyLabel(textAlignment: .left)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure() {
        addSubViews(avatarImageView, cocktailNameLabel, categoryLabel, alcoholicImageView, glassLabel, instructionsLabel)
                    
        addSubViews(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
                                
        instructionsLabel.numberOfLines = 6

    }
    
    
    func set(cocktail: Cocktail) {
        avatarImageView.downloadImage(fromURl: cocktail.avatarUrl)
        cocktailNameLabel.text = cocktail.drinkName
        categoryLabel.text = cocktail.category
        glassLabel.text = "Glass: " + cocktail.glass
        instructionsLabel.text = cocktail.instructions
        
        layoutUI(cocktail: cocktail)
    }
    
    
    func layoutUI(cocktail: Cocktail) {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            cocktailNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            cocktailNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: textImagePadding),
            cocktailNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
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
                categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                categoryLabel.heightAnchor.constraint(equalToConstant: 20),
                glassLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
                glassLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
                glassLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                glassLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
                } else {
                    
        NSLayoutConstraint.activate([
                categoryLabel.topAnchor.constraint(equalTo: cocktailNameLabel.bottomAnchor, constant: 8),
                categoryLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
                categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                categoryLabel.heightAnchor.constraint(equalToConstant: 20),
            
                glassLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
                glassLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
                glassLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                glassLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
                }
            
            NSLayoutConstraint.activate([
                instructionsLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
                instructionsLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
                instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                instructionsLabel.heightAnchor.constraint(equalToConstant: 180)
        ])
        }
}
