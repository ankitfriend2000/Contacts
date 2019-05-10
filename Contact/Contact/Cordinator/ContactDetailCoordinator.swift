//
//  ContactDetailCoordinator.swift
//  Contact
//
//  Created by Ankit Kedia on 11/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailCoordinator: Coordinator {
    
    private var presenter : UINavigationController
    private var viewModel : ContactViewModel
    
    init(presenter: UINavigationController , viewModel : ContactViewModel) {
        self.presenter = presenter
        self.viewModel = viewModel
    }
    
    func start() {
        let contactDetailController = ContactDetailViewController.init(nibName: nil, bundle: nil)
        contactDetailController.viewModel = self.viewModel
        self.presenter.pushViewController(contactDetailController, animated: true)
        
    }
    
    
}
