//
//  NetworkManager.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 24..
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list"
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
        
    private init() {

        decoder.dateDecodingStrategy = .iso8601
    }
    
    
    func getCategories() async throws -> [CategoryResults] {
        let endpoint = baseURL

        guard let url = URL(string: endpoint) else { throw CYError.invalidRequest }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CYError.invalidResponse
        }

        do {
            return try decoder.decode([CategoryResults].self, from: data)

        } catch {
            throw CYError.invalidData
        }
    }
    
//    func testCategories(completed: @escaping ([DrinksResults]?, String?) -> Void) {
//        let endpoint = baseURL
//
//        guard let url = URL(string: endpoint) else {
//            completed(nil, "This username created an invalid request. Please try again.")
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { [self] data, response, error in
//
//            if let _ = error {
//                completed(nil, "Unable to complete your request. Please check your internet connection")
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(nil, "Invalid response from the server. Please try again.")
//                return
//            }
//
//            guard let data = data else {
//                completed(nil, "The data received from the server was invalid. Please try again.")
//                return
//            }
//
//            do {
//                let category = try decoder.decode([DrinksResults].self, from: data)
//                print("category.count = \(category.count)")
//                print(category)
//                completed(category, nil)
//            } catch {
//                completed(nil, "Decoding problem!")
//            }
//        }
//
//        task.resume()
//    }
}
