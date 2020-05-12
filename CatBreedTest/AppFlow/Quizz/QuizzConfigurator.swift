//
//  QuizzConfigurator.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 11.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol QuizzConfiguratorProtocol: class {
    func makeViewController() -> QuizzViewController
    func config(viewController: QuizzViewController)
}

class QuizzConfigurator {}

extension QuizzConfigurator: QuizzConfiguratorProtocol {
    
    func makeViewController() -> QuizzViewController {
        guard let viewController = QuizzViewController.instatiateFromNib(.main) as? QuizzViewController else {
            fatalError("Could not create \(QuizzViewController.vcName)")
        }
        
        viewController.configurator = self
        return viewController
    }
    
    func config(viewController: QuizzViewController) {
        let service = QuizzService()
        let router = QuizzRouter(view: viewController)
        let presenter = QuizzPresenter(router: router, view: viewController, service: service)
        viewController.presenter = presenter
    }
}
