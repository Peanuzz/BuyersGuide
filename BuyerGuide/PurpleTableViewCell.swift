//
//  PurpleTableViewCell.swift
//  BuyerGuide
//
//  Created by Peanuz on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit
import Kingfisher

class PurpleTableViewCell: UITableViewCell {
    static let CellIdentifier: String = "PurpleTableViewCell"
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(purple: PurpleModel) {
        nameLabel.text = purple.name
        descriptionLabel.text = purple.description
        priceLabel.text = "\(purple.price)"
        ratingLabel.text = "\(purple.rating)"
        productImageView.kf.setImage(with: URL(string: purple.thumbImageURL))
    }

}
