//
//  ValidationsTests.swift
//  UserProfileTests
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import XCTest
import Foundation

@testable import UserProfile

class ValidationsTests: XCTestCase {

    var stringWith41Characters: String!
    var stringWith40Characters: String!
    
    override func setUp() {
        let arr1 = Array(0...39)
        let arr2 = Array(0...41)
        
        let temp1 = arr1.map { (_) -> String in
            return "a"
            }.joined()
        stringWith40Characters = temp1
        
        let temp2 = arr2.map { (_) -> String in
            return "a"
            }.joined()
        stringWith41Characters = temp2
    }
    
    // Name validations
    func testValidatingCorrectName() {
        XCTAssertTrue(Validations.validateName("John"))
    }
    
    func testValidatingNameForMaximumCharacterLimit() {
        XCTAssertTrue(Validations.validateName(stringWith40Characters))
    }
    
    func testValidatingEmptyName() {
        XCTAssertFalse(Validations.validateName(""))
    }
    
    func testValidatingIncorrectNameExceeding100Characters() {
        XCTAssertFalse(Validations.validateName(stringWith41Characters))
    }
    
    // Email validations
    func testValidatingCorrectEmail1() {
        XCTAssertTrue(Validations.validateEmail("johndoe@gmail.com"))
    }
    
    func testValidatingCorrectEmail2() {
        XCTAssertTrue(Validations.validateEmail("johndoe123@gmail.com"))
    }
    
    func testValidatingEmptyEmail() {
        XCTAssertFalse(Validations.validateEmail(".com"))
    }
    
    func testValidatingIncorrectEmail1() {
        XCTAssertFalse(Validations.validateEmail("johndoegmail.com"))
    }
    
    func testValidatingIncorrectEmail2() {
        XCTAssertFalse(Validations.validateEmail("johndoe@gmail"))
    }
    
    func testValidatingIncorrectEmail3() {
        XCTAssertFalse(Validations.validateEmail("johndoe"))
    }
    
    // Phone validation
    func testValidatingCorrectPhoneNumber() {
        XCTAssertTrue(Validations.validatePhone("2345678901"))
    }
    
    func testValidatingPhoneNumberWithIncorrectAreaCode() {
        XCTAssertFalse(Validations.validatePhone("123456780"))
    }
    
    func testValidatingAlphaNumericPhoneNumber() {
        XCTAssertFalse(Validations.validatePhone("asbd123456"))
    }
    
    
    func testValidatingEmptyPhoneNumber() {
        XCTAssertFalse(Validations.validatePhone(""))
    }
    
    func testValidateDOB() {
        XCTAssertTrue(Validations.validateDob("11/11/2020".getAsDate()))
        
        XCTAssertFalse(Validations.validateDob("01/10/2022".getAsDate()))
        
        XCTAssertFalse(Validations.validateDob(Date()))
    }

}
