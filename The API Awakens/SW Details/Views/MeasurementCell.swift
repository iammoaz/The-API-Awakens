//
//  MeasurementCell.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 2/16/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import UIKit

enum ConversionType {
    case length
    case height
}

class MeasurementCell: UITableViewCell {
    
    static var reuseIdentifier: String = String(describing: MeasurementCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var englishUnitButton: UIButton!
    @IBOutlet weak var metricUnitButton: UIButton!

    private (set) var measurement: Measurement<UnitLength>?
    private (set) var conversionType: ConversionType = .length

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with entity: SWEntity, type: ConversionType) {
        self.titleLabel.text = entity.title
        
        switch type {
        case .length:
            let length = Measurement(value: entity.value as! Double, unit: UnitLength.meters)
            self.measurement = length
            
        case .height:
            let height = Measurement(value: entity.value as! Double, unit: UnitLength.centimeters)
            self.measurement = height
            
        }
        
        self.valueLabel.text = measurement!.description
        self.englishUnitButton.toggleDisable(self.metricUnitButton)
    }
    
    @IBAction func convertToEnglishUnit(_ sender: UIButton) {
        guard let measurement = self.measurement else { return }
        self.valueLabel.text = measurement.description
        sender.toggleDisable(metricUnitButton)
    }
    
    @IBAction func convertToMetricUnit(_ sender: UIButton) {
        guard let measurement = self.measurement else { return }
        let convertedHeight = measurement.converted(to: UnitLength.feet)
        self.valueLabel.text = "\((convertedHeight.value * 100).rounded() / 100) ft"
        sender.toggleDisable(englishUnitButton)
    }
}
