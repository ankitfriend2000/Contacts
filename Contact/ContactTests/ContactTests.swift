//
//  ContactTests.swift
//  ContactTests
//
//  Created by Ankit Kedia on 10/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import XCTest
@testable import Contact

class ContactTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testContactViewModel() {
        let contact = ContactModel(id: 1, firstName: "Ankit", lastName: "Kedia", profilePic: "abc.jpg", favorite: false, url: "https://gojek-contacts-app.herokuapp.com/contacts/1.json")
        let contactViewModel = ContactViewModel(contact: contact)
        XCTAssertEqual(contact.url, contactViewModel.contactUrl)
        XCTAssertEqual(contact.id, contactViewModel.contactID)
        XCTAssertEqual(contact.profilePic, contactViewModel.imageUrl)
        XCTAssertEqual(contact.favorite, contactViewModel.isFavourite)
        XCTAssertEqual(contact.firstName+" "+contact.lastName, contactViewModel.fullname)
    }

}
