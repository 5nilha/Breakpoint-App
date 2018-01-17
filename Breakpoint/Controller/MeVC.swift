//
//  MeVC.swift
//  Breakpoint
//
//  Created by Fabio Quintanilha on 1/16/18.
//  Copyright © 2018 FabioQuint. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentUser = User.currentUser {
            self.emailLabel.text = currentUser.email
        }
    }

    
    @IBAction func signoutButtonPressed(_ sender: UIButton) {
        
        let logoutPopup = UIAlertController(title: "Logout", message: "Are you sure you want to logout? ", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let logoutAction = UIAlertAction(title: "Confirm", style: .destructive) { (buttonTapped) in
            do {
                try Auth.auth().signOut()
                print("Logged out")
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.dismiss(animated: true, completion: nil)
                self.present(authVC!, animated: true, completion: nil)
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        logoutPopup.addAction(logoutAction)
        logoutPopup.addAction(cancelAction)
        present(logoutPopup, animated: true, completion: nil)
    }

}
