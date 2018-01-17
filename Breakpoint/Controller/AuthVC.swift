//
//  AuthVC.swift
//  Breakpoint
//
//  Created by Fabio Quintanilha on 1/16/18.
//  Copyright © 2018 FabioQuint. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func byEmailButtonTapped(_ sender: UIButton) {
        
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func googleSignInButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func facebookSigninButtonTapped(_ sender: UIButton) {
        
    }

}
