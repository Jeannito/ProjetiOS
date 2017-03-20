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
    
    public static let sharedInstance = Session(login: "null", status: "null")
    
    func setLogin(login : String){
        Session.sharedInstance.login = login
    }
    
    func setStatus(status : String){
        Session.sharedInstance.status = status
    }
    
    func getLogin()-> String?{
        return Session.sharedInstance.login
    }
    
    func getStatus()-> String?{
        return Session.sharedInstance.status
    }
    
    
}
