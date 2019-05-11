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
    private let titleColor : UIColor = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 0.5)
    private let descriptionColor : UIColor = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1.0)

    

    var titleDescriptionModel : ContactDetailDataSourceModel! {
        didSet {
            title.text = titleDescriptionModel.title
            descriotion.text = titleDescriptionModel.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        title.textColor = titleColor
        descriotion.textColor = descriptionColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
