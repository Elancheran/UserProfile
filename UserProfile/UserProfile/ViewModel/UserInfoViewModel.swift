//
//  UserInfoViewModel.swift
//  UserLogin
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class UserInfoViewModel {
    
    private var userProfile: Profile?
    
    var isDataReady: Observable<Void> {
        return isDataReadySubject.asObservable()
    }
    private var isDataReadySubject = PublishSubject<Void>()
    
    var userName: String? {
        return userProfile?.name
    }
    
    var email: String? {
        return userProfile?.email
    }
    
    var dob: String? {
        return userProfile?.dob
    }
    
    var gender: String? {
        return userProfile?.gender
    }
    
    var phone: String? {
        return userProfile?.phone
    }
    
    var picture: UIImage {
        return UIImage(data: userProfile?.picture ?? Data()) ?? UIImage()
    }
    
    
    func getUserInfo() {
        do {
            let realm = try Realm()
            let profiles = realm.objects(Profile.self)
            userProfile = profiles.last
            isDataReadySubject.onNext(())
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func signOut() {
        LocalStorageHelper.removeProfile(name: userName)
    }
    
}
