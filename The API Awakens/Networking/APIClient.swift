//
//  APIClient.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 1/22/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed:
            return "Request Failed"
        case .invalidData:
            return "Invalid Data"
        case .responseUnsuccessful:
            return "Response Unsuccessful"
        case .jsonParsingFailure:
            return "JSON Parsing Failure"
        case .jsonConversionFailure:
            return "JSON Conversion Failure"
        }
    }
}

protocol APIClient {
    var session: URLSession { get }
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> [T], completion: @escaping (Result<[T], APIError>) -> Void)
}


extension APIClient {
    typealias JSONTaskCompletionHandler = (JSON?, APIError?) -> Void
    
    func jsonTask(with request: URLRequest, completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                guard let data = data else {
                    completion(nil, .invalidData)
                    return
                }
                
                do {
                    let json = try JSON(data: data)
                    completion(json, nil)
                } catch {
                    completion(nil, .jsonConversionFailure)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        
        return task
    }
    
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let task = jsonTask(with: request) { (json, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(.invalidData))
                    }
                    
                    return
                }
                
                if let value = parse(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        
        task.resume()
    }
    
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> [T], completion: @escaping (Result<[T], APIError>) -> Void) {
        
        let task = jsonTask(with: request) { (json, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(.invalidData))
                    }
                    
                    return
                }
                
                let value = parse(json)
                
                if !value.isEmpty {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        
        task.resume()
    }
}

