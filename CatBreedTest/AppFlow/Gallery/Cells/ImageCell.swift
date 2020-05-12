//
//  ImageCell.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 12.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import UIKit

class ImageCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet var catImage: UIImageView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    func setupImage(_ image: BreedImage) {
        mainThread {
            guard let url = URL(string: image.url) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            self.catImage.image = image
            self.indicator.stopAnimating()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        catImage.image = nil
    }
}
