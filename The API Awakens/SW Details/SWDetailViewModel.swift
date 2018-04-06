//
//  SWDetailViewModel.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 2/16/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import Foundation

struct SWDetailViewModel {
    let nameLabel: String
    let smallestLabel: String
    let largestLabel: String
}

extension SWDetailViewModel {
    init?(characters: [SWCharacter], index: Int) {
        let character = characters[index]
        self.nameLabel = character.name
        
        let sortedCharacters = characters.sorted { $0.height < $1.height }
        self.smallestLabel = sortedCharacters.first!.name
        self.largestLabel = sortedCharacters.last!.name
    }
    
    init?(vehicles: [SWVehicle], index: Int) {
        let vehicle = vehicles[index]
        self.nameLabel = vehicle.name
        
        let sortedVehicles = vehicles.sorted { $0.length < $1.length }
        self.smallestLabel = sortedVehicles.first!.name
        self.largestLabel = sortedVehicles.last!.name
    }
    
    init?(starships: [SWStarship], index: Int) {
        let starship = starships[index]
        self.nameLabel = starship.name
        
        let sortedStarship = starships.sorted { $0.length < $1.length }
        self.smallestLabel = sortedStarship.first!.name
        self.largestLabel = sortedStarship.last!.name
    }
}
