//
//  BreedsViewController.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 08.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol BreedsViewProtocol: class {
    func reloadData()
    func configureTableView()
    func showSpinner()
    func hideSpinner(_ completion: SimpleCompletion)
}

class BreedsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let rowHeight: CGFloat = 70
    
    // MARK: - Public properties
    var presenter: BreedsPresenterProtocol?
    var configurator: BreedsConfiguratorProtocol?

    // MARK: - Private properties
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.config(viewController: self)
        presenter?.viewDidLoad()
    }
    
    // MARK: - Display logic
    
    // MARK: - Actions
    @IBAction func getToQuizz() {
        presenter?.openQuizz()
    }
    
    @IBAction func getToGallery() {
        presenter?.openGallery()
    }
    
    // MARK: - Overrides
    // MARK: - Private functions
}

extension BreedsViewController: BreedsViewProtocol {
    
    func showSpinner() {
        showProgress()
    }
    
    func hideSpinner(_ completion: SimpleCompletion) {
        dismissProgress {
            completion?()
        }
    }
    
    func configureTableView() {
        tableView.dataSource = presenter as? UITableViewDataSource
        tableView.delegate = presenter as? UITableViewDelegate
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = rowHeight
        tableView.rowHeight = rowHeight
        tableView.registerCellNib(BreedsCell.self)
    }
    
    func reloadData() {
        mainThread {
            self.tableView.reloadData()
        }
    }
}
