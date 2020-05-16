//
//  CatGalleryPresenter.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 12.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol CatGalleryPresenterProtocol: class {
    var view: CatGalleryViewProtocol? { get set }
    func viewDidLoad()
}

class CatGalleryPresenter: NSObject {
    // MARK: - Public variables
    internal weak var view: CatGalleryViewProtocol?

    // MARK: - Private variables
    private let router: CatGalleryRouterProtocol
    private let service: ImageService
    
    private var images = [BreedImage]() {
        didSet {
            view?.reloadData()
        }
    }
    
    var defaultLimit = 50
    let bottomOffset: CGFloat = 10
    
    // MARK: - Initialization
    init(router: CatGalleryRouterProtocol,
         view: CatGalleryViewProtocol,
         service: ImageService) {
        
        self.router = router
        self.view = view
        self.service = service
    }
    
    private func fetchImages(_ page: Int, limit: Int) {
        service.fetchImages(limit: limit) { [weak self] images in
            self?.images = images
        }
    }
    
    func loadMoreBreeds() {
        defaultLimit += 50
        fetchImages(0, limit: defaultLimit)
    }
}

extension CatGalleryPresenter: CatGalleryPresenterProtocol {
    func viewDidLoad() {
        view?.configureCollectionView()
        fetchImages(0, limit: defaultLimit)
    }
}

extension CatGalleryPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(indexPath: indexPath) as ImageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let image = images[indexPath.item]
        if let cell = cell as? ImageCell {
            cell.setupImage(image)
        }
    }
}


extension CatGalleryPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataImage = images[indexPath.item]
        router.openFullImage(dataImage)
    }
}


extension CatGalleryPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size.width / 4
        let offset: CGFloat = 1
        return CGSize(width: size - offset, height: size - offset)
    }
}

//
//extension CatGalleryPresenter: UIScrollViewDelegate {
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        
//        let currentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//        
//        if maximumOffset - currentOffset <= bottomOffset {
//            loadMoreBreeds()
//        }
//    }
//}
