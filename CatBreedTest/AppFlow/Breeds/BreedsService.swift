//
//  ServiceBreedsViewController.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 08.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import CoreData

protocol BreedsServiceProtocol {
    func fetchBreeds(_ limit: Int, completion: ((_ breeds: Breeds) -> Void)?)
}

class BreedsService {
    lazy var networkManager = NetworkManager()
}

extension BreedsService: BreedsServiceProtocol {
    
    func fetchBreeds(_ limit: Int, completion: ((_ breeds: Breeds) -> Void)?) {
        
        CoreDataManager.shared.deleteAllData(.breed) {
            
            self.networkManager.getCatBreeds(page: 0, limit: limit, completion: { breeds, error in
                if let error = error {
                    print(error)
                    return
                }
                if let breeds = breeds {
                    completion?(breeds)
                }
            })
        }
    }
}
