//
//  QuizzRouter.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 11.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol QuizzRouterProtocol: class {
    var view: QuizzViewController? { get set }
    func openNextScreen()
}

class QuizzRouter {
    // MARK: - Public variables
    internal weak var view: QuizzViewController?
    
    // MARK: - Initialization
    init(view: QuizzViewController) {
        self.view = view
    }

}

extension QuizzRouter: QuizzRouterProtocol {
    func openNextScreen() {
    }

}
