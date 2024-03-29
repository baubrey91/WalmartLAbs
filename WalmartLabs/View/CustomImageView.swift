import Foundation
import UIKit

//Image Cache
let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    fileprivate var imageUrlString: String?
    func loadImage(urlString: String) {
        
        imageUrlString = urlString
        let url = URL(string: urlString)

        //if image is in cache load it otherwise download it
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error ?? "Unkown")
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                //if this is correct image for cell set it otherwise only cache it
                if self.imageUrlString == urlString {
                    self.alpha = 0.0
                    self.image = imageToCache
                    UIView.animate(withDuration: 2.0, animations: { () -> Void in
                        self.alpha = 3.0
                    })
                }
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
        }).resume()
    }
}
