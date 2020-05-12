//
//  ImageDetailRouter.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 12.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol ImageDetailRouterProtocol: class {
    var view: ImageDetailViewController? { get set }
    func openNextScreen()
}

class ImageDetailRouter {
    // MARK: - Public variables
    internal weak var view: ImageDetailViewController?
    
    // MARK: - Initialization
    init(view: ImageDetailViewController) {
        self.view = view
    }

}

extension ImageDetailRouter: ImageDetailRouterProtocol {
    func openNextScreen() {
    }

}
