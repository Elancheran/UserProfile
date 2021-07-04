//
//  UserProfileCellViewModel.swift
//  UserLogin
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import Foundation
import RxSwift
import RealmSwift

class UserProfileCellViewModel {
    
    private var userProfile: UserDetail
    
    var userName: String {
        return userProfile.name
    }
    
    var email: String {
        return userProfile.email
    }
    
    var age: String {
        return userProfile.age.description
    }
    
    var gender: Gender {
        return userProfile.gender
    }
    
    var phone: String {
        return userProfile.phone
    }
    
    var picture: URL? {
        return URL(string: userProfile.picture)
    }
    
    
    init(userDetail: UserDetail) {
        userProfile = userDetail
    }
    
    func likeAction() {
        if isUserLiked() {
            LocalStorageHelper.deleteUser(name: userName)
        } else {
            self.addUser()
        }
    }
    
    func isUserLiked() -> Bool {
        do {
            let realm = try Realm()
            return realm.object(ofType: FavouriteUser.self, forPrimaryKey: userName) != nil
            
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    func addUser() {
        let user = FavouriteUser()
        user.name = self.userName
        user.email = self.email
        user.age = userProfile.age
        user.phone = self.phone
        user.picture = userProfile.picture
        user.gender = userProfile.gender.rawValue
        
        LocalStorageHelper.addUser(user: user)
    }
}
