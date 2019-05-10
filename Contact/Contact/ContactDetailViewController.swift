//
//  ContactDetailViewController.swift
//  Contact
//
//  Created by Ankit Kedia on 11/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    var viewModel : ContactViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel?.fullname
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
