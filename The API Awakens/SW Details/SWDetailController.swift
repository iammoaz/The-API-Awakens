//
//  SWDetailController.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 1/24/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import UIKit

class SWDetailController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    var type: SWType = .character(data: [])
    
    lazy var characterPickerViewDataSource: CharacterPickerViewDataSource = {
        return CharacterPickerViewDataSource(characters: [])
    }()
    
    lazy var characterTableViewDataSource: CharacterTableViewDataSource = {
        return CharacterTableViewDataSource(character: characterPickerViewDataSource.object(at: 0), parentController: self)
    }()
    
    lazy var vehiclePickerViewDataSource: VehiclePickerViewDataSource = {
        return VehiclePickerViewDataSource(vehicles: [])
    }()
    
    lazy var vehicleTableViewDataSource: VehicleTableViewDataSource = {
        return VehicleTableViewDataSource(vehicle: vehiclePickerViewDataSource.object(at: 0), parentController: self)
    }()
    
    lazy var starshipPickerViewDataSource: StarshipPickerViewDataSource = {
        return StarshipPickerViewDataSource(starships: [])
    }()
    
    lazy var starshipTableViewDataSource: StarshipTableViewDataSource = {
        return StarshipTableViewDataSource(starship: starshipPickerViewDataSource.object(at: 0), parentController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        pickerView.delegate = self

        switch type {
        case .character(let characters):
            setupView(for: characters)
        case .vehicle(let vehicles):
            setupView(for: vehicles)
        case .starship(let starships):
            setupView(for: starships)
        }
    }
    
    func setupView(for characters: [SWCharacter]) {
        title = "Characters"
        characterPickerViewDataSource.update(with: characters)
        pickerView.dataSource = characterPickerViewDataSource
        tableView.dataSource = characterTableViewDataSource
        
        guard let viewModel = SWDetailViewModel(characters: characters, index: 0) else { return }
        configure(with: viewModel)
    }
    
    func setupView(for vehicles: [SWVehicle]) {
        title = "Vehicles"
        vehiclePickerViewDataSource.update(with: vehicles)
        pickerView.dataSource = vehiclePickerViewDataSource
        tableView.dataSource = vehicleTableViewDataSource
        
        guard let viewModel = SWDetailViewModel(vehicles: vehicles, index: 0) else { return }
        configure(with: viewModel)
    }
    
    func setupView(for starships: [SWStarship]) {
        title = "Starships"
        starshipPickerViewDataSource.update(with: starships)
        pickerView.dataSource = starshipPickerViewDataSource
        tableView.dataSource = starshipTableViewDataSource
        
        guard let viewModel = SWDetailViewModel(starships: starships, index: 0) else { return }
        configure(with: viewModel)
    }
    
    func configure(with viewModel: SWDetailViewModel) {
        nameLabel.text = viewModel.nameLabel
        smallestLabel.text = viewModel.smallestLabel
        largestLabel.text = viewModel.largestLabel
    }

}

extension SWDetailController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch type {
        case .character(_):
            let character = characterPickerViewDataSource.object(at: row)
            return character.name.pickerViewTitleStyle()
            
        case .vehicle(_):
            let vehicle = vehiclePickerViewDataSource.object(at: row)
            return vehicle.name.pickerViewTitleStyle()
            
        case .starship(_):
            let starship = starshipPickerViewDataSource.object(at: row)
            return starship.name.pickerViewTitleStyle()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        switch type {
        case .character(_):
            let character = characterPickerViewDataSource.object(at: row)
            characterTableViewDataSource.updateData(character)
            tableView.reloadData()
            guard let viewModel = SWDetailViewModel(characters: characterPickerViewDataSource.allValues(), index: row) else { return }
            configure(with: viewModel)
            
        case .vehicle(_):
            let vehicle = vehiclePickerViewDataSource.object(at: row)
            vehicleTableViewDataSource.updateData(vehicle)
            tableView.reloadData()
            guard let viewModel = SWDetailViewModel(vehicles: vehiclePickerViewDataSource.allValues(), index: row) else { return }
            configure(with: viewModel)
            
        case .starship(_):
            let starship = starshipPickerViewDataSource.object(at: row)
            starshipTableViewDataSource.updateData(starship)
            tableView.reloadData()
            guard let viewModel = SWDetailViewModel(starships: starshipPickerViewDataSource.allValues(), index: row) else { return }
            configure(with: viewModel)
        }
        
    }
}
