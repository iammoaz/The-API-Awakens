//
//  SWResponse.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 1/23/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import Foundation

//struct SWResponse<T: Decodable>: Decodable {
//
//    let count: Int
//    let next: String?
//    let previous: String?
//    let results: [T]
//
//    enum CodingKeys: String, CodingKey {
//        case count = "count"
//        case next = "next"
//        case previous = "previous"
//        case results = "results"
//    }
//}

class SWResponse: JSONDecodable {
    private (set) var count: Int
    private (set) var next: Int?
    private (set) var objects: JSON
    
    
    required init?(json: JSON) {
        self.count = json["count"].intValue
        self.objects = json["results"]
        
        guard let next = json["next"].string, let page = next.getQueryStringFor(parameter: "page") else { return }
        self.next = Int(page)!
    }
}
