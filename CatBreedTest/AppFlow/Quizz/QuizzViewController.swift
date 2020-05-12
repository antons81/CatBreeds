//
//  QuizzViewController.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 11.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol QuizzViewProtocol: class {
    func composeQA(_ breeds: Breeds, answer: Int, image: UIImage)
}

class QuizzViewController: UIViewController {
    
    @IBOutlet weak var questionImage: UIImageView!
    
    // MARK: - Buttons
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    var answerButtons: [UIButton]!
    
    // MARK: - Public properties
    var presenter: QuizzPresenterProtocol?
    var configurator: QuizzConfiguratorProtocol?
    
    // MARK: - Private properties
    private var rightAnswer = 0
    private var page = 1
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator?.config(viewController: self)
        presenter?.viewDidLoad()
        
        answerButtons = [
            self.answer1,
            self.answer2,
            self.answer3,
            self.answer4
        ]
    }
    
    // MARK: - Display logic
    private func animateAnswer(_ sender: UIButton, isRight: Bool) {
        UIView.animate(withDuration: 1, animations: {
            sender.backgroundColor = isRight ? .green : .red
        }) { _ in
            self.presenter?.fetchBreeds(self.page)
            sender.backgroundColor = .systemBlue
        }
    }
    
    // MARK: - Actions
    @IBAction func checkTheAnswer(_ sender: UIButton) {
        answerChecker(sender)
    }
    
    // MARK: - Private functions
    private func answerChecker(_ sender: UIButton) {
        print(sender.tag)
        if sender.tag == rightAnswer {
            animateAnswer(sender, isRight: true)
        } else {
            animateAnswer(sender, isRight: false)
        }
        page += 1
    }
}

extension QuizzViewController: QuizzViewProtocol {
    
    func composeQA(_ breeds: Breeds, answer: Int, image: UIImage) {
        
        rightAnswer = answer
        //print("right answer tag " + "\(rightAnswer)")
        
        mainThread {
            self.questionImage.image = image
        }
        
        for (index, value) in answerButtons.enumerated() {
            mainThread {
                value.tag = index
                value.setTitle(breeds[index].name, for: .normal)
                //print("set name " + breeds[index].name)
            }
        }
    }
}
