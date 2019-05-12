//
//  AddOrUpdateContactCoordinator.swift
//  Contact
//
//  Created by Ankit Kedia on 12/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import Foundation
import UIKit

class AddOrUpdateContactCoordinator: Coordinator {
    private let presenter : UINavigationController
    private let viewModel : ContactDetailViewModel
    init(presenter: UINavigationController, viewModel: ContactDetailViewModel) {
        self.presenter = presenter
        self.viewModel = viewModel
    }
    
    func start() {
        let addUpdateController = AddOrUpdateContactViewController.init(nibName: nil, bundle: nil)
        addUpdateController.viewModel = self.viewModel
        presenter.present(addUpdateController, animated: true, completion: nil)
    }
}
