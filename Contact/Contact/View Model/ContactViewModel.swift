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
    var imageUrl : String?
    var isFavourite : Bool
    var detailUrl : String
    var favouriteImageUrl : String
    var contactUrl : String
    var contactID : Int
    
    init(contact: ContactModel) {
        fullname = contact.firstName + " " + contact.lastName
        fullname = fullname.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).capitalized
        if !contact.profilePic.contains("images/missing.png") {
            imageUrl = contact.profilePic
        }
        isFavourite = contact.favorite
        detailUrl = contact.url
        if isFavourite {
            favouriteImageUrl = "favourite_button_selected"
        } else {
            favouriteImageUrl = "favourite_button"
        }
        contactUrl = contact.url
        contactID = contact.id
    }
    
}


