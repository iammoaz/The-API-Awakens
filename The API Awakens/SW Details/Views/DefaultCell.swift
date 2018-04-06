//
//  DefaultCell.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 2/8/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import UIKit

class DefaultCell: UITableViewCell {
    
    static var reuseIdentifier: String = String(describing: DefaultCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    private (set) var names: [String] = []
    
    weak var parentController: SWDetailController?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = Theme.primaryColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with entity: SWEntity) {
        self.titleLabel.text = entity.title
        self.valueLabel.text = (entity.value as! String).capitalized
    }
    
    func configureForWorld(with entity: SWEntity) {
        self.titleLabel.text = entity.title
        self.valueLabel.text = "-"
        
        let id = entity.value as! Int
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        accessoryView = indicator
        indicator.startAnimating()
        
        SWCient().planet(with: id) { [weak self] result in
            switch result {
            case .success(let planet):
                indicator.stopAnimating()
                self?.valueLabel.text = planet.name
            case .failure(let error):
                self?.parentController?.presentAlertController(with: "Error", message: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
    
    func configureForStarships(with entity: SWEntity) {
        self.names.removeAll()
        self.titleLabel.text = entity.title
        self.valueLabel.text = "-"
        
        guard let ids = entity.value as? [Int], !ids.isEmpty else { return }
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        accessoryView = indicator
        
        ids.forEach { id in
            indicator.startAnimating()
            
            SWCient().starship(for: id) { [weak self] result in
                switch result {
                case .success(let starship):
                    self?.names.append(starship.name)
                    self?.configureStarshipNames()
                case .failure(let error):
                    self?.parentController?.presentAlertController(with: "Error", message: error.localizedDescription)
                    print(error.localizedDescription)
                }
                indicator.stopAnimating()
            }
        }
    }
    
    func configureStarshipNames() {
        let string = names.joined(separator: ", ")
        self.valueLabel.text = string
    }
}
