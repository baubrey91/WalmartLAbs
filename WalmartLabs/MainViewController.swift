//
//  ViewController.swift
//  WalmartLabs
//
//  Created by Brandon on 8/16/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var products = [Product]()
    
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
    
    var pageOffSet = 1
    let pageSize = 10

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up infinte scroll
        let frame = CGRect(x: 0,
                           y: tableView.contentSize.height,
                           width: tableView.bounds.size.width,
                           height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
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
        activitySpinner.hidesWhenStopped = true
        activitySpinner.startAnimating()
        Client.sharedInstance.getProducts(pageNumber: pageOffSet, pageSize: pageSize, completionHandler: {
            products in DispatchQueue.main.sync {
                self.products = products as! [Product]
                self.tableView.reloadData()
                self.activitySpinner.stopAnimating()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        let indexPath = tableView.indexPath(for: sender as! ProductTableViewCell)!
        destinationVC.products = products
        destinationVC.productIndex = indexPath.row
    }
    
    func refresh() {
//        Client.sharedInstance.getProducts(pageNumber: pageOffSet, pageSize: pageSize, completionHandler: {
//            products in DispatchQueue.main.sync {
//                self.products = products as! [Product]
//                self.tableView.reloadData()
//                self.refreshControl!.endRefreshing()
//            }
//        })
//    }
        
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
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
        cell.product = products[indexPath.row]
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
                
                loadMoreData()
            }
        }
    }
    
    func loadMoreData() {
        //load next page when scrolling to bottom
        pageOffSet += 1
        
        Client.sharedInstance.getProducts(pageNumber: pageOffSet, pageSize: pageSize, completionHandler: {
            products in DispatchQueue.main.sync {
                self.products += products as! [Product]
                self.isMoreDataLoading = false
                self.loadingMoreView!.stopAnimating()
                self.tableView.reloadData()
            }
        })
    }
}

