//
//  ContactsTableViewController.swift
//  Contact
//
//  Created by Ankit Kedia on 10/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    //Constants
    let rowHeight : CGFloat = 64.0
    let sectionHeaderHeight : CGFloat = 28.0
    
    //datasources
    private var contactViewModelArray : [String :[ContactViewModel]] = [:]
    private var firstCharaterArray : [String] = []
    
    //network layer
    private let networkManager = ContactNetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "contactIdentifier")
        self.tableView.rowHeight = rowHeight
        self.tableView.tableFooterView = UIView.init()
        self.title = "Contact"
        fetchContacts()
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
}
