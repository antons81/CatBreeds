//
//  BreedDetailsRouter.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 10.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol BreedDetailsRouterProtocol: class {
    var view: BreedDetailsViewController? { get set }
    func openNextScreen()
}

class BreedDetailsRouter {
    // MARK: - Public variables
    internal weak var view: BreedDetailsViewController?
    
    // MARK: - Initialization
    init(view: BreedDetailsViewController) {
        self.view = view
    }

}

extension BreedDetailsRouter: BreedDetailsRouterProtocol {
    func openNextScreen() {
    }

}
