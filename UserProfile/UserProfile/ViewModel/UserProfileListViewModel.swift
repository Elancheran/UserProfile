//
//  UserProfileViewModel.swift
//  UserLogin
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import Foundation
import RxCocoa
import RxSwift

class UserProfileListViewModel {
    
    var userProfiles: Observable<[UserProfileCellViewModel]> {
        return userProfileSubject.asObservable()
    }
    private var userService: UserServiceType
    private var userProfileSubject = PublishSubject<[UserProfileCellViewModel]>()
    private var userDetails = [UserDetail]()
    private var disposeBag = DisposeBag()
    
    init(service: UserServiceType = UserService()) {
        userService = service
    }
    
    func fetchUserDetails() {
        userService.fetchUserDetails()
            .subscribe(onNext: { [weak self] users in
                self?.userDetails = users
                self?.publishUsers(for: .male)
            })
            .disposed(by: disposeBag)
    }
    
    func publishUsers(for gender: Gender) {
        let userProfile = userDetails.filter { $0.gender == gender }
            .map { UserProfileCellViewModel(userDetail: $0) }
        userProfileSubject.onNext(userProfile)
    }
}
