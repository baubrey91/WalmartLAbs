//
//  ProductTableViewCell.swift
//  WalmartLabs
//
//  Created by Brandon on 8/16/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productImage: CustomImageView!
    
    //MVVM configuration of lables in ViewModel
    var product: Product? {
        didSet {
            productName.text = product?.productName
            productDescription.text = product?.shortDesctription
            price.text = product?.price
            productImage.loadImage(urlString: (product?.productImage)!)
        }
    }
}

