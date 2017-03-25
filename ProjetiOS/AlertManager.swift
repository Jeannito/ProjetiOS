//
//  AlertManager.swift
//  ProjetiOS
//
//  Created by Erick Taru on 25/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import Foundation
import UIKit

class AlertManager {
    
    class func alert(view: UIViewController, WithTitle title: String, andMsg msg: String = "") {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(cancelAction)
        view.present(alert, animated: true)
    }
    
    /// When an error is caught
    ///
    /// - Parameter error: NSError caught
    class func alert(view: UIViewController, error: NSError) {
        self.alert(view: view, WithTitle: "\(error)", andMsg: "\(error.userInfo)")
    }
    
    
}
