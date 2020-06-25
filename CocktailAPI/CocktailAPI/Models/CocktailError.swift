//
//  CocktailError.swift
//  CocktailAPI
//
//  Created by Connor Holland on 6/17/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

import Foundation

enum CocktailError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
}
