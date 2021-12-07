//
//  PersonlPageInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import CoreData

struct PersonalPageInfo{
    @SetStorage(key: "AHUID", default: "") private var userID: String
    @SetStorage(key: "AHUPassword", default: "") private var userPassWD: String
    @SetStorage(key: "AHUName", default: "") private var userName: String
    var user: User{
        get {
            User(studentID: userID, userName: userName, password: userPassWD)
        }
        set {
            userID = newValue.studentID
            userName = newValue.userName
            userPassWD = newValue.password
        }
    }
    
    mutating func cleanUser(){
        user = User(studentID: "", userName: "", password: "")
    }
    
    var loggedUsers: [User] = []
}

struct User{
    var studentID: String
    var userName: String
    var password: String
}
