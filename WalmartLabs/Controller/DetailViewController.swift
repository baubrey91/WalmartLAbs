import UIKit

class DetailViewController: UIViewController {
    
    var products = [Product]()
    var productIndex: IndexPath!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- View Life Cycle
    //left template code incase needed in future
    override func viewDidLoad() {
        super.viewDidLoad()
        //product = products[productIndex]
    }
// scroll to the correct item upon entering screen
    override func viewDidLayoutSubviews() {
        self.collectionView.scrollToItem(at: productIndex, at: .centeredVertically, animated: false)
    }
}

//MARK:- CollectionView
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //need to rescale frames to allow paging to work properly
        let width = self.view.frame.width
        let height = self.view.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        //self.title = products[indexPath.row].productName
        cell.product = products[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ProductCollectionViewCell
        cell.flipOver()
    }
}
