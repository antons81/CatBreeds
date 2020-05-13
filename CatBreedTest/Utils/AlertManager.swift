//
//  AlertManager.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 14.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import UIKit

class AlertManager {
    
    static let shared = AlertManager()
    private init() {}
    
    private var window: UIWindow?
    private var alertController: UIAlertController!
    
    private func initAlertController() -> UIAlertController {
        alertController = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10,
                                                                     y: 5,
                                                                     width: 50,
                                                                     height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alertController.view.addSubview(loadingIndicator)
        
        return alertController
    }
    
    func showProgress() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        window?.windowLevel = UIWindow.Level.alert + 1
        window?.isHidden = false
        
        mainThread {
            UIView.transition(with: self.window!, duration: 1, options: .transitionCrossDissolve, animations: {
                let vc = UIViewController()
                vc.view.backgroundColor = .red
                self.window?.rootViewController = vc //self.initAlertController()
                self.window?.makeKeyAndVisible()
            }, completion: { completed in
                //self.window?.layoutIfNeeded()
                //self.window?.makeKeyAndVisible()
            })
        }
    }

    func dismissProgress(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2, animations: {
            completion()
        }) { (finished) in
            guard let window = self.window else { return }
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.window?.rootViewController = nil
            }, completion: { (finished) in
                self.window?.resignKey()
                self.window = nil
            })
        }
    }
}
