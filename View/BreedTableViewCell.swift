//
//  BreedTableViewCell.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/12/23.
//

import UIKit

class BreedTableViewCell: UITableViewCell {

    static let identifier = "BreedTableViewCell"
    static var nib: UINib {
        return UINib(nibName: "BreedTableViewCell", bundle: nil)
    }
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var coatLabel: UILabel!
    @IBOutlet weak var patternLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
