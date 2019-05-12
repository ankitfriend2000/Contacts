//
//  ContactDetailViewController.swift
//  Contact
//
//  Created by Ankit Kedia on 11/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import UIKit
import MessageUI

protocol ContactDetailViewDelegate : class {
    func didClickEditButtonWithModel(_ viewModel:ContactDetailViewModel?)
}

class ContactDetailViewController: UIViewController {
    
    @IBOutlet weak var headerContainerView: UIView!
    
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var contactDetailTableView: UITableView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    private let networkManager = ContactNetworkManager()
    private let contactGreen : UIColor = UIColor(red: 80.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    
    var footerView : UIView?
    var viewModel : ContactViewModel?
    var contactDetailViewModel : ContactDetailViewModel?
    private var shadowImageView: UIImageView?
    private let gradient : CAGradientLayer = CAGradientLayer()
    private var editButton : UIBarButtonItem?
    weak var delegate : ContactDetailViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.tintColor = self.contactGreen
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Edit", style: .done, target: self, action: #selector(rightButtonClicked))
        
        self.gradient.colors = [UIColor.white.cgColor, contactGreen.cgColor]
        self.gradient.locations = [0, 1.0]
        self.gradient.opacity = 0.30
        self.headerContainerView.layer.insertSublayer(self.gradient, at: 0)
        
        self.contactDetailTableView.delegate = self
        self.contactDetailTableView.dataSource = self
        self.userImageView.layer.borderColor = UIColor.white.cgColor
        self.userImageView.layer.borderWidth = 3
        
        let label = UILabel.init(frame: CGRect(x: 24, y: 0, width: 100, height: 40))
        label.text = "Delete"
        label.textColor = UIColor.red
        footerView = UIView.init()
        footerView?.isUserInteractionEnabled = true
        footerView?.addSubview(label)
        footerView?.backgroundColor = UIColor.white
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(deleteContact))
        footerView?.addGestureRecognizer(tapGesture)
        self.contactDetailTableView.tableFooterView = footerView
        self.contactDetailTableView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        contactDetailTableView.register(UINib(nibName: "TitleDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "contactDetail")

        initializeHeaderView()
        fetchContactsDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if shadowImageView == nil {
            shadowImageView = findShadowImage(under: navigationController!.navigationBar)
        }
        shadowImageView?.isHidden = true
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.async {
            self.contactDetailTableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        shadowImageView?.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        footerView?.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40)
        self.gradient.frame = self.headerContainerView.bounds
        self.userImageView.layer.cornerRadius = self.userImageView.frame.width/2

    }
    
    @IBAction func messageTapped(_ sender: Any) {
        
        guard let phoneNumber = contactDetailViewModel?.phoneNumber else {
            return
        }
        let sms: String = "sms:+" + phoneNumber
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }

    
    @IBAction func callTapped(_ sender: Any) {
        guard let phoneNumber = contactDetailViewModel?.phoneNumber else {
            return
        }
        let number = URL(string: "tel://" + phoneNumber)
        UIApplication.shared.open(number!, options: [:], completionHandler: nil)

    }
    
    
    @IBAction func emailTapped(_ sender: Any) {
        guard let email = contactDetailViewModel?.emailAddress else {
            return
        }
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients([email])
        composeVC.setSubject("Hello!")
        composeVC.setMessageBody("Hello from Go-JEK", isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
        
    }
    
    @objc func deleteContact() {
        guard let contactID = contactDetailViewModel?.contactID else {
            return
        }
        let contactUrl = "https://gojek-contacts-app.herokuapp.com/contacts/\(contactID).json"
        ContactNetworkManager.sharedManager.delete(urlString:contactUrl, successHandler: {
            print("deleted")
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .deleteContactNotification, object: self.viewModel, userInfo: [:])
                self.navigationController?.popViewController(animated: true)
            }
        }) { (error) in
            print(error)
        }
    }
    
    private func findShadowImage(under view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1 {
            return (view as! UIImageView)
        }
        
        for subview in view.subviews {
            if let imageView = findShadowImage(under: subview) {
                return imageView
            }
        }
        return nil
    }
    

    
    @objc func rightButtonClicked() {
        self.delegate?.didClickEditButtonWithModel(contactDetailViewModel)
    }
    
    func initializeHeaderView() {
        userNameLabel.text = viewModel?.fullname
        favouriteButton.setImage(UIImage.init(named: viewModel!.favouriteImageUrl), for: .normal)
        if let imageUrl = viewModel?.imageUrl {
            userImageView.downloadImage(from: URL.init(string: imageUrl)!)
        }
        
    }
    
    private func fetchContactsDetail() {
        guard let contactUrl = viewModel?.detailUrl else {
            return
        }
        let successHandler: (ContactDetailModel) -> Void = { (contactModel) in
            self.contactDetailViewModel = ContactDetailViewModel.init(contactDetail: contactModel)
            
            DispatchQueue.main.async {
                self.contactDetailTableView.reloadData()
            }
        }
        let errorHandler: (String) -> Void = { (error) in
            print(error)
        }
        networkManager.get(urlString: contactUrl, headers: [:], successHandler: successHandler, errorHandler: errorHandler)
        
    }

}

extension ContactDetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}

extension ContactDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactDetailViewModel?.contactDetailDataSource.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactDetail", for: indexPath) as! TitleDescriptionTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        return cell

    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let tableCell = cell as! TitleDescriptionTableViewCell
        tableCell.titleDescriptionModel = contactDetailViewModel?.contactDetailDataSource[indexPath.row]
    }
    
    
}

extension ContactDetailViewController : MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
