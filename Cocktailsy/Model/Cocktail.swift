//
//  Cocktail.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 24..
//

import Foundation

struct Cocktails: Codable {
    
    let drinkName: String
    
    enum CodingKeys: String, CodingKey {
        case drinkName = "strDrink"
    }
}

struct CocktailResults: Codable {
    let drinks: [Cocktails]
}
