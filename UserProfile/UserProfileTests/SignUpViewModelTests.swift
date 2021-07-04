//
//  SignUpViewModelTests.swift
//  UserProfileTests
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import UserProfile

class SignUpViewModelTests: XCTestCase {
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var viewModel: SignUpViewModel!

    override func setUpWithError() throws {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        viewModel = SignUpViewModel()
    }

    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNameValidation() throws {
        let isNameValid = scheduler.createObserver(Bool.self)
        
        viewModel.isNameValid
            .bind(to: isNameValid)
            .disposed(by: disposeBag)
        
        scheduler
            .createColdObservable([
                .next(10, ""),
                .next(20, "J"),
                .next(30, "John Doe"),
                .next(40, "Jo'hn-Doe"),
                .next(50, "143")
            ])
            .bind(to: viewModel.nameSubject)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(isNameValid.events, [
            .next(10, false),
            .next(20, true),
            .next(30, true),
            .next(40, true),
            .next(50, false),
        ])
    }
    
    func testEmailValidation() throws {
        let isEmailValid = scheduler.createObserver(Bool.self)
        
        viewModel.isEmailValid
            .bind(to: isEmailValid)
            .disposed(by: disposeBag)
        
        scheduler
            .createColdObservable([
                .next(10, ""),
                .next(20, "J"),
                .next(30, "John.com"),
                .next(40, "Jo@.com"),
                .next(50, "john@gmail.com")
            ])
            .bind(to: viewModel.emailSubject)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(isEmailValid.events, [
            .next(10, false),
            .next(20, false),
            .next(30, false),
            .next(40, false),
            .next(50, true),
        ])
    }
    
    func testPhoneValidation() throws {
        let isPhoneValid = scheduler.createObserver(Bool.self)
        
        viewModel.isPhoneValid
            .bind(to: isPhoneValid)
            .disposed(by: disposeBag)
        
        scheduler
            .createColdObservable([
                .next(10, ""),
                .next(20, "9876"),
                .next(30, "9876432"),
                .next(40, "0987654"),
                .next(50, "9876543210")
            ])
            .bind(to: viewModel.phoneSubject)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(isPhoneValid.events, [
            .next(10, false),
            .next(20, false),
            .next(30, false),
            .next(40, false),
            .next(50, true),
        ])
    }
    
    func testDOBValidation() throws {
        let isDOBValid = scheduler.createObserver(Bool.self)
        
        viewModel.isDOBValid
            .bind(to: isDOBValid)
            .disposed(by: disposeBag)
        
        scheduler
            .createColdObservable([
                .next(10, "01/01/1990"),
                .next(20, "10/21/2022"),
                .next(30, "10/01/2020"),
                .next(40, "06/04/2021")
            ])
            .bind(to: viewModel.dateOfbirthSubject)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(isDOBValid.events, [
            .next(10, true),
            .next(20, false),
            .next(30, true),
            .next(40, true)
        ])
    }


}
