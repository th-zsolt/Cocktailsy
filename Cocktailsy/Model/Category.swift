//
//  Category.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 24..
//

import Foundation

struct Category: Codable {
      
    let categoryName: String
    
    enum CodingKeys: String, CodingKey {
        case categoryName = "strCategory"
    }
    
}

struct CategoryResults: Codable {
    let drinks: [Category]
}
