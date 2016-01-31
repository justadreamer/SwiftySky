//
//  MoviesTableViewController.swift
//  SwiftySky
//
//  Created by Eugene Dorfman on 1/17/16.
//  Copyright © 2016 justadreamer. All rights reserved.
//

import UIKit

class MoviesViewController: UITableViewController {
    var loader : Loader!
    var movies : [Movie]? {
        get {
            return loader?.movies
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
        self.loader = Loader {[weak self] in
            if let strongSelf = self {
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
