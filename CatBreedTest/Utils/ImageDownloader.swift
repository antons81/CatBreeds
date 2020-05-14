//
//  ImageDownloader.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 14.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader {
    
    typealias ImageCompletion = ((UIImage) -> Void)?
    
    private static let imageCache = NSCache<NSString, UIImage>()
    
    static func downloadCachedImage(with url: URL, completion: ImageCompletion) {
        if let cachedImage = imageCache.object(forKey: url.lastPathComponent as NSString) {
            completion?(cachedImage)
        }
        
        let request = URLRequest(url: url,
                                 cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData,
                                 timeoutInterval: 30)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                error == nil,
                let image = UIImage(data: data)
                else { return }
            imageCache.setObject(image, forKey: url.lastPathComponent as NSString)
            completion?(image)
            }.resume()
    }
}
