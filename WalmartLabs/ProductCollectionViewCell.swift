//
//  ProductCollectionViewCell.swift
//  WalmartLabs
//
//  Created by Brandon Aubrey on 8/16/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var inStockImage: UIImageView!
    @IBOutlet weak var productImage: CustomImageView!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MVVM configuration of labels in ViewModel
    var product: Product? {
        didSet {
            nameLabel.text = product?.productName
            priceLabel.text = product?.price
            productImage.loadImage(urlString: (product?.productImage)!)
            if let htmlString = product?.shortDescription {
                let attributed = try! NSAttributedString(data: htmlString.data(using: .unicode)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                shortDescriptionLabel.text = attributed.string
            } else {
                shortDescriptionLabel.text = "No description at this time"
            }
            inStockImage.image = (product?.inStock)! ? #imageLiteral(resourceName: "thumbs_up"): #imageLiteral(resourceName: "thumbs_down")
        }
    }
}
