//
//  UIViewController+Extensions.swift
//  The API Awakens
//
//  Created by Muhammad Moaz on 4/5/18.
//  Copyright © 2018 Muhammad Moaz. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
    
    func presentAlertController(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.view.tintColor = Theme.primaryColor
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
