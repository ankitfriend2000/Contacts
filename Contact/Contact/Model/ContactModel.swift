//
//  ContactModel.swift
//  Contact
//
//  Created by Ankit Kedia on 10/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import Foundation

typealias ContactArray = [ContactModel]

struct ContactModel: Codable {
    let id: Int
    let firstName, lastName: String
    let profilePic: String
    let favorite: Bool
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case favorite, url
    }
}
