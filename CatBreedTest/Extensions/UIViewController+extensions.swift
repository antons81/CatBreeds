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

fileprivate let alertVc = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

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
}


extension UIViewController {
    func showProgress() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10,
                                                                     y: 5,
                                                                     width: 50,
                                                                     height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()

        alertVc.view.addSubview(loadingIndicator)
        self.navigationController?.present(alertVc, animated: true, completion: nil)
    }
    
    func dismissProgress() {
        mainThread {
            alertVc.dismiss(animated: true, completion: nil)
        }
    }
}
