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
    func fetchImages(page: Int, limit: Int, completion: ((_ imageBreed: [BreedImage]) -> Void)?)
}

class ImageService {
    lazy var networkManager = NetworkManager()
}

extension ImageService: ImageServiceProtocol {
    
    func fetchImages(page: Int, limit: Int, completion: ((_ imageBreed: [BreedImage]) -> Void)?) {
        networkManager.getImages(page, limit: limit) {(imageModel, error) in
            if let error = error {
                print(error)
                return
            }
            if let image = imageModel {
                completion?(image)
            }
        }
    }
}
