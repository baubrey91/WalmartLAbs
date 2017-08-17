//
//  DestinationViewController.swift
//  WalmartLabs
//
//  Created by Brandon Aubrey on 8/16/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var products = [Product]()
    var productIndex: Int!
    
    @IBOutlet weak var collectionView: UICollectionViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //product = products[productIndex]
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
}
