//
//  CharacterPickerViewDataSource.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 1/29/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import UIKit

class CharacterPickerViewDataSource: NSObject, UIPickerViewDataSource {
    private var characters: [SWCharacter]
    
    init(characters: [SWCharacter]) {
        self.characters = characters
        super.init()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return characters.count
    }
    
    // MARK: - Helpers
    func object(at row: Int) -> SWCharacter {
        return characters[row]
    }
    
    func update(with data: [SWCharacter]) {
        self.characters = data
    }
    
    func allValues() -> [SWCharacter] {
        return self.characters
    }
}
