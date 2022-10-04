//
//  CategoryCell.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 29..
//

import UIKit

class CategoryCell: UITableViewCell {

    static let reuseID = "CategoryCell"
    let categoryNameLabel = CYTitleLabel(textAlignment: .left, fontSize: 18)
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func set(category: Category) {
        categoryNameLabel.text = category.categoryName
    }

 
    private func configure() {
        addSubViews(categoryNameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            
            categoryNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            categoryNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            categoryNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            categoryNameLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }

}

