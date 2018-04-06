//
//  SWCharacter.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 1/23/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import Foundation

class SWCharacter: JSONDecodable {
    let name: String
    let height: Double
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: Int
    var starships: [Int] = []
    
    required init?(json: JSON) {
        self.name = json["name"].stringValue
        self.height = Double(json["height"].stringValue) ?? 0
        self.mass = json["mass"].stringValue
        self.hairColor = json["hair_color"].stringValue
        self.skinColor = json["skin_color"].stringValue
        self.eyeColor = json["eye_color"].stringValue
        self.birthYear = json["birth_year"].stringValue
        self.gender = json["gender"].stringValue
        
        let homeworld = json["homeworld"].stringValue
        let homeworldPath = URL(string: homeworld)!.lastPathComponent
        self.homeworld = Int(homeworldPath)!
        
        let starshipsArray = json["starships"].arrayValue
        let starships = starshipsArray.compactMap({ URL(string: $0.stringValue)!.lastPathComponent })
        self.starships = starships.compactMap({ Int($0)! })
    }
    
}

extension SWCharacter {
    var properties: [SWPropertyNames] {
        return [
            .born(value: SWEntity(title: "Birth", value: birthYear)),
            .home(value: SWEntity(title: "Home", value: homeworld)),
            .height(value: SWEntity(title: "Height", value: height)),
            .eyes(value: SWEntity(title: "Eyes", value: eyeColor)),
            .hair(value: SWEntity(title: "Hair", value: hairColor)),
            .starships(value: SWEntity(title: "Starship", value: starships))
        ]
    }
}
