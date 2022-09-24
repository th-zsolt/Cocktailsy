//
//  CoctailByCategory.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 26..
//

import Foundation

struct CocktailbyCategory: Codable {
    
    let id: String
    let drinkName: String
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case drinkName = "strDrink"
        case avatarUrl = "strDrinkThumb"
    }
}

struct CocktailbyCategoryResults: Codable {
    let drinks: [CocktailbyCategory]
}
