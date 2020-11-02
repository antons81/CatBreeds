//
//  BreedDetailService.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 12.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation

protocol BreedDetailServiceProtocol {
    func fetchImageBy(_ breedId: String, completion: ((_ imageBreed: BreedImage) -> Void)?)
}

class BreedDetailService {
    lazy var networkManager = NetworkManager()
}

extension BreedDetailService: BreedDetailServiceProtocol {
    
    func fetchImageBy(_ breedId: String, completion: ((_ imageBreed: BreedImage) -> Void)?) {
        networkManager.getImageBy(breedId) {(imageModel, error) in
            if let error = error {
                #if DEBUG
                print(error)
                #endif
                return
            }
            
            if let image = imageModel?.first {
                completion?(image)
            }
        }
    }
}
