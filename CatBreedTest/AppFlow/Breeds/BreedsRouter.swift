//
//  BreedsRouter.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 08.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation

protocol BreedsRouterProtocol: class {
    var view: BreedsViewController? { get set }
    func openBreedDetails(_ breed: Breed)
    func openQuizz()
    func openGallery()
}

class BreedsRouter {
    // MARK: - Public variables
    internal weak var view: BreedsViewController?
    
    // MARK: - Initialization
    init(view: BreedsViewController) {
        self.view = view
    }

}

extension BreedsRouter: BreedsRouterProtocol {
    
    func openGallery() {
        let gallery = CatGalleryConfigurator().makeViewController()
        view?.navigationController?.show(gallery, sender: self)
    }
    
    func openQuizz() {
        let quizz = QuizzConfigurator().makeViewController()
        view?.navigationController?.show(quizz, sender: self)
    }
    
    func openBreedDetails(_ breed: Breed) {
        let details = BreedDetailsConfigurator().makeViewController(breed)
        view?.navigationController?.show(details, sender: self)
    }
}
