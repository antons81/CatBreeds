//
//  CatGalleryConfigurator.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 12.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol CatGalleryConfiguratorProtocol: class {
    func makeViewController() -> CatGalleryViewController
    func config(viewController: CatGalleryViewController)
}

class CatGalleryConfigurator {}

extension CatGalleryConfigurator: CatGalleryConfiguratorProtocol {
    
    func makeViewController() -> CatGalleryViewController {
        guard let viewController = CatGalleryViewController.instatiateFromNib(.main) as? CatGalleryViewController else {
            fatalError("Couldn't create \(CatGalleryViewController.vcName)")
        }
        
        viewController.configurator = self
        return viewController
    }

    func config(viewController: CatGalleryViewController) {
        let service = ImageService()
        let router = CatGalleryRouter(view: viewController)
        let presenter = CatGalleryPresenter(router: router, view: viewController, service: service)
        viewController.presenter = presenter
    }
}
