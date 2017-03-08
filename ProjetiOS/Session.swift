//
//  Session.swift
//  ProjetiOS
//
//  Created by Jean BRUTE-DE-REMUR on 08/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import Foundation

public class Session{
    

    var login : String? = nil
    var status : String? = nil

    private init(login : String, status : String) {
        self.login = login
        self.status = status
    }
}
