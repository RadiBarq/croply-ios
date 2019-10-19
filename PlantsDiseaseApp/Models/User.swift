//
//  User.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/16/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import Foundation

final class User: Codable {
     var id: Int
     var username: String
     var email: String
     var password: String?
    
    init (id: Int, username: String, email: String, password: String?) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password ?? nil
    }
}

class SessionUser: ObservableObject {
    @Published  var id: Int = -1
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var signedInClicked = true
    @Published var signedUpClicked = false
    
    init() {
        
        
    }
    
    init (id: Int, username: String, email: String, signedInClicked: Bool, signedUpClicked: Bool) {
        self.id = id
        self.username = username
        self.email = email
        self.signedUpClicked = signedUpClicked
        self.signedInClicked = signedInClicked
    }

}
