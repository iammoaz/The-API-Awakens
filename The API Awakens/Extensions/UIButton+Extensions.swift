//
//  UIButton+Extensions.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 4/5/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import UIKit

extension UIButton {
    func toggleDisable(_ button: UIButton) {
        self.isEnabled = false
        button.isEnabled = true
    }
}
