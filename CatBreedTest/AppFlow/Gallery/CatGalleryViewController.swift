//
//  CatGalleryViewController.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 12.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol CatGalleryViewProtocol: class {
    func configureCollectionView()
    func reloadData()
}

class CatGalleryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Public properties
    var presenter: CatGalleryPresenterProtocol?
    var configurator: CatGalleryConfiguratorProtocol?
    
    // MARK: - Private properties
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator?.config(viewController: self)
        presenter?.viewDidLoad()
        title = "Gallery"
    }
    
    // MARK: - Display logic
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
}

extension CatGalleryViewController: CatGalleryViewProtocol {
    
    func reloadData() {
        mainThread {
            self.collectionView.reloadData()
        }
    }
    
    func configureCollectionView() {
        collectionView.dataSource = presenter as? UICollectionViewDataSource
        collectionView.delegate = presenter as? UICollectionViewDelegate
        collectionView.registerCellNib(ImageCell.self)
        collectionView.systemLayoutSizeFitting(.zero)
    }
}
