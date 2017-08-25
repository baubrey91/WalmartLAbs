//
//  Client.swift
//  WalmartLabs
//
//  Created by Brandon on 8/16/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import Foundation

class Client {
    
    let baseURL = "https://walmartlabs-test.appspot.com/_ah/api/walmart/v1/"
    let apiKey = "b3bc76ab-6ae5-45a9-94c0-521ea8c13036/"
    let productList = "walmartproducts/" //{apiKey}/{pageNumber}/{pageSize}"
    
    static let sharedInstance = Client()
    
    func getProducts(pageNumber: Int, pageSize: Int, completionHandler: @escaping ((_ products: AnyObject) -> Void)) {
        let urlString = "\(baseURL)\(productList)\(apiKey)\(pageNumber)/\(pageSize)"
        let url = URL(string: urlString)

        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: { data, response, error -> Void in
            if error != nil {
                completionHandler(error as AnyObject)
            }
            if data != nil {
                let jsonData = (try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)) as? [String: Any]
                if let dictionaries = jsonData?["products"] as? [NSDictionary] {
                    completionHandler(Product.products(array: dictionaries) as AnyObject)
                }
            }
            session.invalidateAndCancel()
        })
        task.resume()
    }
}
