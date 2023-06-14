//
//  DogsTableViewCell.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/13/23.
//

import UIKit
import Alamofire

class DogsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogNameLabel: UILabel!
    private lazy var imageService = ImageService()
    var request: DataRequest?
    static let identifier = "DogsTableViewCell"
    static var nib: UINib {
        return UINib(nibName: "DogsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dogImageView.image = nil
        request?.cancel()
    }
    
    func configure(name: String, imageUrl: URL) {
        dogNameLabel.text = name
        
        imageService.image(for: imageUrl) { [weak self] image in
            self?.dogImageView.image = image
        }
    }
}
