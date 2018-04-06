//
//  ViewController.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 12/13/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var client = SWCient()
    private lazy var objects: [JSON] = []
    private lazy var activityIndicatorController = ActivityIndicatorController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = Theme.primaryColor
        title = "Starwars"
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.objects.removeAll()
    }
    
    func fetchCharacters(in page: Int) {
        client.characters(for: page) { [weak self] result in
            switch result {
            case .success(let response):
                for object in response.objects.arrayValue {
                    self?.objects.append(object)
                }
                self?.loadMoreCharacters(response.next)
            case .failure(let error):
                self?.presentAlertController(with: "Error", message: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchVehicles(in page: Int) {
        client.vehicles(for: page) { [weak self] result in
            switch result {
            case .success(let response):
                for object in response.objects.arrayValue {
                    self?.objects.append(object)
                }
                self?.loadMoreVehicles(response.next)
            case .failure(let error):
                self?.presentAlertController(with: "Error", message: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchStarships(in page: Int) {
        client.starships(for: page) { [weak self] result in
            switch result {
            case .success(let response):
                for object in response.objects.arrayValue {
                    self?.objects.append(object)
                }
                self?.loadMoreStarships(response.next)
            case .failure(let error):
                self?.presentAlertController(with: "Error", message: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
    
    func loadMoreCharacters(_ next: Int?) {
        switch next {
        case .none:
            let characters = self.objects.compactMap({ SWCharacter(json: $0) })
            let tuple = (1, characters)
            activityIndicatorController.remove()
            self.performSegue(withIdentifier: "showDetail", sender: tuple)
        case .some:
            fetchCharacters(in: next!)
            
        }
    }
    
    func loadMoreVehicles(_ next: Int?) {
        switch next {
        case .none:
            let vehicles = self.objects.compactMap({ SWVehicle(json: $0) })
            let tuple = (2, vehicles)
            activityIndicatorController.remove()
            self.performSegue(withIdentifier: "showDetail", sender: tuple)
        case .some:
            fetchVehicles(in: next!)
        }
    }
    
    func loadMoreStarships(_ next: Int?) {
        switch next {
        case .none:
            let starships = self.objects.compactMap({ SWStarship(json: $0) })
            let tuple = (3, starships)
            activityIndicatorController.remove()
            self.performSegue(withIdentifier: "showDetail", sender: tuple)
        case .some:
            fetchStarships(in: next!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let controller = segue.destination as? SWDetailController, let tuple = sender as? (Int, [Any]) else { return }
            
            switch tuple.0 {
            case 1:
                controller.type = SWType.character(data: tuple.1 as! [SWCharacter])
            case 2:
                controller.type = SWType.vehicle(data: tuple.1 as! [SWVehicle])
            case 3:
                controller.type = SWType.starship(data: tuple.1 as! [SWStarship])
            default:
                break
            }
        }
    }
    
    
    @IBAction func peopleButtonTapped(_ sender: UIButton) {
        self.add(activityIndicatorController)
        fetchCharacters(in: 1)
    }

    @IBAction func vehiclesButtonTapped(_ sender: UIButton) {
        self.add(activityIndicatorController)
        fetchVehicles(in: 1)
    }
    
    @IBAction func starshipButtonTapped(_ sender: UIButton) {
        self.add(activityIndicatorController)
        fetchStarships(in: 1)
    }
}

