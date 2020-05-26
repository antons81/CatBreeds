//
//  CatsCell.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 05.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

class BreedsCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var breed: UILabel!
    
    func setupCell(_ cat: Breed) {
        breed.text = cat.name
    }
}
