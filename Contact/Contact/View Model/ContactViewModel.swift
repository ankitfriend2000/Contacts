//
//  ContactViewModel.swift
//  Contact
//
//  Created by Ankit Kedia on 10/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import Foundation

struct ContactViewModel {
    
    var fullname : String
    var imageUrl : String
    var isFavourite : Bool
    var detailUrl : String
    
    init(contact: ContactModel) {
        fullname = contact.firstName + " " + contact.lastName
        fullname = fullname.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).capitalized
        imageUrl = contact.profilePic
        isFavourite = contact.favorite
        detailUrl = contact.url
    }
    
}


