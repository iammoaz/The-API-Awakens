//
//  SWPlanet.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 4/4/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import Foundation

class SWPlanet: JSONDecodable {
    let name: String

    required init?(json: JSON) {
        self.name = json["name"].stringValue
    }
}
