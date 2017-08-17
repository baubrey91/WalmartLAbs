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
    
    
    /*func getProducts(pgNumber: Int, pgSize: Int) {
        let url = URL(string:("\(baseURL)\(productList)\(apiKey)\(pgNumber)\(pgSize)"))

        
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: nil,
                                 delegateQueue: OperationQueue.main
        )
        
        
        
        let task: URLSessionDataTask = session.dataTask(with: request,completionHandler: {(dataOrNil, response, error) in
            if error != nil {
                print(error ?? "unkown")
            }
            //start spinner
            if let data = dataOrNil {
                print(data)
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSObject {
                    //let payLoad = responseDictionary["products"] as? [NSDictionary]{
                    //print(payLoad)
                    /*for m in payLoad {
                        let mm = Movie(dict: m)
                        self.moviesArray.append(mm)
                    }*/
                    //stop spinner
//                    self.collectionView.reloadData()
//                    self.filteredMoviesArray = self.moviesArray
//                    self.tableView.reloadData()
                }
            }
        });
        task.resume()
    }*/
    
}
