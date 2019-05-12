//
//  ContactDetailViewModel.swift
//  Contact
//
//  Created by Ankit Kedia on 11/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import Foundation

struct ContactDetailDataSourceModel {
    let title : String
    let description : String
}

enum ContactDetailType : String {
    case firstname = "First Name"
    case lastname = "Last Name"
    case email
    case phone = "mobile"
}

struct ContactAddUpdateDataSourceModel {
    let infoType : ContactDetailType
    let value : String
}

struct ContactDetailViewModel {
    
    var phoneNumber : String
    var emailAddress : String
    var firstName : String
    var lastName : String
    
    var profilePic : String
    private var contactDetailModel : ContactDetailModel
    var contactDetailDataSource = [ContactDetailDataSourceModel]()
    var dataSource = [ContactAddUpdateDataSourceModel]()
    
    init(contactDetail : ContactDetailModel) {
        self.contactDetailModel = contactDetail
        contactDetailDataSource.append(ContactDetailDataSourceModel.init(title: "mobile", description: contactDetail.phoneNumber))
        contactDetailDataSource.append(ContactDetailDataSourceModel.init(title: "email", description: contactDetail.email))
        phoneNumber = contactDetail.phoneNumber
        emailAddress = contactDetail.email
        profilePic = contactDetail.profilePic
        firstName = contactDetail.firstName
        lastName = contactDetail.lastName
        createDatASoucrceForAddUpdate()
    }
    
    private mutating func createDatASoucrceForAddUpdate(){
        var dataSource = [ContactAddUpdateDataSourceModel]()
        dataSource.append(ContactAddUpdateDataSourceModel(infoType: .firstname, value: firstName))
        dataSource.append(ContactAddUpdateDataSourceModel(infoType: .lastname, value: lastName))
        dataSource.append(ContactAddUpdateDataSourceModel(infoType: .phone, value: phoneNumber))
        dataSource.append(ContactAddUpdateDataSourceModel(infoType: .email, value: emailAddress))
        self.dataSource = dataSource
    }
    
}
