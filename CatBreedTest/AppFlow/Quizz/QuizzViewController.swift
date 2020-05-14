//
//  QuizzViewController.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 11.05.2020.
//  Copyright (c) 2020 Anton Stremovskiy. All rights reserved.
//

import UIKit

protocol QuizzViewProtocol: class {
    var answerButtonsCount: Int { get }
    var finalScore: Int { get }
    func composeQA(_ breeds: Breeds, answer: Int, image: UIImage, _ completion: (() -> Void)?)
    func showSpinner()
    func hideSpinner(_ completion: SimpleCompletion)
    func showAlert(with message: String, handler: ((UIAlertAction)->Void)?)
}

class QuizzViewController: UIViewController {
    
    @IBOutlet weak var questionImage: UIImageView!
    
    // MARK: - Buttons
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    @IBOutlet var answer4: UIButton!
    
    @IBOutlet var scoreButton: UIBarButtonItem!
    
    var answerButtons: [UIButton]!
    
    // MARK: - Public properties
    var presenter: QuizzPresenterProtocol?
    var configurator: QuizzConfiguratorProtocol?
    
    // MARK: - Private properties
    private var rightAnswer = 0
    private var page = 1
    private var score = 0
    
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
        UIView.animate(withDuration: 0.2, animations: {
            sender.backgroundColor = isRight ? .green : .red
        }) { _ in
            mainThreadAfter(0.3) {
                self.presenter?.fetchBreeds(self.page)
                sender.backgroundColor = .systemBlue
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func checkTheAnswer(_ sender: UIButton) {
        answerChecker(sender)
    }
    
    // MARK: - Private functions
    private func answerChecker(_ sender: UIButton) {
        if sender.tag == rightAnswer {
            animateAnswer(sender, isRight: true)
            score += 5
        } else {
            animateAnswer(sender, isRight: false)
        }
        page += 1
    }
}

extension QuizzViewController: QuizzViewProtocol {
    
    var finalScore: Int {
        return score
    }
    
    var answerButtonsCount: Int {
        return answerButtons.count
    }
    
    func showSpinner() {
        showProgress()
        
    }
    
    func hideSpinner(_ completion: SimpleCompletion) {
        dismissProgress {
            completion?()
        }
    }
    
    func composeQA(_ breeds: Breeds, answer: Int, image: UIImage, _ completion: (() -> Void)?) {
        rightAnswer = answer
        
        mainThread {
            self.scoreButton.title = "Score: \(self.score)"
            self.questionImage.image = image
        }
        
        for (index, value) in answerButtons.enumerated() {
            mainThread {
                value.tag = index
                value.setTitle(breeds[index].name, for: .normal)
            }
        }
        
        completion?()
    }
}
