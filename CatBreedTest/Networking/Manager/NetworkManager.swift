//
//  NetworkManager.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 07.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import UIKit

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
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure("statusCode: \(response.statusCode) " + NetworkResponse.authError.rawValue)
        case 501...599: return .failure("statusCode: \(response.statusCode) " + NetworkResponse.badRequest.rawValue)
        default: return .failure("statusCode: \(response.statusCode) " + NetworkResponse.badRequest.rawValue)
        }
    }
    
    func getCatBreeds(page: Int, limit: Int, completion: @escaping (_ breeds: Breeds?, _ error: String?) -> Void) {
        
        router.request(.getBreeds(page: page, limit: limit)) { (data, response, error) in
            
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
                        let apiResponse = try JSONDecoder().decode(Breeds.self, from: data)
                        completion(apiResponse, nil)
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
    
}





