//
//  AuthService.swift
//  Breakpoint
//
//  Created by Fabio Quintanilha on 1/16/18.
//  Copyright © 2018 FabioQuint. All rights reserved.
//

import Foundation
import Firebase

class AuthService{
    
    static let instance = AuthService()
    
    func registerUser(with email: String, andPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                userCreationComplete(false, error)
                return
            }
            
            if let user = user {
                // provider is the sign in provider, and provider ID can be email, facebook, Google+, etc.
                
                let userData = ["provider" : user.providerID,
                                "email" : user.email]
                
                Dataservice.instance.createDBUser(uid: user.uid, userData: userData)
                userCreationComplete(true, nil)
            }
        }
    }
    
    
    func loginUser(with email: String, andPassword password: String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (user , error) in
            if let error = error {
                print(error.localizedDescription)
                loginComplete(false, error)
                return
            }
            
            loginComplete(true, nil)
            print("The user was successful athenticated")
        }
        
    }
    
}
