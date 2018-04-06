//
//  SWVehicle.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 1/23/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import Foundation

class SWVehicle: JSONDecodable {
    let name: String
    let model: String
    let manufacturer: String
    let cost: Double
    let length: Double
    let speed: String
    let crew: String
    let passengers: String
    let capacity: String
    let consumables: String
    let vehicle: String
    
    required init?(json: JSON) {
        self.name = json["name"].stringValue
        self.model = json["model"].stringValue
        self.manufacturer = json["manufacturer"].stringValue
        self.cost = Double(json["cost_in_credits"].stringValue) ?? 0
        self.length = Double(json["length"].stringValue) ?? 0
        self.speed = json["max_atmosphering_speed"].stringValue
        self.crew = json["crew"].stringValue
        self.passengers = json["passengers"].stringValue
        self.capacity = json["cargo_capacity"].stringValue
        self.consumables = json["consumables"].stringValue
        self.vehicle = json["vehicle_class"].stringValue
    }
}


extension SWVehicle {
    var properties: [SWPropertyNames] {
        return [
            .model(value: SWEntity(title: "Model", value: model)),
            .length(value: SWEntity(title: "Length", value: length)),
            .crew(value: SWEntity(title: "Crew", value: crew)),
            .cost(value: SWEntity(title: "Cost", value: cost))
        ]
    }
}

