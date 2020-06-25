//
//  CocktailController.swift
//  CocktailAPI
//
//  Created by Connor Holland on 6/17/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

import UIKit

struct StringConstants {
    fileprivate static let baseURLString = "https://www.thecocktaildb.com/api/json/v1/1"
    fileprivate static let searchComponentString = "search"
    fileprivate static let fileExtensionString = "php"
    
}

class CocktailController {
    static func fetchCocktail(searchTerm: String, completion: @escaping (Result<[Cocktail], CocktailError>) -> Void) {
        guard let baseURL = URL(string: StringConstants.baseURLString) else {return completion(.failure(.invalidURL))}
        let searchComp = baseURL.appendingPathComponent(StringConstants.searchComponentString)
        let fileExtension = searchComp.appendingPathExtension(StringConstants.fileExtensionString)
        var components = URLComponents(url: fileExtension, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "f", value: searchTerm.lowercased())]
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let cocktailArray = topLevelObject.drinks
               
                completion(.success(cocktailArray))
                
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
  
    static func fetchThumbnailForCocktail(cocktail: Cocktail, completion: @escaping (Result<UIImage, CocktailError>) -> Void) {
        guard let url = cocktail.strDrinkThumb else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            guard let thumbnailImage = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            completion(.success(thumbnailImage))
        }.resume()
    }
}
