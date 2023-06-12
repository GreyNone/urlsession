//
//  FilmTableViewCell.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/9/23.
//

import UIKit

class FilmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    static var nib: UINib {
        return UINib(nibName: "FilmTableViewCell", bundle: nil)
    }
    static var identifier = "FilmTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
