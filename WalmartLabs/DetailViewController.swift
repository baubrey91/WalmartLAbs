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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //product = products[productIndex]
    }
}

//MARK:- CollectionView
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        cell.product = products[indexPath.row]
        
        return cell
    }
}
