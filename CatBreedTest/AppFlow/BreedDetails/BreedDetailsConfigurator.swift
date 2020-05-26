//
//  BreedDetailsConfigurator.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 10.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol BreedDetailsConfiguratorProtocol: class {
    func makeViewController(_ breedDetail: Breed?) -> BreedDetailsViewController
    func config(viewController: BreedDetailsViewController)
}

class BreedDetailsConfigurator {
    var breedDetail: Breed!
}

extension BreedDetailsConfigurator: BreedDetailsConfiguratorProtocol {
    
    func makeViewController(_ breedDetail: Breed? = nil) -> BreedDetailsViewController {
        guard let viewController = BreedDetailsViewController.instatiateFromNib(.main) as? BreedDetailsViewController else {
            fatalError("Couldn't create viewController \(BreedDetailsViewController.vcName)")
        }
        
        viewController.configurator = self
        self.breedDetail = breedDetail
        return viewController
    }

    func config(viewController: BreedDetailsViewController) {
        let service = BreedDetailService()
        let router = BreedDetailsRouter(view: viewController)
        let presenter = BreedDetailsPresenter(router: router, view: viewController, breed: breedDetail, service: service)
        viewController.presenter = presenter
    }
}
