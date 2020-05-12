//
//  QuizzPresenter.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 11.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol QuizzPresenterProtocol: class {
    var view: QuizzViewProtocol? { get set }
    func viewDidLoad()
    func fetchBreeds(_ page: Int)
}

class QuizzPresenter {
    
    
    // MARK: - Public variables
    internal weak var view: QuizzViewProtocol?

    // MARK: - Private variables
    private let router: QuizzRouterProtocol
    private let service: QuizzService
    
    // MARK: - Initialization
    init(router: QuizzRouterProtocol,
         view: QuizzViewProtocol,
         service: QuizzService) {

        self.router = router
        self.view = view
        self.service = service
    }

}

extension QuizzPresenter: QuizzPresenterProtocol {
    
    func fetchBreeds(_ page: Int) {
        var randomIndex = 0
        service.fetchBreeds(page: page) { [weak self] breeds in
        
            for _ in breeds {
                randomIndex = Int(arc4random()) % breeds.count
                break
            }

            self?.service.fetchImageBy(breeds[randomIndex].id) { [weak self] image in
                guard let url = URL(string: image.url) else { return }
                guard let data = try? Data(contentsOf: url) else { return }
                guard let image  = UIImage(data: data) else { return }
                self?.view?.composeQA(breeds, answer: randomIndex, image: image)
            }
        }
    }
    
    func viewDidLoad() {
        fetchBreeds(1)
    }
}
