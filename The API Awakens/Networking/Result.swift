//
//  Result.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 1/22/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}
