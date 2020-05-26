//
//  Enteties.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 21.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import CoreData

public enum ManagedEntities {
    case breed
    case gallery
}

public extension ManagedEntities {
    var name: String {
        switch self {
        case .breed: return "Breed"
        case .gallery: return "Gallery"
        }
    }
}
