//
//  Dataservice.swift
//  Breakpoint
//
//  Created by Fabio Quintanilha on 1/15/18.
//  Copyright © 2018 FabioQuint. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class Dataservice {
    
    static let instance = Dataservice()
    
    private var _REF_BASE = DB_BASE
    private var users_collection = DB_BASE.child("users") // Creates a Collection of users
    private var groups_collection = DB_BASE.child("groups") // creates a Collection of groups
    private var feed_collection = DB_BASE.child("feed") //creates a Collection of feed
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return users_collection
    }
    
    var REF_GROUPS: DatabaseReference {
        return groups_collection
    }
    
    var REF_FEED: DatabaseReference {
        return feed_collection
    }
    
    func createDBUser(uid: String, userData: [String : Any]) {
        
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> () ){
        
        if let groupKey = groupKey {
            //If the message is to a group, Send to groups Reference
            

        } else {
            let messageDictionary = ["content" : message,
                                     "senderID" : uid]
            
            //generates a unique ID for each message
            REF_FEED.childByAutoId().updateChildValues(messageDictionary)
            sendComplete(true)
        }
    }
    
    
    
    func getFeedMessages(handler: @escaping (_ messages: [Message]) -> ()) {
        
        var messageArray = [Message]()
        
        REF_FEED.observeSingleEvent(of: .value) { (feedSnapshot) in
            
            guard let feedSnapshot = feedSnapshot.children.allObjects as? [DataSnapshot]
                else {
                    return
                }
            
            for message in feedSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderID").value as! String
                
                let message = Message(content: content, senderId: senderId)
                
                messageArray.append(message)
            }
            
            handler(messageArray)   
        }
    }
    
    
    func getUserEmail(forUID uid: String, handler: @escaping (_ email: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot]
                else {
                    return
                }
            
            for user in userSnapshot {
                if user.key  == uid {
                    let email = user.childSnapshot(forPath: "email").value as! String
                    
                    handler(email)
                }
            }
        }
    }
    
    
    
    // Fetch the current user data from Firebase
    func getCurrentUser(handler: @escaping (_ user: User) -> Void) {
      
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        REF_USERS.child(userID).observeSingleEvent(of: .value) { (snapshot) in
            if let userData = snapshot.value as? [String : Any] {
                let email = userData["email"] as! String
                let provider = userData["provider"] as! String
                
                let user = User(userID: userID, email: email, provider: provider, profileImage: nil)
                
                print("Printing: \(user)")
                handler(user)
            }
        }
        
    }
    
}
