//
//  RealmObjects.swift
//  UserProfile
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import Foundation
import RealmSwift

class Profile: Object {
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var phone = ""
    @objc dynamic var gender = ""
    @objc dynamic var dob = ""
    @objc dynamic var picture = Data()
    
    override static func primaryKey() -> String? {
        return "name"
    }
}

class FavouriteUser: Object {
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var phone = ""
    @objc dynamic var gender = ""
    @objc dynamic var age = 0
    @objc dynamic var picture = ""
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    var asUserDetails: UserDetail {
        var user = UserDetail()
        user.name = self.name
        user.email = self.email
        user.phone = self.phone
        user.age = self.age
        user.picture = self.picture
        user.gender = Gender(rawValue: self.gender) ?? .male
        return user
    }
}

