//
//  StarshipTableViewDataSource.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 2/15/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import UIKit

class StarshipTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var starship: SWStarship
    private var parentController: SWDetailController
    
    init(starship: SWStarship, parentController: SWDetailController) {
        self.starship = starship
        self.parentController = parentController
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starship.properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let property = starship.properties[indexPath.row]
        
        switch property {
        case .model(let value), .crew(let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.reuseIdentifier, for: indexPath) as! DefaultCell
            cell.configure(with: value)
            return cell
            
        case .cost(let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: ConversionCell.reuseIdentifier, for: indexPath) as! ConversionCell
            cell.configure(with: value)
            cell.parentController = parentController
            return cell
            
        case .length(let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: MeasurementCell.reuseIdentifier, for: indexPath) as! MeasurementCell
            cell.configure(with: value, type: .length)
            return cell
            
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func updateData(_ starship: SWStarship) {
        self.starship = starship
    }
}

