//
//  VehiclePickerViewDataSource.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 2/15/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import UIKit

class VehiclePickerViewDataSource: NSObject, UIPickerViewDataSource {
    private var vehicles: [SWVehicle]
    
    init(vehicles: [SWVehicle]) {
        self.vehicles = vehicles
        super.init()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vehicles.count
    }
    
    // MARK: - Helpers
    func object(at row: Int) -> SWVehicle {
        return vehicles[row]
    }
    
    func update(with data: [SWVehicle]) {
        self.vehicles = data
    }
    
    func allValues() -> [SWVehicle] {
        return self.vehicles
    }
}

