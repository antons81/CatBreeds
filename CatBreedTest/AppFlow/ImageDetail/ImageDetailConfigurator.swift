//
//  ImageDetailConfigurator.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 12.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol ImageDetailConfiguratorProtocol: class {
    func makeViewController(_ image: BreedImage) -> ImageDetailViewController
    func config(viewController: ImageDetailViewController)
}

class ImageDetailConfigurator {
    
    private var image: BreedImage!
}

extension ImageDetailConfigurator: ImageDetailConfiguratorProtocol {
    
    func makeViewController(_ image: BreedImage) -> ImageDetailViewController {
        guard let viewController = ImageDetailViewController.instatiateFromNib(.main) as? ImageDetailViewController else {
            fatalError("Couldn't create \(ImageDetailViewController.vcName)")
        }
        
        self.image = image
        viewController.configurator = self
        return viewController
    }

    func config(viewController: ImageDetailViewController) {
        let router = ImageDetailRouter(view: viewController)
        let presenter = ImageDetailPresenter(router: router, view: viewController, image: self.image)
        viewController.presenter = presenter
    }

}
