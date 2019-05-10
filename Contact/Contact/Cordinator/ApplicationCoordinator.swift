//
//  ApplicationCoordinator.swift
//  Contact
//
//  Created by Ankit Kedia on 10/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    let window : UIWindow
    let rootViewController : UINavigationController
    let contactCoordinator : ContactCoordinator
    
    init(window : UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        contactCoordinator = ContactCoordinator(presenter: rootViewController)
        
    }
    
    func start() {
        window.rootViewController = rootViewController
        contactCoordinator.start()
        window.makeKeyAndVisible()
    }
}
