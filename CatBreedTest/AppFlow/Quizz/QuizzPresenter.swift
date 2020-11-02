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
        
        view?.showSpinner()
        var randomIndex = 0
        
        service.fetchBreeds(page: page) { [weak self] breeds in
            guard let self = self else { return }
            
            // check if breeds less than 4 (no more breeds fetched) then end game
            if self.view?.answerButtonsCount != breeds.count  {
                mainThread {
                    self.view?.hideSpinner ({
                        mainThreadAfter(1) {
                            self.view?.showAlert(with: "\(self.view?.finalScore ?? 0)", handler: { _ in
                                self.router.backToMain()
                            })
                        }
                    })
                }
                return
            }
            
            for _ in breeds {
                randomIndex = Int(arc4random()) % breeds.count
                break
            }
            
            self.service.fetchImageBy(breeds[randomIndex].id) { [weak self] image in
                guard let url = URL(string: image.url),
                      let data = try? Data(contentsOf: url),
                      let image  = UIImage(data: data) else { return }
               
                
                self?.view?.composeQA(breeds, answer: randomIndex, image: image) {
                    self?.view?.hideSpinner(nil)
                }
            }
        }
    }
    
    func viewDidLoad() {
        fetchBreeds(0)
    }
}
