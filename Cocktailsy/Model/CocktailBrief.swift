//
//  CocktailBrief.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 10. 02..
//

import Foundation

struct CocktailBrief: Codable, Hashable {
    
    let id: String
    let drinkName: String
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case drinkName = "strDrink"
        case avatarUrl = "strDrinkThumb"
    }
}

struct CocktailBriefResults: Codable {
    let drinks: [CocktailBrief]
}
