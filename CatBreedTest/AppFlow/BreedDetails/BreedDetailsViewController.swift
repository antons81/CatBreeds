//
//  BreedDetailsViewController.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 10.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol BreedDetailsViewProtocol: class {
    func showDetails(_ breed: Breed, image: UIImage)
    func showSpinner()
    func hideSpinner(_ completion: SimpleCompletion)
}

class BreedDetailsViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var temperament: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var lifeSpan: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    
    // MARK: - Public properties
    var presenter: BreedDetailsPresenterProtocol?
    var configurator: BreedDetailsConfiguratorProtocol?
    
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

extension BreedDetailsViewController: BreedDetailsViewProtocol {
    
    func showSpinner() {
        showProgress()
    }
    
      func hideSpinner(_ completion: SimpleCompletion) {
          dismissProgress {
              completion?()
          }
      }
    
    func showDetails(_ breed: Breed, image: UIImage) {
        mainThread {
            self.name.text = breed.name
            self.desc.text = breed.desc
            self.temperament.text = breed.temperament
            self.lifeSpan.text = breed.lifeSpan ?? "" + " years"
            self.origin.text = breed.origin
            self.breedImage.image = image
        }
    }
}
