//
//  TitleDescriptionTableViewCell.swift
//  Contact
//
//  Created by Ankit Kedia on 11/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import UIKit

class TitleDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriotion: UILabel!
    @IBOutlet weak var title: UILabel!
    var titleDescriptionModel : ContactDetailDataSourceModel! {
        didSet {
            title.text = titleDescriptionModel.title
            descriotion.text = titleDescriptionModel.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
