//
//  Session.swift
//  ProjetiOS
//
//  Created by Jean BRUTE-DE-REMUR on 08/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import Foundation

//One of the most important class!
//That's for keep the user and his information "connected"
public class Session{
    
    //Declare some variables
    var login : String? = nil
    var status : String? = nil

    //Initialization of the Session
    private init(login : String, status : String) {
        self.login = login
        self.status = status
    }
    
    //That's th instance to use fonction and shared variables
    public static let sharedInstance = Session(login: "null", status: "null")
    
    //Setter of the class
    //Set the login variable of the session
    func setLogin(login : String){
        self.login = login
    }
    
    //Set the status variable of the session
    public func setStatus(status : String){
        self.status = status
    }
    
    //Getter of the class
    //Get the login of user currently connected
    public func getLogin()-> String?{
        return self.login
    }
    
    //Get the status of user currently connected
    public func getStatus()-> String?{
        return self.status
    }
    
    //This function is for close the session
    public func endSession(){
        self.login = nil
        self.status = nil
    }
    
}
