//
//  MovieCell.swift
//  SwiftySky
//
//  Created by Eugene Dorfman on 1/30/16.
//  Copyright © 2016 justadreamer. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    var movie : Movie? {
        didSet {
            update()
        }
    }

    func update() {
        titleLbl.text = movie?.title
    }

    override func prepareForReuse() {
        movie = nil
    }
}
