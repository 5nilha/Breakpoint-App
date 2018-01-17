//
//  FirstViewController.swift
//  Breakpoint
//
//  Created by Fabio Quintanilha on 1/15/18.
//  Copyright © 2018 FabioQuint. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //gets the Current User Information
        Dataservice.instance.getCurrentUser { (user) in
            User.currentUser = user
        }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Dataservice.instance.getFeedMessages { (returnedMessages) in
            
            self.messages = returnedMessages.reversed()  // takes the returnes array, reverses the order to show in decrescent order and pass to messages array
            self.tableView.reloadData()
        }
    }

}



extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        
        let image = UIImage(named: "defaultProfileImage")
        let message = messages[indexPath.row]
        
//
//        //gets the user email to pass on the messages
        Dataservice.instance.getUserEmail(forUID: message.sender_id) { (returnedEmail) in
            let email = returnedEmail
            cell.configCell(profileImage: image!, email: email, content: message.content)
        }
        
        
        return cell
    }
}
