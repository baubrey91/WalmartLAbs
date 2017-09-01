import Foundation
import UIKit

class Client {
    
    fileprivate let baseURL = "https://walmartlabs-test.appspot.com/_ah/api/walmart/v1/"
    fileprivate let apiKey = "b3bc76ab-6ae5-45a9-94c0-521ea8c13036/"
    fileprivate let productList = "walmartproducts/" //{apiKey}/{pageNumber}/{pageSize}"
    fileprivate let session = URLSession.shared
    
    static let sharedInstance = Client()
    
    func getProductURL(pageNumber: Int, pageSize: Int) -> URL? {
        let urlString = "\(baseURL)\(productList)\(apiKey)\(pageNumber)/\(pageSize)"
        guard canOpenURL(string: urlString) else { return nil }
        return URL(string: urlString)!
    }
    
    func getProducts(pageNumber: Int, pageSize: Int, completionHandler: @escaping ((_ products: AnyObject) -> Void)) {
        
        if let url = getProductURL(pageNumber: pageNumber, pageSize: pageSize) {
            let task = session.dataTask(with: url, completionHandler: { data, response, error -> Void in
                if error != nil {
                    completionHandler(error as AnyObject)
                }
                
                if data != nil {
                    let jsonData = (try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)) as? payload
                    if let dictionaries = jsonData?["products"] as? [payload] {
                        completionHandler(Product.products(array: dictionaries) as AnyObject)
                    }
                }
                self.session.invalidateAndCancel()
            })
            task.resume()
        }
    }
    
    fileprivate func canOpenURL(string: String?) -> Bool {
        guard let urlString = string else {return false}
        guard let url = NSURL(string: urlString) else {return false}
        if !UIApplication.shared.canOpenURL(url as URL) {return false}
        
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
}
