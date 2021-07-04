//
//  UserDetailServiceTests.swift
//  UserProfileTests
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import XCTest
import RxSwift
import RxTest

@testable import UserProfile

class UserProfileCellViewModelTests: XCTestCase {
    
    var viewModel: UserProfileCellViewModel!

    override func setUpWithError() throws {
        var user = UserDetail()
        user.name = "User 1"
        user.age = 24
        user.email = "sample@gmail.com"
        user.gender = .female
        user.phone = "9876543210"
        user.picture = "http://sample1.com/200/300/people?43"
        
        viewModel = UserProfileCellViewModel(userDetail: user)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProperties() throws {
        XCTAssertEqual(viewModel.userName, "User 1")
        XCTAssertEqual(viewModel.age, "24")
        XCTAssertEqual(viewModel.email, "sample@gmail.com")
        XCTAssertEqual(viewModel.gender, .female)
        XCTAssertEqual(viewModel.phone, "9876543210")
        XCTAssertEqual(viewModel.picture, URL(string: "http://sample1.com/200/300/people?43"))
    }


}
