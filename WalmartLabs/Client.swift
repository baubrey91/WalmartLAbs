import Foundation

class Client {
    
    fileprivate let baseURL = "https://walmartlabs-test.appspot.com/_ah/api/walmart/v1/"
    fileprivate let apiKey = "b3bc76ab-6ae5-45a9-94c0-521ea8c13036/"
    fileprivate let productList = "walmartproducts/" //{apiKey}/{pageNumber}/{pageSize}"
    fileprivate let session = URLSession.shared
    
    static let sharedInstance = Client()
    
    func getProducts(pageNumber: Int, pageSize: Int, completionHandler: @escaping ((_ products: AnyObject) -> Void)) {
        let urlString = "\(baseURL)\(productList)\(apiKey)\(pageNumber)/\(pageSize)"
        let url = URL(string: urlString)

        let task = session.dataTask(with: url!, completionHandler: { data, response, error -> Void in
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
