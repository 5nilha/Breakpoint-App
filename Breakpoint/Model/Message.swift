//
//  Message.swift
//  Breakpoint
//
//  Created by Fabio Quintanilha on 1/16/18.
//  Copyright © 2018 FabioQuint. All rights reserved.
//

import Foundation

struct Message {
    
    private var _content: String
    private var _senderId: String
    
    var content: String {
        return _content
    }
    
    var sender_id: String {
        return _senderId
    }
    
    init (content: String, senderId: String) {
        self._content = content
        self._senderId = senderId
    } 
    
}
