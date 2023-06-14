//
//  DogsTableViewCell.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/13/23.
//

import UIKit
import Moya

class DogsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    private lazy var imageService = ImageService()
//    var request: DataRequest?
//    var provider = MoyaProvider<MyService>()
    var request: Cancellable?
    static let identifier = "DogsTableViewCell"
    static var nib: UINib {
        return UINib(nibName: "DogsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dogImageView.layer.cornerRadius = dogImageView.bounds.height / 2
        dogImageView.layer.borderWidth = 3
        dogImageView.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dogImageView.image = nil
        dogNameLabel.text = nil
        request?.cancel()
    }
    
    func configure(name: String?, imageUrl: URL, key: String) {
        dogNameLabel.text = name
        imageService.image(for: imageUrl, key: key) { [weak self] image in
            self?.dogImageView.image = image
            self?.activityIndicatorView.stopAnimating()
        }
    }
    
    func configure(name: String?, image: UIImage) {
        dogNameLabel.text = name
        dogImageView.image = image
    }
}
