//
//  Validations.swift
//  UserProfile
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import Foundation

struct Validations {
    
    static func validateName(_ name: String) -> Bool {
        let validName = NSPredicate(format: "SELF MATCHES %@", "^[A-Za-z-’' ]+")
        return validName.evaluate(with: name) && name.count <= 40
    }
    
    static func validateEmail(_ email: String) -> Bool {
        let emailRegex = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$"
        let validEmail = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return validEmail.evaluate(with: email)
    }
    
    static func validatePhone(_ phone: String) -> Bool {
        guard phone.count == 10, CharacterSet(charactersIn: phone).isSubset(of: CharacterSet.decimalDigits) else {
            return false
        }
        return true
    }
    
    static func validateDob(_ dob: Date) -> Bool {
        guard dob < Date() else {
            return false
        }
        return true
    }
}

