//
//  ConversionCell.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 4/5/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import UIKit

class ConversionCell: UITableViewCell, UITextFieldDelegate {
    
    static var reuseIdentifier: String = String(describing: ConversionCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var creditButton: UIButton!
    @IBOutlet weak var usdButton: UIButton!
    @IBOutlet weak var conversionRateField: UITextField!
    
    weak var parentController: SWDetailController?
    
    private lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneButton))
        return button
    }()
    
    private (set) var credits: Double = 0
    private (set) var conversionRate: Double?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        conversionRateField.delegate = self
        setupToolBar()
    }
    
    func setupToolBar() {
        let toolBar = UIToolbar()
        toolBar.items = [doneButton]
        toolBar.sizeToFit()
        conversionRateField.inputAccessoryView = toolBar
    }
    
    func configure(with entity: SWEntity) {
        self.titleLabel.text = entity.title
        let credits = entity.value as! Double
        self.credits = credits
        
        if credits == 0 {
            self.valueLabel.text = "-"
            self.conversionRateField.isEnabled = false
            self.creditButton.isEnabled = false
            self.usdButton.isEnabled = false
        } else {
            self.valueLabel.text = "\(credits) GC"
            self.conversionRateField.isEnabled = true
            self.creditButton.toggleDisable(self.usdButton)
        }
    }
    
    @objc func handleDoneButton() {
        conversionRateField.resignFirstResponder()
    }
    
    @IBAction func conversionValueChanged(_ sender: UITextField) {
        guard let conversionRate = sender.text, conversionRate.count > 0 else {
            usdButton.isEnabled = false
            return
        }
        
        self.conversionRate = Double(conversionRate)
        usdButton.isEnabled = true
    }
    
    @IBAction func convertToCredit(_ sender: UIButton) {
        self.valueLabel.text = "\(credits) GC"
        sender.toggleDisable(usdButton)
    }
    
    @IBAction func convertToUSD(_ sender: UIButton) {
        guard let conversionRate = conversionRate else {
            self.conversionRateField.becomeFirstResponder()
            parentController?.presentAlertController(with: "Error", message: "Conversion rate should be a greater than 0")
            return
        }
        
        if conversionRate == 0 || conversionRate < 0 {
            parentController?.presentAlertController(with: "Error", message: "Conversion rate should be a greater than 0")
            
        } else {
            let usdValue = conversionRate * credits
            self.valueLabel.text = "\(usdValue) $"
            sender.toggleDisable(creditButton)
        }
    }
}
