//
//  Theme.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 1/24/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import UIKit

struct Theme {
    
    static var primaryColor: UIColor {
        return UIColor(red: 0.11, green: 0.13, blue: 0.14, alpha: 1.00)
    }
    
    static var yellowColor: UIColor {
        return UIColor(red: 0.98, green: 0.86, blue: 0.29, alpha: 1.00)
    }
}


extension String {
    func pickerViewTitleStyle() -> NSAttributedString {
        let attributedString = NSAttributedString(string: self, attributes: [NSAttributedStringKey.foregroundColor: Theme.yellowColor, NSAttributedStringKey.font: UIFont(descriptor: UIFontDescriptor(name: "Avenir Next Demi Bold", size: 16), size: 16)])
        return attributedString
    }
}
