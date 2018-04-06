//
//  SWAPI.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 1/22/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import Foundation

enum SWAPI {
    case characters(id: Int)
    case vehicles(id: Int)
    case starships(id: Int)
    case starship(id: Int)
    case planet(id: Int)
    case films(id: Int)
}

extension SWAPI: Endpoint {
    var base: String {
        return "https://swapi.co"
    }
    
    var path: String {
        switch self {
        case .characters:
            return "/api/people"
        case .vehicles:
            return "/api/vehicles"
        case .starships:
            return "/api/starships"
        case .films(let id):
            return "/api/films/\(id)"
        case .planet(let id):
            return "/api/planets/\(id)"
        case .starship(let id):
            return "/api/starships/\(id)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .characters(let id), .vehicles(let id), .starships(let id):
            return [
                URLQueryItem(name: "page", value: "\(id)")
            ]
        default:
            return []
        }
    }
}
