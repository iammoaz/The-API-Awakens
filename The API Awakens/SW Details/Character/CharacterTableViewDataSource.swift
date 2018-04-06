//
//  CharacterTableViewDataSource.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 2/8/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import UIKit

class CharacterTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var character: SWCharacter
    private var parentController: SWDetailController
    
    init(character: SWCharacter, parentController: SWDetailController) {
        self.character = character
        self.parentController = parentController
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character.properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let property = character.properties[indexPath.row]
        
        switch property {
        case .born(let value), .eyes(let value), .hair(let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.reuseIdentifier, for: indexPath) as! DefaultCell
            cell.configure(with: value)
            return cell
            
        case .home(let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.reuseIdentifier, for: indexPath) as! DefaultCell
            cell.configureForWorld(with: value)
            cell.parentController = parentController
            return cell
            
        case .starships(let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.reuseIdentifier, for: indexPath) as! DefaultCell
            cell.configureForStarships(with: value)
            cell.parentController = parentController
            return cell
            
        case .height(let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: MeasurementCell.reuseIdentifier, for: indexPath) as! MeasurementCell
            cell.configure(with: value, type: .height)
            return cell
            
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func updateData(_ character: SWCharacter) {
        self.character = character
    }
}
