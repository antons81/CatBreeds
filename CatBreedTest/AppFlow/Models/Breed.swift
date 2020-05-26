//
//  Cat.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 05.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import CoreData

typealias Breeds = [Breed]

@objc(Breed)
class Breed: NSManagedObject {
    
//    let id: String
//    let name: String
//    let description: String
//    let temperament: String
//    let origin: String
//    let lifeSpan: String
    
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var temperament: String?
    @NSManaged public var origin: String?
    @NSManaged public var lifeSpan: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case desc = "description"
        case temperament = "temperament"
        case origin = "origin"
        case lifeSpan = "life_span"
    }
    
//    func decodeWith(_ decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//        desc = try container.decode(String.self, forKey: .desc)
//        temperament = try container.decode(String.self, forKey: .temperament)
//        origin = try container.decode(String.self, forKey: .origin)
//        lifeSpan = try container.decode(String.self, forKey: .lifeSpan)
//    }
//
//    // MARK: - Codable
//    public func encode(to encoder: Encoder) throws {
//        let container = try encoder.container(keyedBy: CodingKeys.self)
//        id = try container.encode(String.self, forKey: .id)
//        name = try container.encode(String.self, forKey: .name)
//        desc = try container.encode(String.self, forKey: .desc)
//        temperament = try container.encode(String.self, forKey: .temperament)
//        origin = try container.encode(String.self, forKey: .origin)
//        lifeSpan = try container.encode(String.self, forKey: .lifeSpan)
//    }
//
//    // MARK: - Decodable
//    required convenience init(from decoder: Decoder) throws {
//
//        let context = CoreDataManager.shared.defaultContext
//        let entity = Breed(context: context)
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//        desc = try container.decode(String.self, forKey: .desc)
//        temperament = try container.decode(String.self, forKey: .temperament)
//        origin = try container.decode(String.self, forKey: .origin)
//        lifeSpan = try container.decode(String.self, forKey: .lifeSpan)
//    }
}

//extension BreedResponse {
//
//    private enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case description = "description"
//        case temperament = "temperament"
//        case origin = "origin"
//        case lifeSpan = "life_span"
//    }
//
//    convenience init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//        desc = try container.decode(String.self, forKey: .description)
//        temperament = try container.decode(String.self, forKey: .temperament)
//        origin = try container.decode(String.self, forKey: .origin)
//        lifeSpan = try container.decode(String.self, forKey: .lifeSpan)
//    }
//}

//public extension CodingUserInfoKey {
//    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
//}
