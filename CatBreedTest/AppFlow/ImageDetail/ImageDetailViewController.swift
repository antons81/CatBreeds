//
//  ImageDetailViewController.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 12.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol ImageDetailViewProtocol: class {
    func setImage(_ image: BreedImage)
}

class ImageDetailViewController: UIViewController {
    
    @IBOutlet var image: UIImageView!
    
    // MARK: - Public properties
    var presenter: ImageDetailPresenterProtocol?
    var configurator: ImageDetailConfiguratorProtocol?
    
    // MARK: - Private properties
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator?.config(viewController: self)
        presenter?.viewDidLoad()
        title = "Photo"
    }
    
    // MARK: - Display logic
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
}

extension ImageDetailViewController: ImageDetailViewProtocol {
    func setImage(_ image: BreedImage) {
        guard let url = URL(string: image.url) else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        guard let image = UIImage(data: data) else { return }
        mainThread {
            self.image.image = image
        }
    }
}
