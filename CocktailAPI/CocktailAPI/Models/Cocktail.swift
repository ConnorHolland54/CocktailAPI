//
//  Cocktail.swift
//  CocktailAPI
//
//  Created by Connor Holland on 6/17/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

import Foundation

struct TopLevelObject: Decodable {
    let drinks:[Cocktail]
}

struct Cocktail:Decodable {
    let strDrink: String
    let strDrinkThumb: URL?
}
