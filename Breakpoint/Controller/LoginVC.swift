//
//  LoginVC.swift
//  Breakpoint
//
//  Created by Fabio Quintanilha on 1/16/18.
//  Copyright © 2018 FabioQuint. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: InsetTextField!
    @IBOutlet weak var passwordField: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.delegate = self
        passwordField.delegate = self
    }

    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        guard let email = emailField.text, email != "" else { return }
        guard let password = passwordField.text, email != "" else { return }
        
        //The the user try to login to an account
        AuthService.instance.loginUser(with: email, andPassword: password) { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                
                return
            } else {
                print(String(describing: error?.localizedDescription))
            }
        }
        
        // if the user does not exist, it will try to create an User
        AuthService.instance.registerUser(with: email, andPassword: password, userCreationComplete: { (success, registrationError) in
            
            if success {
                self.dismiss(animated: true, completion: nil)
                
                return
            }
            else {
                print(String(describing: registrationError?.localizedDescription))
            }
        })
    }
    
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

extension LoginVC: UITextFieldDelegate {
    
}
