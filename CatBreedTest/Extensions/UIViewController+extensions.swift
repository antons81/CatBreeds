//
//  UIViewController+extensions.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 08.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import UIKit

enum StoryBoardName: String {
    case main = "Main"
}

extension UIViewController {
    
    class var vcName: String {
        return String(describing: self)
    }
    
    class func instatiateFromNib<T: UIViewController>(_ storyboardName: StoryBoardName) -> T? {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? T {
            return vc
        }
        return nil
    }
}

extension UINavigationController {
    
    class func instatiateFrom<T: UINavigationController>(_ storyboardName: StoryBoardName) -> T? {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? T {
            return vc
        }
        return nil
    }
    
    func popViewControllerWithHandler(completion: SimpleCompletion) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: true)
        CATransaction.commit()
    }
}


fileprivate var alertVc: UIAlertController?

extension UIViewController {
    
    func showProgress() {
        alertVc = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10,
                                                                     y: 5,
                                                                     width: 50,
                                                                     height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        
        alertVc?.view.addSubview(loadingIndicator)
        
        mainThread {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                self.present(alertVc ?? UIAlertController(), animated: true, completion: nil)
            }, completion: nil)
        }
    }
    
    func dismissProgress(_ completion: SimpleCompletion) {
        mainThread {
            UIView.animate(withDuration: 0.5, animations: {
                alertVc?.dismiss(animated: true, completion: nil)
                completion?()
            }) { _ in
                alertVc = nil
            }
        }
    }
}


extension UIViewController {
    func showAlert(with message: String, handler: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: "Quizz Result", message: "Congratulation!\nYour score is: \(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        present(alert, animated: true)
    }
}
