//
//  ImageDetailPresenter.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 12.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol ImageDetailPresenterProtocol: class {
    var view: ImageDetailViewProtocol? { get set }
    func viewDidLoad()
    func setImage(_ image: BreedImage)
}

class ImageDetailPresenter {
    // MARK: - Public variables
    internal weak var view: ImageDetailViewProtocol?

    // MARK: - Private variables
    private let router: ImageDetailRouterProtocol
    private let image: BreedImage
    
    // MARK: - Initialization
    init(router: ImageDetailRouterProtocol, view: ImageDetailViewProtocol, image: BreedImage) {
        self.router = router
        self.view = view
        self.image = image
    }

}

extension ImageDetailPresenter: ImageDetailPresenterProtocol {
    
    func setImage(_ image: BreedImage) {
        view?.setImage(image)
    }
    
    func viewDidLoad() {
        setImage(self.image)
    }
}
