//
//  BreedsConfigurator.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 08.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol BreedsConfiguratorProtocol: class {
    func makeViewController() -> BreedsViewController
    func config(viewController: BreedsViewController)
}

class BreedsConfigurator {}

extension BreedsConfigurator: BreedsConfiguratorProtocol {
    
    func makeViewController() -> BreedsViewController {
        guard let viewController = BreedsViewController.instatiateFromNib( .main) as? BreedsViewController else {
            fatalError("Could not init \(String(describing: BreedsViewController.self))")
        }
        viewController.configurator = self
        return viewController
    }
    
    func config(viewController: BreedsViewController) {
        let service = BreedsService()
        let router = BreedsRouter(view: viewController)
        let presenter = BreedsPresenter(router: router, view: viewController, service: service)
        viewController.presenter = presenter
    }
}
