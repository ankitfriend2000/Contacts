//
//  AddOrUpdateContactViewController.swift
//  Contact
//
//  Created by Ankit Kedia on 12/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import UIKit

class AddOrUpdateContactViewController: UIViewController {
    
    @IBOutlet weak var contactDetailTableView: UITableView!
    @IBOutlet weak var userImageView: UIImageView!

    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var headerView: UIView!
    private let gradient : CAGradientLayer = CAGradientLayer()
    var viewModel : ContactDetailViewModel?

    private let contactGreen : UIColor = UIColor(red: 80.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doneButton.tintColor  = contactGreen
        cancelButton.tintColor = contactGreen
        self.gradient.colors = [UIColor.white.cgColor, contactGreen.cgColor]
        self.gradient.locations = [0, 1.0]
        self.gradient.opacity = 0.30
        self.headerView.layer.insertSublayer(self.gradient, at: 0)
        self.headerView.backgroundColor = UIColor.clear
        
        self.userImageView.layer.borderColor = UIColor.white.cgColor
        self.userImageView.layer.borderWidth = 3
        self.userImageView.bringSubviewToFront(self.cameraButton)
        
        self.contactDetailTableView.tableFooterView = UIView.init()
        self.contactDetailTableView.dataSource = self
        self.contactDetailTableView.delegate = self
        contactDetailTableView.register(UINib(nibName: "AddUpdateTableViewCell", bundle: nil), forCellReuseIdentifier: "contactAddUpdate")
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tapGesture)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradient.frame = self.headerView.bounds
        self.userImageView.layer.cornerRadius = self.userImageView.frame.width/2
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        
    }

    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraClicked(_ sender: Any) {
    }
    
    @objc func viewTapped() {
        self.view.endEditing(true)
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

extension AddOrUpdateContactViewController : UITableViewDelegate {
    
}

extension AddOrUpdateContactViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactAddUpdate", for: indexPath) as! AddUpdateTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let addUpdateCell = cell as! AddUpdateTableViewCell
        addUpdateCell.cellDataSourceModel = viewModel?.dataSource[indexPath.row]
    }
    
}
