//
//  ContactsTableViewController.swift
//  Contact
//
//  Created by Ankit Kedia on 10/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import UIKit

protocol ContactsTableViewDelegate : class {
    func didSelectContactWithViewModel(_ viewModel : ContactViewModel)
}

protocol ContactsAddTableViewDelegate : class {
    func addNewContact()
}

class ContactsTableViewController: UITableViewController {
    
    //Constants
    let rowHeight : CGFloat = 64.0
    let sectionHeaderHeight : CGFloat = 28.0
    private let contactGreen : UIColor = UIColor(red: 80.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    weak var delegate : ContactsTableViewDelegate?
    weak var addDelegate : ContactsAddTableViewDelegate?

    //datasources
    private var contactViewModelArray : [String :[ContactViewModel]] = [:]
    private var firstCharaterArray : [String] = []
    
    //network layer
    private let networkManager = ContactNetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        self.navigationItem.rightBarButtonItem?.tintColor = contactGreen
        self.tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "contactIdentifier")
        self.tableView.rowHeight = rowHeight
        self.tableView.tableFooterView = UIView.init()
        self.title = "Contact"
        fetchContacts()
        NotificationCenter.default.addObserver(self, selector: #selector(deletedContact(_:)), name: .deleteContactNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addedContact(_:)), name: .addContactNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateContact(_:)), name: .updateContactNotification, object: nil)
    }
    
    @objc func addButtonClicked() {
        addDelegate?.addNewContact()
    }
    
    @objc func deletedContact(_ notification: Notification){
        let mycontactDetailModel  = notification.object as? ContactViewModel
        guard let contactDetailModel = mycontactDetailModel else {
            return
        }
        let firstChar = String((contactDetailModel.fullname.first)!).capitalized
        var contactModelArray = contactViewModelArray[firstChar]
        var index = -1
        for (i,contacts) in contactModelArray!.enumerated() {
            if contacts.contactID == contactDetailModel.contactID {
                index = i
                break
            }
        }
        if index != -1 {
            contactModelArray?.remove(at: index)
        }
        if contactModelArray?.count == 0 {
            contactViewModelArray[firstChar] = nil
            let indexOfChar = firstCharaterArray.firstIndex(of: firstChar)
            if let validIdex = indexOfChar {
                firstCharaterArray.remove(at: validIdex)
            }
        } else {
            contactViewModelArray[firstChar] = contactModelArray
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func addedContact(_ notification: Notification){
        let mycontactDetailModel  = notification.object as? ContactDetailModel
        guard let contactDetailModel = mycontactDetailModel else {
            return
        }
        let contactModel = ContactViewModel(contact: ContactModel(id: (contactDetailModel.id)!, firstName: contactDetailModel.firstName, lastName: contactDetailModel.lastName, profilePic: contactDetailModel.profilePic!, favorite: contactDetailModel.favorite, url:"https://gojek-contacts-app.herokuapp.com/contacts/\((contactDetailModel.id)!).json"))
        let firstChar = String((contactModel.fullname.first)!).capitalized
        var contactModelArray = contactViewModelArray[firstChar]
        if contactModelArray == nil {
            contactModelArray = [ContactViewModel]()
            firstCharaterArray.append(firstChar)
            firstCharaterArray = firstCharaterArray.sorted()
        }
        contactModelArray?.append(contactModel)
        contactModelArray = contactModelArray?.sorted(by: { (first, second) -> Bool in
            return first.fullname < second.fullname
        })
        contactViewModelArray[firstChar] = contactModelArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func updateContact(_ notification: Notification){
        let mycontactDetailModel  = notification.object as? ContactDetailModel
        guard let contactDetailModel = mycontactDetailModel else {
            return
        }
        let contactModel = ContactViewModel(contact: ContactModel(id: (contactDetailModel.id)!, firstName: contactDetailModel.firstName, lastName: contactDetailModel.lastName, profilePic: contactDetailModel.profilePic!, favorite: contactDetailModel.favorite, url:"https://gojek-contacts-app.herokuapp.com/contacts/\((contactDetailModel.id)!).json"))
        let firstChar = String((contactModel.fullname.first)!).capitalized
        var contactModelArray = contactViewModelArray[firstChar]
        var index = -1
        for (i,contacts) in contactModelArray!.enumerated() {
            if contacts.contactID == contactModel.contactID {
                index = i
                break
            }
        }
        if index == -1 {
            return
        }
        contactModelArray?[index] = contactModel
        contactViewModelArray[firstChar] = contactModelArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func fetchContacts() {
        
        let successHandler: ([ContactModel]) -> Void = { (contactModelArray) in
            let contactArray = contactModelArray.map({ return ContactViewModel.init(contact: $0)}).sorted(by: { (first, second) -> Bool in
                return first.fullname < second.fullname
            })
            self.contactViewModelArray = contactArray.reduce([:]) { (dictionary, contactViewModel) -> [String: [ContactViewModel]] in
                var dictionary = dictionary
                let firstChar = String(contactViewModel.fullname.first!)
                if dictionary[firstChar] == nil {
                    self.firstCharaterArray.append(firstChar)
                    dictionary[firstChar] = [contactViewModel]
                }else {
                    var contactModelArray = dictionary[firstChar]!
                    contactModelArray.append(contactViewModel)
                    dictionary[firstChar] = contactModelArray
                }
                return dictionary
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        let errorHandler: (String) -> Void = { (error) in
            print(error)
        }
        
        
        networkManager.get(urlString: "https://gojek-contacts-app.herokuapp.com/contacts.json", headers: [:], successHandler: successHandler, errorHandler: errorHandler)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return contactViewModelArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.contactViewModelArray[firstCharaterArray[section]]!.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ContactTableViewCell = tableView.dequeueReusableCell(withIdentifier: "contactIdentifier", for: indexPath) as! ContactTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let contactCell : ContactTableViewCell = cell as! ContactTableViewCell
        contactCell.viewModel = self.contactViewModelArray[firstCharaterArray[indexPath.section]]![indexPath.row]
        
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return firstCharaterArray
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return firstCharaterArray[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = self.contactViewModelArray[firstCharaterArray[indexPath.section]]![indexPath.row]
        delegate?.didSelectContactWithViewModel(viewModel)
    }
}
