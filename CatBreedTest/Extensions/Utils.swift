//
//  Utils.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 08.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation


func mainThread(_ completion: (() -> Void)?) {
    DispatchQueue.main.async {
        completion?()
    }
}

func mainThreadAfter(_ deadline: Double, _ completion: (() ->())?) {
    DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
        completion?()
    }
}


