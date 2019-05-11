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

struct ContactDetailViewModel {
    
    var phoneNumber : String
    var emailAddress : String
    
    var contactDetailDataSource = [ContactDetailDataSourceModel]()
    init(contactDetail : ContactDetailModel) {
        contactDetailDataSource.append(ContactDetailDataSourceModel.init(title: "mobile", description: contactDetail.phoneNumber))
        contactDetailDataSource.append(ContactDetailDataSourceModel.init(title: "email", description: contactDetail.email))
        phoneNumber = contactDetail.phoneNumber
        emailAddress = contactDetail.email
    }
}
