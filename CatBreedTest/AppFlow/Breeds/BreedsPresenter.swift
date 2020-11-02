//
//  BreedsPresenter.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 08.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol BreedsPresenterProtocol: class {
    var view: BreedsViewProtocol? { get set }
    func viewDidLoad()
    func fetchBreeds(_ limit: Int)
    func openQuizz()
    func openGallery()
    func loadMoreBreeds()
}


class BreedsPresenter: NSObject {
    
    // MARK: - Public variables
    internal weak var view: BreedsViewProtocol?
    
    var defaultLimit = 20
    let bottomOffset: CGFloat = 10
    private var breedsOffset = 20
    
    var breeds = Breeds() {
        didSet {
            view?.reloadData()
            view?.hideSpinner(nil)
        }
    }

    // MARK: - Private variables
    private let router: BreedsRouterProtocol
    private let service: BreedsService
    
    // MARK: - Initialization
    init(router: BreedsRouterProtocol,
         view: BreedsViewProtocol,
         service: BreedsService) {
        
        self.router = router
        self.view = view
        self.service = service
    }
}

extension BreedsPresenter: BreedsPresenterProtocol {
    
    func openGallery() {
        router.openGallery()
    }
    
    func openQuizz() {
        router.openQuizz()
    }
    
    func fetchBreeds(_ limit: Int) {
        view?.showSpinner()
        service.fetchBreeds(limit) { breeds in
            self.breeds = breeds
        }
    }
    
    func viewDidLoad() {
        view?.configureTableView()
        fetchBreeds(defaultLimit)
    }
    
    func loadMoreBreeds() {
        defaultLimit += breedsOffset
        fetchBreeds(defaultLimit)
    }
}

extension BreedsPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(indexPath: indexPath) as BreedsCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? BreedsCell {
            cell.setupCell(breeds[indexPath.row])
        }
    }
}


extension BreedsPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breed = breeds[indexPath.row]
        router.openBreedDetails(breed)
    }
}



extension BreedsPresenter: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= bottomOffset {
            loadMoreBreeds()
        }
    }
}
