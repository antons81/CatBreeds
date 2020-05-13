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
}
