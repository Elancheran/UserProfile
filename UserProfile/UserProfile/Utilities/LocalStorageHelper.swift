//
//  LocalStorageHelper.swift
//  UserProfile
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import Foundation
import RealmSwift

struct LocalStorageHelper {
    
    static func saveUser(profile: Profile) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(profile)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func removeProfile(name: String?) {
        do {
            let realm = try Realm()
            if let object = realm.object(ofType: Profile.self, forPrimaryKey: name) {
                try realm.write {
                    realm.delete(object)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func addUser(user: FavouriteUser) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(user)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func deleteUser(name: String?) {
        do {
            let realm = try Realm()
            if let object = realm.object(ofType: FavouriteUser.self, forPrimaryKey: name) {
                try realm.write {
                    realm.delete(object)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

