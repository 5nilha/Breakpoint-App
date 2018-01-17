//
//  CreatePostVC.swift
//  Breakpoint
//
//  Created by Fabio Quintanilha on 1/16/18.
//  Copyright © 2018 FabioQuint. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendButton.bindToKeyboard() //Moves the button up when the keyboard is called
        textView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentUser = User.currentUser {
            self.emailLabel.text = currentUser.email
        }
    }
    

    @IBAction func sendButtonPressed(_ sender: UIButton) {
        
        guard let textView = textView.text, textView != "", textView != "Say something here ..."
            else {
                sendButton.isEnabled = false
                return
            }
        
        let userID = User.currentUser?.userID // get the current user ID to pass to the message post
        
        Dataservice.instance.uploadPost(withMessage: textView, forUID: userID!, withGroupKey: nil) { (isComplete) in
            
            if isComplete {
                self.sendButton.isEnabled = true
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print("There was an error!")
            }
        }
        
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

extension CreatePostVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
}
