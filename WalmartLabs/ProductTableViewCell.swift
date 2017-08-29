//
//  ProductTableViewCell.swift
//  WalmartLabs
//
//  Created by Brandon on 8/16/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: CustomImageView!
    
    //MVVM configuration of lables in ViewModel
    var product: Product? {
        didSet {
            productNameLabel.text = product?.productName
            if let rating = product?.reviewRating, rating > 0 {
                ratingLabel.text = "Rating: \(rating)"
                ratingLabel.textColor = getRatingColor(score: rating)
                
            } else {
                ratingLabel.text = "No Ratings"
                ratingLabel.textColor = UIColor.black
            }
            priceLabel.text = product?.price
            productImage.loadImage(urlString: (product?.productImage)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productNameLabel.preferredMaxLayoutWidth = productNameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        productNameLabel.preferredMaxLayoutWidth = productNameLabel.frame.size.width
    }
    
    fileprivate func getRatingColor(score: Double) -> UIColor {
        switch score {
        case 0..<2:
            return UIColor.red
        case 2..<4:
            return UIColor.yellow
        default:
            return UIColor.green
        }
    }
}
