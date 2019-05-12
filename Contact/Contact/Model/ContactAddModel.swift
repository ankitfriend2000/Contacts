
//
//  ContactAddModel.swift
//  Contact
//
//  Created by Ankit Kedia on 12/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import Foundation

struct ContactAddModel : Codable {
    let firstName, lastName, email, phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case phoneNumber = "phone_number"
    }
}
