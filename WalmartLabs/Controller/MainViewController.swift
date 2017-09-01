import UIKit

class MainViewController: UIViewController {
    
    var filteredProducts = [Product]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var products = [Product]() {
        didSet {
            filteredProducts = products
        }
    }
    
    fileprivate var searchBar: UISearchBar!
    
    //pull to refresh set up
    var refreshControl: UIRefreshControl!
    var refreshLoadingView: UIView!
    var refreshColorView: UIView!
    var compass_background: UIImageView!
    var compass_spinner: UIImageView!
    var isRefreshIconsOverlap = false
    var isRefreshAnimating = false
    var isMoreDataLoading = false
    var loadingMoreView: InfiniteScrollActivityView?
    
    fileprivate var pageOffSet = 1
    fileprivate var pageSize = 10

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        configureSeachBar()
        configureTableviewReloads()
        activitySpinner.hidesWhenStopped = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loadProducts),
                                               name: NSNotification.Name.UIApplicationDidBecomeActive,
                                               object: nil)
        loadProducts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        let indexPath = tableView.indexPath(for: sender as! ProductTableViewCell)!
        destinationVC.products = filteredProducts
        destinationVC.productIndex = indexPath
    }
    
    //MARK:- Configuration
    fileprivate func configureSeachBar() {
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    fileprivate func configureTableviewReloads() {
        //set up infinte scroll
        let frame = CGRect(x: 0,
                           y: tableView.contentSize.height,
                           width: tableView.bounds.size.width,
                           height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView?.backgroundColor = UIColor.clear
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
        
        //set up pull to refresh
        refreshControl = UIRefreshControl()
        PullToRefresh.setupRefreshControl(vc: self)
        refreshControl?.addTarget(self, action: #selector(MainViewController.refresh),
                                  for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    //MARK:- Functions
    func loadProducts() {
        if Reachability.isConnectedToNetwork() {
            pageSize = 10
            activitySpinner.startAnimating()
            
            //Check for internet connection and send alert if no connection
            Client.sharedInstance.getProducts(pageNumber: pageOffSet, pageSize: pageSize, completionHandler: {
                products in DispatchQueue.main.sync {
                    self.products = products as! [Product]
                    self.activitySpinner.stopAnimating()
                }
            })
        } else {
            noInternetAlert()
        }
    }
    
    fileprivate func noInternetAlert() {
        let alert = UIAlertController(title: "Uh Oh",
                                      message: "You are not connected to the internet",
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: { (alert) in
                                    
        })
        alert.addAction(action)
        self.present(alert,
                     animated: true,
                     completion: nil)
        
    }
    
    fileprivate func addProducts() {
        pageSize += 10
        Client.sharedInstance.getProducts(pageNumber: pageOffSet, pageSize: pageSize, completionHandler: {
            products in DispatchQueue.main.sync {
                self.isMoreDataLoading = false
                self.loadingMoreView!.stopAnimating()
                self.products = products as! [Product]
                self.activitySpinner.stopAnimating()
            }
        })
    }
    
    func refresh() {
        //getProducts()
        
        // I set up a timer instead of getting data to showcase the animation, above code will refresh data
        let delayInSeconds = 3.0
        let popTime = DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime) { () -> Void in
            self.refreshControl!.endRefreshing()
        }
    }
}

// MARK: TableView and infinite scroll
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
        cell.product = filteredProducts[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //pull down to refresh
        PullToRefresh.scrolling(scrollView: scrollView, vc: self)
        
        //infinite scroll
        if !isMoreDataLoading {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            if scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging {
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRect(x: 0, y: tableView.contentSize.height,
                                   width: tableView.bounds.size.width,
                                   height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                addProducts()
            }
        }
    }
}

//MARK:- SearchBar
extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            filteredProducts = products.filter { (product: Product) -> Bool in
                return (product.productName?.lowercased().contains(searchText.lowercased()))!
            }
        } else {
            filteredProducts = products
            searchBar.resignFirstResponder()
        }
    }
}
