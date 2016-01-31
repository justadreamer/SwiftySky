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
    var imageLoader: ImageLoader?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.imageLoader = ImageLoader { [weak self] in
            if let strongSelf = self {
                strongSelf.thumb.image = $0
            }
        }
    }
    
    var movie : Movie? {
        didSet {
            update()
        }
    }

    func update() {
        self.imageLoader?.cancel()
        self.thumb.image = nil
        self.titleLbl.text = movie?.title
        if let URL = movie?.imageURL {
            self.imageLoader?.load(URL)
        }
    }

    override func prepareForReuse() {
        movie = nil
    }
}
