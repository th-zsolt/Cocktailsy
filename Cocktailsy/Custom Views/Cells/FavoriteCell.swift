//
//  FavoriteCell.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 26..
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID = "FavoriteCell"
    let avatarImageView = CYImageView(frame: .zero)
    let cocktailNameLabel = CYTitleLabel(textAlignment: .left, fontSize: 26)
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func set(favorite: Cocktail) {
        avatarImageView.downloadImage(fromURl: favorite.avatarUrl)
        cocktailNameLabel.text = favorite.drinkName
    }

 
    private func configure() {
        addSubViews(avatarImageView, cocktailNameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            cocktailNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cocktailNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            cocktailNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            cocktailNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
