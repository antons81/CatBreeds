//
//  NavigationConfigurator.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 09.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol NavigationConfiguratorProtocol: class {
    func makeViewController() -> NavigationController
    func config(viewController: NavigationController)
}

class NavigationConfigurator {
}

extension NavigationConfigurator: NavigationConfiguratorProtocol {
    func makeViewController() -> NavigationController {

        guard let viewController = NavigationController.instatiateFromNib(.main) as? NavigationController else {
            fatalError("Could not init navigartion controller")
        }
        
        viewController.configurator = self
        return viewController
    }

    func config(viewController: NavigationController) {
        let router = NavigationRouter(view: viewController)
        let presenter = NavigationPresenter(router: router, view: viewController)
        viewController.presenter = presenter
    }
}
