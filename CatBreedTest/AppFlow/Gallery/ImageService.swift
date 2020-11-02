//
//  ImageService.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 12.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import UIKit.UIImage


protocol ImageServiceProtocol {
    func fetchImages(limit: Int, completion: ((_ imageBreed: [BreedImage]) -> Void)?)
}

class ImageService {
    lazy var networkManager = NetworkManager()
}

extension ImageService: ImageServiceProtocol {
    
    func fetchImages(limit: Int, completion: ((_ imageBreed: [BreedImage]) -> Void)?) {
        networkManager.getImages(limit: limit) {(imageModel, error) in
            if let error = error {
                #if DEBUG
                print(error)
                #endif
                return
            }
            
            if let image = imageModel {
                completion?(image)
            }
        }
    }
}
