//
//  UserProfileViewModelTests.swift
//  UserProfileTests
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import UserProfile

class UserProfileViewModelTests: XCTestCase {
    
    private var userService: UserServiceMock!
    private var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        userService = UserServiceMock()
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchUser() throws {
        userService
            .userDetailsReturnValue = .just(getDummyUsers())
        
        let userCount = userService.fetchUserDetails()
            .map{ $0.count }
        
        XCTAssertEqual( try userCount.toBlocking().first(), 2)

    }
    
    func getDummyUsers() -> [UserDetail] {
        
        var user1 = UserDetail()
        user1.name = "User 1"
        user1.age = 24
        user1.email = "sample@gmail.com"
        user1.gender = .female
        user1.phone = "9876543210"
        user1.picture = "http://sample1.com/200/300/people?43"
        
        var user2 = UserDetail()
        user2.name = "User 2"
        user2.age = 28
        user2.email = "sampl1e@gmail.com"
        user2.gender = .male
        user2.phone = "9678956431"
        user2.picture = "http://sample1.com/200/300/people?41"
        
        return [user1, user2]
    }

}

class UserServiceMock: UserServiceType {
    var userDetailsReturnValue: Observable<[UserDetail]>!
    func fetchUserDetails() -> Observable<[UserDetail]> {
        return userDetailsReturnValue
    }
}

