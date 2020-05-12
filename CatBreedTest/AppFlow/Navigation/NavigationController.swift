//
//  NavigationViewController.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 09.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol NavigationProtocol: class {
    func setRootViewController()
}

class NavigationController: UINavigationController {
    // MARK: - Public properties
    var presenter: NavigationPresenterProtocol?
    var configurator: NavigationConfiguratorProtocol?
    
    // MARK: - Private properties
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator?.config(viewController: self)
        presenter?.viewDidLoad()
    }
    
    // MARK: - Display logic
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
}

extension NavigationController: NavigationProtocol {
    func setRootViewController() {
        self.setViewControllers([BreedsConfigurator().makeViewController()], animated: true)
    }
}
