//
//  CustomImageView.swift
//  WalmartLabs
//
//  Created by Brandon on 8/16/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    func loadImage(urlString: String) {
        
        imageUrlString = urlString
        let url = URL(string: urlString)
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error ?? "Unkown")
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
        }).resume()
    }
}

