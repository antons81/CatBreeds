//
//  BreedImage.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 11.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation


struct BreedImage {
    let url: String
}

extension BreedImage: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
    }
}
