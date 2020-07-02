//
//  Constants.swift
//  ChatApp
//
//  Created by Saranya Kalyanasundaram on 7/1/20.
//  Copyright © 2020 Saranya. All rights reserved.
//

struct C{
    
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let appName = "ChatApp💬"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageTableViewCell"
    
    struct BrandColors {
        static let purple = "PurpleBlue"
        static let lightPurple = "LightPurpleBlue"
        static let blue = "OceanBlue"
        static let lighBlue = "LightOceanBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
