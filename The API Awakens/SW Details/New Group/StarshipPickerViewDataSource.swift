//
//  StarshipPickerViewDataSource.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 2/15/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import UIKit

class StarshipPickerViewDataSource: NSObject, UIPickerViewDataSource {
    private var starships: [SWStarship]
    
    init(starships: [SWStarship]) {
        self.starships = starships
        super.init()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return starships.count
    }
    
    // MARK: - Helpers
    func object(at row: Int) -> SWStarship {
        return starships[row]
    }
    
    func update(with data: [SWStarship]) {
        self.starships = data
    }
    
    func allValues() -> [SWStarship] {
        return self.starships
    }
}
