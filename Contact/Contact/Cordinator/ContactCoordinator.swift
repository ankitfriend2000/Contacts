//
//  ConatctCoordinator.swift
//  Contact
//
//  Created by Ankit Kedia on 10/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import Foundation
import UIKit

class ContactCoordinator: Coordinator {
    private let presenter : UINavigationController
    private var contactViewController : ContactsTableViewController?
    
    init(presenter : UINavigationController) {
        self.presenter = presenter
        
    }
    
    func start() {
        let contactViewController = ContactsTableViewController.init(nibName: nil, bundle: nil)
        self.presenter.pushViewController(contactViewController, animated: true)
        self.contactViewController = contactViewController
    }
    
    
}
