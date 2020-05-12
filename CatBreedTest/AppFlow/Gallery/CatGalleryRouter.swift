//
//  CatGalleryRouter.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 12.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol CatGalleryRouterProtocol: class {
    var view: CatGalleryViewController? { get set }
    func openFullImage(_ image: BreedImage)
}

class CatGalleryRouter {
    // MARK: - Public variables
    internal weak var view: CatGalleryViewController?
    
    // MARK: - Initialization
    init(view: CatGalleryViewController) {
        self.view = view
    }

}

extension CatGalleryRouter: CatGalleryRouterProtocol {
    func openFullImage(_ image: BreedImage) {
        let details = ImageDetailConfigurator().makeViewController(image)
        view?.navigationController?.show(details, sender: self)
    }
}
