//
//  ContactTableViewCell.swift
//  Contact
//
//  Created by Ankit Kedia on 10/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    var userImageView : CicularImageView!
    var usernameLabel: UILabel!
    var favouriteImageView : UIImageView!
    var viewModel : ContactViewModel! {
        didSet {
            usernameLabel?.text = viewModel.fullname
            if viewModel.isFavourite {
                favouriteImageView.alpha = 1
            } else {
                favouriteImageView.alpha = 0
            }
            userImageView.image = UIImage.init(named: "placeholder_photo")
            if let imageUrl = viewModel.imageUrl {
                userImageView.downloadImage(from: URL.init(string: imageUrl)!)
            }
            self.setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.userImageView = CicularImageView.init()
        userImageView.contentMode = .scaleAspectFit
        self.addSubview(userImageView)
        
        usernameLabel = UILabel.init()
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(usernameLabel)
        
        self.favouriteImageView = UIImageView.init()
        favouriteImageView.contentMode = .scaleAspectFit
        favouriteImageView.image = UIImage.init(named: "home_favourite")
        self.addSubview(favouriteImageView)
//        userImageView.translatesAutoresizingMaskIntoConstraints = false
//        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
//        favouriteImageView.translatesAutoresizingMaskIntoConstraints = false

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.frame = CGRect(x: 16, y: 12, width: self.bounds.height-2*12, height: self.bounds.height-2*12)
        favouriteImageView.frame = CGRect(x: self.bounds.width-24-32, y: (self.bounds.height-24)/2, width: 24, height: 24)
        usernameLabel.frame = CGRect(x: userImageView.frame.width+userImageView.frame.origin.x+16, y: 0, width: self.bounds.width-24-32-(userImageView.frame.width+userImageView.frame.origin.x+16)-16, height: self.bounds.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
