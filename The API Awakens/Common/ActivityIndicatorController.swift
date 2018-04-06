//
//  ActivityIndicatorController.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 4/5/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import UIKit

class ActivityIndicatorController: UIViewController {
    
    private lazy var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.layer.backgroundColor = Theme.primaryColor.cgColor
        view.layer.opacity = 0.8
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
