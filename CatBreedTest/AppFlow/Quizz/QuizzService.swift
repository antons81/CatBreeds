//
//  QuizzService.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 11.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import UIKit.UIImage


protocol QuizzServiceProtocol {
    func fetchBreeds(page: Int, completion: ((_ breeds: Breeds) -> Void)?)
    func fetchImageBy(_ breedId: String, completion: ((_ imageBreed: BreedImage) -> Void)?)
}

class QuizzService {
    lazy var networkManager = NetworkManager()
}

extension QuizzService: QuizzServiceProtocol {
    
    func fetchBreeds(page: Int, completion: ((_ breeds: Breeds) -> Void)?) {
        networkManager.getCatBreeds(page: page, limit: 4, completion: { cats, error in
            if let error = error {
                print(error)
                return
            }
            if let cats = cats {
                completion?(cats)
            }
        })
    }
    
    func fetchImageBy(_ breedId: String, completion: ((_ imageBreed: BreedImage) -> Void)?) {
        networkManager.getImageBy(breedId) {(imageModel, error) in
            if let error = error {
                print(error)
                return
            }
            if let image = imageModel?.first {
                completion?(image)
            }
        }
    }
}
