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
    private var addUpdateCoordinator : AddOrUpdateContactCoordinator?
    init(presenter: UINavigationController , viewModel : ContactViewModel) {
        self.presenter = presenter
        self.viewModel = viewModel
    }
    
    func start() {
        let contactDetailController = ContactDetailViewController.init(nibName: nil, bundle: nil)
        contactDetailController.viewModel = self.viewModel
        contactDetailController.delegate = self
        self.presenter.pushViewController(contactDetailController, animated: true)
        
    }
}

extension ContactDetailCoordinator : ContactDetailViewDelegate {
    func didClickEditButtonWithModel(_ viewModel: ContactDetailViewModel?) {
        guard let contactViewmodel = viewModel else {
            return
        }
        let addUpdateCoordinator = AddOrUpdateContactCoordinator(presenter: self.presenter, viewModel: contactViewmodel)
        addUpdateCoordinator.start()
        self.addUpdateCoordinator = addUpdateCoordinator
    }
    
    
}
