//
//  SWClient.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 1/23/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import Foundation

class SWCient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func characters(for id: Int, completion: @escaping (Result<SWResponse, APIError>) -> Void) {
        let endpoint = SWAPI.characters(id: id)
        let request = endpoint.request
        
        fetch(with: request, parse: { json -> SWResponse? in
            return SWResponse(json: json)
        }, completion: completion)
    }
    
    func vehicles(for id: Int, completion: @escaping (Result<SWResponse, APIError>) -> Void) {
        let endpoint = SWAPI.vehicles(id: id)
        let request = endpoint.request

        fetch(with: request, parse: { json -> SWResponse? in
            return SWResponse(json: json)
        }, completion: completion)
    }
    
    func starships(for id: Int, completion: @escaping (Result<SWResponse, APIError>) -> Void) {
        let endpoint = SWAPI.starships(id: id)
        let request = endpoint.request

        fetch(with: request, parse: { json -> SWResponse? in
            return SWResponse(json: json)
        }, completion: completion)
    }
    
    func planet(with id: Int, completion: @escaping (Result<SWPlanet, APIError>) -> Void) {
        let endpoint = SWAPI.planet(id: id)
        let request = endpoint.request
        
        fetch(with: request, parse: { json -> SWPlanet? in
            return SWPlanet(json: json)
        }, completion: completion)
    }
    
    func starship(for id: Int, completion: @escaping (Result<SWStarship, APIError>) -> Void) {
        let endpoint = SWAPI.starship(id: id)
        let request = endpoint.request
        
        fetch(with: request, parse: { json -> SWStarship? in
            return SWStarship(json: json)
        }, completion: completion)
    }
}

