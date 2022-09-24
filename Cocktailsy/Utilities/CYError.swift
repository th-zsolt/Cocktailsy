//
//  CYError.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 24..
//

import Foundation

enum CYError: String, Error {
    
    case invalidCoctailName = "This coctail name created an invalid request. Please try again."
    case invalidRequest = "Unable to complete your request."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this coctail. Please try again."
    case alreadyInFavorites = "You've already favorited this coctail."
}
