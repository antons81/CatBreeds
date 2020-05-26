//
//  NetworkManager.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 07.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum NetworkResponse: String {
    case success
    case authError = "Authentication error"
    case badRequest = "Bad Request"
    case failed = "Request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
}

enum Result<String> {
    case success
    case failure(String)
}

class NetworkManager {
    
    private let router = Router<BreedsApi>()
    
    private var managedContext = CoreDataManager.shared.defaultContext
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure("statusCode: \(response.statusCode) " + NetworkResponse.authError.rawValue)
        case 501...599: return .failure("statusCode: \(response.statusCode) " + NetworkResponse.badRequest.rawValue)
        default: return .failure("statusCode: \(response.statusCode) " + NetworkResponse.badRequest.rawValue)
        }
    }
    
    func getCatBreeds(page: Int, limit: Int, completion: @escaping (_ breeds: Breeds?, _ error: String?) -> Void) {
        router.request(.getBreeds(page: page, limit: 1000)) { (data, response, error) in
            
            if error != nil {
                completion(nil, "please check your network connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let data = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        
                        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
                            return
                        }
                        
                        let breeds: Breeds = json.compactMap { [weak self] in
                            
                            guard let self = self,
                                let id = $0["id"] as? String,
                                let name = $0["name"] as? String,
                                let desc = $0["description"] as? String,
                                let temperament = $0["temperament"] as? String,
                                let origin  = $0["origin"] as? String,
                                let lifeSpan = $0["life_span"] as? String else {
                                    return nil
                            }
                            
                        
                            let breed = Breed(context: self.managedContext)
                            breed.id = id
                            breed.name = name
                            breed.desc = desc
                            breed.temperament = temperament
                            breed.origin = origin
                            breed.lifeSpan = lifeSpan
                            
                            return breed
                        }
                        
                        
                        CoreDataManager.shared.saveContext(with: self.managedContext) {
                            completion(breeds, nil)
                        }
                        //let apiResponse = try JSONDecoder().decode(Breeds.self, from: data)
                        //self.insertBreeds(breeds: apiResponse)
                        //completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
    
    func getImageBy(_ breedId: String, completion: @escaping (_ breedImage: [BreedImage]?, _ error: String?) -> Void) {
        router.request(.getImageBy(limit: 1, breedId: breedId)) { (data, response, error) in
            
            if error != nil {
                completion(nil, "please check your network connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let data = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let response = try JSONDecoder().decode([BreedImage].self, from: data)
                        completion(response, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
    
    func getImages(limit: Int, completion: @escaping (_ breedImage: [BreedImage]?, _ error: String?) -> Void) {
        router.request(.getImages(limit: limit)) { (data, response, error) in
            
            if error != nil {
                completion(nil, "please check your network connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let data = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let response = try JSONDecoder().decode([BreedImage].self, from: data)
                        completion(response, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
    
    // MARK: - CoreData Rerquests
    
    private func insertBreeds(breeds: [Breed]) {
        
        if breeds.count > 0 {
            CoreDataManager.shared.deleteAllData(.breed, completion: nil)
        }
        
        for breed in breeds {
            
            let breeds = Breed(context: self.managedContext)
            breeds.id = breed.id
            breeds.name = breed.name
            breeds.desc = breed.description
            breeds.temperament = breed.temperament
            breeds.origin = breed.origin
            breeds.lifeSpan = breed.lifeSpan
            
        }
        
        CoreDataManager.shared.saveContext(with: self.managedContext,
                                           completion: nil)
    }
}





