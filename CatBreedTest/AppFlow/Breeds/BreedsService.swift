//
//  ServiceBreedsViewController.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 08.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation


protocol BreedsServiceProtocol {
    func fetchBreeds(_ limit: Int, completion: ((_ breeds: Breeds) -> Void)?)
}

class BreedsService {
    lazy var networkManager = NetworkManager()
}

extension BreedsService: BreedsServiceProtocol {
    
    func fetchBreeds(_ limit: Int, completion: ((_ breeds: Breeds) -> Void)?) {
        networkManager.getCatBreeds(page: 0, limit: limit, completion: { cats, error in
            if let error = error {
                print(error)
                return
            }
            if let cats = cats {
                completion?(cats)
            }
        })
    }
}
