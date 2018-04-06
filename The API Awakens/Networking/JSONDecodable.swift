//
//  JSONDecodable.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 3/24/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias JSON = SwiftyJSON.JSON

protocol JSONDecodable {
    init?(json: JSON)
}


