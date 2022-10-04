//
//  NetworkManager.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 24..
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/"
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
        
   private init() { }
    
    
    func getCategories() async throws -> [Category] {
        let endpoint = baseURL + "list.php?c=list"
        
        guard let url = URL(string: endpoint) else {
            throw CYError.invalidCoctailName
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
                  
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CYError.invalidResponse
        }
            
        do {
            let categoryResult = try decoder.decode(CategoryResults.self, from: data)
            let categories = categoryResult.drinks
            print(categories)
            return categories
            
        } catch {
            throw CYError.invalidData
        }
    }
    
    
    func getCocktailsByName(for cocktailName: String) async throws -> [CocktailBrief] {
        let newCocktailName = cocktailName.replacingOccurrences(of: " ", with: "_")
        let endpoint = baseURL + "search.php?s=\(newCocktailName)"
        
        guard let url = URL(string: endpoint) else {
            throw CYError.invalidCoctailName
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
                  
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CYError.invalidResponse
        }
            
        do {
            let cocktailBriefResults = try decoder.decode(CocktailBriefResults.self, from: data)
            let cocktails = cocktailBriefResults.drinks
            return cocktails
            
        } catch {
            throw CYError.invalidData
        }
    }
    
    
    func getCocktailsByCategoryName(for categoryName: String) async throws -> [CocktailBrief] {
        let newCategoryName = categoryName.replacingOccurrences(of: " ", with: "_")
        let endpoint = baseURL + "filter.php?c=\(newCategoryName)"
        print(endpoint)
        
        guard let url = URL(string: endpoint) else {
            throw CYError.invalidCoctailName
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
                  
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CYError.invalidResponse
        }
            
        do {
            let cocktailBriefResults = try decoder.decode(CocktailBriefResults.self, from: data)
            let cocktails = cocktailBriefResults.drinks
            return cocktails
            
        } catch {
            throw CYError.invalidData
        }
    }
    
    
    func getCocktailById(for cocktailId: String) async throws -> [Cocktail] {
        let endpoint = baseURL + "lookup.php?i=\(cocktailId)"
        
        guard let url = URL(string: endpoint) else {
            throw CYError.invalidCoctailName
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
                  
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CYError.invalidResponse
        }
            
        do {
            let cocktailResult = try decoder.decode(CocktailResults.self, from: data)
            let cocktails = cocktailResult.drinks
            return cocktails
            
        } catch {
            throw CYError.invalidData
        }
    }
    
    
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }

}
