//
//  Product.swift
//  WalmartLabs
//
//  Created by Brandon on 8/16/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import Foundation

class Product {
    
    var productID: String?
    var productName: String?
    var shortDescription: String?
    var longDescription: String?
    var price: String?
    var productImage: String?
    var reviewRating: Double?
    var reviewCount: Int?
    var inStock: Bool?
    
    //create product object with json
    init(dictionary: payload) {
        
        productID = dictionary["name"] as? String
        productName = dictionary["productName"] as? String
        shortDescription = dictionary["shortDescription"] as? String
        longDescription = dictionary["longDescription"] as? String
        price = dictionary["price"] as? String
        productImage = dictionary["productImage"] as? String
        reviewRating = dictionary["reviewRating"] as? Double
        reviewCount = dictionary["reviewCount"] as? Int
        // safe to assume that if information is not there it is not in stock
        inStock = dictionary["reviewCount"] as? Bool ?? false
    }
    
    //create array of products by passing in json array
    class func products(array: [payload]) -> [Product] {
        var products = [Product]()
        for dictionary in array {
            let product = Product(dictionary: dictionary)
            products.append(product)
        }
        return products
    }
    

}
