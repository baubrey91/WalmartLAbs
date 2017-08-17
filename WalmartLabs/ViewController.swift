//
//  ViewController.swift
//  WalmartLabs
//
//  Created by Brandon on 8/16/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var products = [Product]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Client.sharedInstance.getProducts(completionHandler: {
            json in DispatchQueue.main.sync {
                self.products = json as! [Product]
                self.tableView.reloadData()
            }
        })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
        
        cell.product = products[indexPath.row]
        
        return cell
    }
}

