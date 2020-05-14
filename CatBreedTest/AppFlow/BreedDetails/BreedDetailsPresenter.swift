//
//  BreedDetailsPresenter.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 10.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol BreedDetailsPresenterProtocol: class {
    var view: BreedDetailsViewProtocol? { get set }
    func viewDidLoad()
}

class BreedDetailsPresenter {
    
    // MARK: - Public variables
    internal weak var view: BreedDetailsViewProtocol?

    // MARK: - Private variables
    private let router: BreedDetailsRouterProtocol
    private let breedDetail: BreedResponse
    private var service: BreedDetailService
    
    // MARK: - Initialization
    init(router: BreedDetailsRouterProtocol,
         view: BreedDetailsViewProtocol,
         breed: BreedResponse,
         service: BreedDetailService) {

        self.router = router
        self.view = view
        self.breedDetail = breed
        self.service = service
    }
    
    private func fetchImage(_  completion: ((UIImage) -> Void)?) {
        view?.showSpinner()
        service.fetchImageBy(breedDetail.id) { image in
            guard let url = URL(string: image.url) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image  = UIImage(data: data) else { return }
            completion?(image)
        }
    }
}

extension BreedDetailsPresenter: BreedDetailsPresenterProtocol {
    func viewDidLoad() {
        fetchImage { [weak self] image in
            guard let self = self else { return }
            self.view?.showDetails(self.breedDetail, image: image)
            self.view?.hideSpinner(nil)
        }
    }
}
