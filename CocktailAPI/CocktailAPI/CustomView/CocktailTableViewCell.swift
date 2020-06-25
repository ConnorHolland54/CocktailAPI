//
//  CocktailTableViewCell.swift
//  CocktailAPI
//
//  Created by Connor Holland on 6/17/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    
     var cocktail: Cocktail? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let cocktail = cocktail else {return}
        cocktailNameLabel.text = cocktail.strDrink
        cocktailImageView.image = nil
        
        CocktailController.fetchThumbnailForCocktail(cocktail: cocktail) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.cocktailImageView.image = image
                case .failure(let error):
                    print(error)
                    //present Error here
                }
            }
        }
    }
}
