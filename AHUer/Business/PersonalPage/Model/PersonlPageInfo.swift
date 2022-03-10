//
//  PersonlPageInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import SwiftUI

struct PersonalPageInfo{
    @AppStorage("AHUID", store: .standard) private var userID = ""
    @AppStorage("AHUPassword", store: .standard) private var userPassWD = ""
    @AppStorage("AHUName", store: .standard) private var userName = ""
    
    var name: String{
        return userName
    }
    
    func freshData(userID: String, userPassWD: String, userName: String){
        self.userID = userID
        self.userPassWD = userPassWD
        self.userName = userName
    }
    
    func cleanup(){
        self.userID = ""
        self.userPassWD = ""
        self.userName = ""
    }
}
