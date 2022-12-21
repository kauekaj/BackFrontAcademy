//
//  MessageAllModel.swift
//  WhatsMessageBF
//
//  Created by Kaue de Assis Jacyntho on 15/12/22.
//

import Foundation

class Message {
    var text: String?
    var userID: String?
    
    init(dictionary: [String : Any]) {
        self.text = dictionary["text"] as? String
        self.userID = dictionary["IDUser"] as? String
    }
}

class Conversation {
    var userName: String?
    var lastMessage: String?
    var recipientID: String?
    
    init(dictionary: [String : Any]) {
        self.userName = dictionary["userName"] as? String
        self.lastMessage = dictionary["lastMessage"] as? String
        self.recipientID = dictionary["recipientID"] as? String
    }
}

class User {
    var name: String?
    var email: String?
    
    init(dictionary: [String : Any]) {
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
    }
}

class Contact {
    var id: String?
    var name: String?
    var email: String?
    
    init(dictionary: [String : Any]?) {
        self.id = dictionary?["id"] as? String
        self.name = dictionary?["name"] as? String
        self.email = dictionary?["email"] as? String

    }
    
    convenience init(id: String?, name: String?) {
        self.init(dictionary: nil)
        self.id = id
        self.name = name
    }
}
