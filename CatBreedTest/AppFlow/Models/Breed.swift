//
//  Cat.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 05.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation

typealias Breeds = [BreedResponse]

struct BreedResponse {
    
    let id: String
    let name: String
    let description: String
    let temperament: String
    let origin: String
    let lifeSpan: String
}

extension BreedResponse: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case temperament = "temperament"
        case origin = "origin"
        case lifeSpan = "life_span"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        temperament = try container.decode(String.self, forKey: .temperament)
        origin = try container.decode(String.self, forKey: .origin)
        lifeSpan = try container.decode(String.self, forKey: .lifeSpan)
    }
}
