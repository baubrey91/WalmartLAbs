import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var inStockImage: UIImageView!
    @IBOutlet weak var productImage: CustomImageView!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImageView: UIView!
    @IBOutlet weak var productDescriptionView: UIView!
    
    fileprivate var isFlipped = false
    
    //MVVM configuration of labels in ViewModel
    var product: Product? {
        didSet {
            nameLabel.text = product?.productName
            priceLabel.text = product?.price
            productImage.loadImage(urlString: (product?.productImage)!)
            if let htmlString = product?.shortDescription {
                let attributed = try! NSAttributedString(data: htmlString.data(using: .unicode)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                shortDescriptionLabel.text = attributed.string
            } else {
                shortDescriptionLabel.text = "No description at this time"
            }
            inStockImage.image = (product?.inStock)! ? #imageLiteral(resourceName: "thumbs_up"): #imageLiteral(resourceName: "thumbs_down")
        }
    }
    
    func flipOver() {
        if isFlipped {
            flipHelper(viewOne: productImageView, viewTwo: productDescriptionView)
        } else {
            flipHelper(viewOne: productDescriptionView, viewTwo: productImageView)
        }
        isFlipped = !isFlipped
    }
    
    //sends in two views and flips them
    fileprivate func flipHelper(viewOne: UIView, viewTwo: UIView) {
        UIView.transition(from: viewOne,
                          to: viewTwo,
                          duration: 1.0,
                          options: [UIViewAnimationOptions.transitionFlipFromLeft, UIViewAnimationOptions.showHideTransitionViews],
                          completion: nil)
    }
}
