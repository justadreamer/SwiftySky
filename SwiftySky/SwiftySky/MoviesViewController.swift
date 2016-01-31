//
//  MoviesTableViewController.swift
//  SwiftySky
//
//  Created by Eugene Dorfman on 1/17/16.
//  Copyright © 2016 justadreamer. All rights reserved.
//

import UIKit

class MoviesViewController: UITableViewController {
    var loader : MoviesLoader!
    var movies : [Movie]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
        self.loader = MoviesLoader {[weak self] result -> Void in
            if let strongSelf = self {
                switch result {
                    case .Movies(let movies):
                        strongSelf.movies = movies
                    case .Error(let message):
                        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        strongSelf.presentViewController(alert, animated: true, completion: nil)
                }
                strongSelf.tableView.reloadData()
                refreshControl.endRefreshing()
            }
        }
        
        refreshControl.beginRefreshing()
        self.loader.load()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as? MovieCell,
            let movie = self.movies?[indexPath.row] {
            cell.movie = movie
            return cell
        }
        return UITableViewCell()
    }
    
    func refresh () {
        self.loader.load()
    }
}
