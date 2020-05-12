//
//  NavigationPresenter.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 09.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol NavigationPresenterProtocol: class {
    var view: NavigationProtocol? { get set }
    func viewDidLoad()
}

class NavigationPresenter {
    // MARK: - Public variables
    internal weak var view: NavigationProtocol?

    // MARK: - Private variables
    private let router: NavigationRouterProtocol
    
    // MARK: - Initialization
    init(router: NavigationRouterProtocol, view: NavigationProtocol) {
        self.router = router
        self.view = view
    }

}

extension NavigationPresenter: NavigationPresenterProtocol {
    func viewDidLoad() {
        view?.setRootViewController()
    }
}
