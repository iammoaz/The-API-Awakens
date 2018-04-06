//
//  SWEntityType.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 2/10/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import Foundation

enum SWType {
    case character(data: [SWCharacter])
    case vehicle(data: [SWVehicle])
    case starship(data: [SWStarship])
}

enum SWPropertyNames {
    case born(value: SWEntity)
    case home(value: SWEntity)
    case height(value: SWEntity)
    case eyes(value: SWEntity)
    case hair(value: SWEntity)
    case make(value: SWEntity)
    case cost(value: SWEntity)
    case length(value: SWEntity)
    case model(value: SWEntity)
    case crew(value: SWEntity)
    case starships(value: SWEntity)
}

class SWEntity {
    let title: String
    let value: Any
    
    init(title: String, value: Any) {
        self.title = title
        self.value = value
    }
}

