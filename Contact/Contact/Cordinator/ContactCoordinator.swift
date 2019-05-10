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
    private var viewModel : ContactViewModel?
    private var contactDetailCoordinator : ContactDetailCoordinator?
    init(presenter : UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let contactViewController = ContactsTableViewController.init(nibName: nil, bundle: nil)
        contactViewController.delegate = self
        self.presenter.pushViewController(contactViewController, animated: true)
        self.contactViewController = contactViewController
    }
    
}

extension ContactCoordinator : ContactsTableViewDelegate {
    func didSelectContactWithViewModel(_ viewModel: ContactViewModel) {
        self.viewModel = viewModel
        let currentCoordinator = ContactDetailCoordinator.init(presenter: presenter, viewModel: viewModel)
        currentCoordinator.start()
        self.contactDetailCoordinator = currentCoordinator
    }
    
    
}
