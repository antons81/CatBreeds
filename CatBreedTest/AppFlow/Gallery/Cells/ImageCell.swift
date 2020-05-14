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
    var isHeightCalculated: Bool = false
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
    
    func setupImage(_ image: BreedImage) {
        guard let url = URL(string: image.url) else { return }
        ImageDownloader.downloadCachedImage(with: url) { image in
            mainThread {
                self.catImage.image = image
                self.indicator.stopAnimating()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        catImage.image = nil
    }
}
