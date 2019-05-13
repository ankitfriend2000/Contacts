//
//  ContactDetailTests.swift
//  ContactTests
//
//  Created by Ankit Kedia on 13/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import XCTest
@testable import Contact

class ContactDetailTests: XCTestCase {
    var contactDetailModel : ContactDetailModel!
    var contactDetailViewModel : ContactDetailViewModel!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        contactDetailModel = ContactDetailModel(id: 2, firstName: "Ankit", lastName: "sdd", email: "acc@sd.com", phoneNumber: "979793929", profilePic: "basb.jps", favorite: false, createdAt: "2019-02-23T10:06:37.495Z", updatedAt: "2019-05-07T08:48:49.761Z")
        contactDetailViewModel = ContactDetailViewModel.init(contactDetail: contactDetailModel)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testContactDetailViewModel() {
        XCTAssertEqual(contactDetailViewModel.contactID, contactDetailModel.id)
        XCTAssertEqual(contactDetailViewModel.firstName, contactDetailModel.firstName)
        XCTAssertEqual(contactDetailViewModel.lastName, contactDetailModel.lastName)
        XCTAssertEqual(contactDetailViewModel.emailAddress, contactDetailModel.email)
        XCTAssertEqual(contactDetailViewModel.phoneNumber, contactDetailModel.phoneNumber)
        XCTAssertEqual(contactDetailViewModel.profilePic, contactDetailModel.profilePic)
    }
    
    func testContactDetailAfterEmailEditing() {
        contactDetailViewModel.emailAddress = "aaaaa@aa.com"
        let changedModel = contactDetailViewModel.getUpdatedViewModel()
        XCTAssertEqual(changedModel.email, contactDetailViewModel.emailAddress)
    }
    
    func testContactDetailAfterFirstNameEditing() {
        contactDetailViewModel.firstName = "anks"
        let changedModel = contactDetailViewModel.getUpdatedViewModel()
        XCTAssertEqual(changedModel.firstName, contactDetailViewModel.firstName)
    }
    
    func testContactDetailAfterLastNameEditing() {
        contactDetailViewModel.lastName = "kedia"
        let changedModel = contactDetailViewModel.getUpdatedViewModel()
        XCTAssertEqual(changedModel.lastName, contactDetailViewModel.lastName)
    }
    
    func testContactDetailAfterPhoneEditing() {
        contactDetailViewModel.phoneNumber = "992929999"
        let changedModel = contactDetailViewModel.getUpdatedViewModel()
        XCTAssertEqual(changedModel.phoneNumber, contactDetailViewModel.phoneNumber)
    }
}
