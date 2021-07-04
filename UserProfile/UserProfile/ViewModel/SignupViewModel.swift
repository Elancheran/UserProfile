//
//  SignupViewModel.swift
//  UserProfile
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class SignUpViewModel {
    
    let nameSubject = PublishRelay<String?>()
    let emailSubject = PublishRelay<String?>()
    let gender = PublishRelay<Gender>()
    let phoneSubject = PublishRelay<String?>()
    let dateOfbirthSubject = PublishRelay<String?>()
    
    var isNameValid: Observable<Bool> {
        self.nameSubject.asObservable()
            .map { Validations.validateName($0 ?? "")}
    }
    
    var isEmailValid: Observable<Bool> {
        self.emailSubject.asObservable()
            .map { Validations.validateEmail($0 ?? "")}
    }
    
    var isDOBValid: Observable<Bool> {
        self.dateOfbirthSubject.asObservable()
            .map { Validations.validateDob($0?.getAsDate() ?? Date())}
    }
    
    var isPhoneValid: Observable<Bool> {
        self.phoneSubject.asObservable()
            .map { Validations.validatePhone($0 ?? "")}
    }
        
    var isValidForm: Observable<Bool> {

        return Observable.combineLatest(isNameValid, isEmailValid, isPhoneValid, isDOBValid) { name, email, dob, phone in

            return name && email && dob && phone
        }
    }
    
    func isAlreadyRegisterUser() -> Bool {
        do {
            let realm = try Realm()
            if realm.objects(Profile.self).count > 0 {
                return true
            }
            return false
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}
