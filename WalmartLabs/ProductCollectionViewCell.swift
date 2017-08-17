//
//  ProductCollectionViewCell.swift
//  WalmartLabs
//
//  Created by Brandon Aubrey on 8/16/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: CustomImageView!
    @IBOutlet weak var price: UILabel!
    
    //MVVM configuration of lables in ViewModel
    var product: Product? {
        didSet {
            productName.text = product?.productName
            //productDescription.text = product?.shortDesctription
            price.text = product?.price
            productImage.loadImage(urlString: (product?.productImage)!)
        }
    }
    
}
