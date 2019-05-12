//
//  AddUpdateTableViewCell.swift
//  Contact
//
//  Created by Ankit Kedia on 12/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import UIKit

class AddUpdateTableViewCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    private let titleColor : UIColor = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 0.5)
    private let descriptionColor : UIColor = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1.0)

    var cellDataSourceModel : ContactAddUpdateDataSourceModel? {
        didSet {
            typeLabel.text = (cellDataSourceModel?.infoType).map { $0.rawValue }
            valueTextField.text = cellDataSourceModel?.value
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        valueTextField.delegate = self
        typeLabel.textColor = titleColor
        valueTextField.textColor = descriptionColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension AddUpdateTableViewCell : UITextFieldDelegate {
    
}
