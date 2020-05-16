//
//  CatBreedsEndPoint.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 07.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation


public enum BreedsApi {
    case getBreeds(page: Int?, limit: Int)
    case getImages(limit: Int)
    case getImageBy(limit: Int, breedId: String)
}


extension BreedsApi: EndPointType {
    
    var path: String {
        switch self {
        case .getBreeds:
            return "breeds"
        case .getImages:
            return "images/search"
        case .getImageBy:
            return "images/search"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getBreeds:
            return .get
        case .getImages:
            return .get
        case .getImageBy:
            return .get
        }
    }
    
    var task: HTTPTask {
        
        switch self {
        case .getBreeds(let page, let limit):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["page": page ?? 0, "limit": limit])
        case .getImages(let limit):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["limit": limit, "size": "thumb"])
        case .getImageBy(let limit, let breedId):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["breed_id": breedId, "limit": limit, "size": "thumb"])
            
        }
    }
    
    var headers: HTTPHeaders? {
        return ["x-api-key": APIKey]
    }
    
    var baseURL: URL {
        guard let url = URL(string: baseUrl) else { fatalError("baseURL could not be configured." )}
        return url
    }
}
