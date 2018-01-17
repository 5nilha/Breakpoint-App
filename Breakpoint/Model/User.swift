//
//  User.swift
//  Breakpoint
//
//  Created by Fabio Quintanilha on 1/16/18.
//  Copyright © 2018 FabioQuint. All rights reserved.
//

import UIKit

struct User {
    
    var userID: String!
    var email: String!
    var provider: String!
    var profileImage: UIImage?
    
    static var currentUser : User?
    
}
