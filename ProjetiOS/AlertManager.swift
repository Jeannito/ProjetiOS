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
    
    //class that defines the model for the alerts
    class func alert(view: UIViewController, WithTitle title: String, andMsg msg: String = "") {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(ok)
        view.present(alert, animated: true)
    }
    
}
