//
//  URL+Extensions.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 4/4/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import Foundation

extension String {
    func getQueryStringFor(parameter: String) -> String? {
        guard let url = URLComponents(string: self) else { return nil }
        return url.queryItems?.first(where: { $0.name == parameter })?.value
    }
}
