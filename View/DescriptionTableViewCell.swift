//
//  DescriptionTableViewCell.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/9/23.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    static let identifier = "DescriptionTableViewCell"
    static var nib: UINib {
        return UINib(nibName: "DescriptionTableViewCell", bundle: nil)
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
