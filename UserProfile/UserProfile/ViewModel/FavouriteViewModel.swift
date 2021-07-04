//
//  FavouriteViewModel.swift
//  UserLogin
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import Foundation
import RxSwift
import RealmSwift

class FavouriteViewModel {
    
    var userProfiles: Observable<[UserProfileCellViewModel]> {
        return userProfileSubject.asObservable()
    }
    private var userProfileSubject = PublishSubject<[UserProfileCellViewModel]>()
    
    func getFavouriteUser() {
        do {
            let realm = try Realm()
            let profiles = realm.objects(FavouriteUser.self)
            
            var userProfileModel = [UserProfileCellViewModel]()
            for profile in profiles
            {
                userProfileModel.append(UserProfileCellViewModel(userDetail: profile.asUserDetails))
            }
            userProfileSubject.onNext(userProfileModel)
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
