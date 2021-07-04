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
    
    let nameSubject = BehaviorRelay<String?>(value: "")
    let emailSubject = BehaviorRelay<String?>(value: "")
    let gender = BehaviorRelay<Gender>(value: .male)
    let phoneSubject = BehaviorRelay<String?>(value: "")
    let dateOfbirthSubject = BehaviorRelay<String?>(value: "")
    
    
    var isValidForm: Observable<Bool> {

        return Observable.combineLatest(nameSubject, emailSubject, dateOfbirthSubject, phoneSubject) { name, email, dob, phone in
            
            guard let name = name, let email = email, let dob = dob, let phone = phone else { return false }

            return Validations.validateName(name) && Validations.validateEmail(email) && Validations.validateDob(dob.getAsDate()) && Validations.validatePhone(phone)
        }
    }
}
