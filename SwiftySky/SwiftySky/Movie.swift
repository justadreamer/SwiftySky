//
//  Moview.swift
//  SwiftySky
//
//  Created by Eugene Dorfman on 1/17/16.
//  Copyright © 2016 justadreamer. All rights reserved.
//

import Foundation

struct Movie {
    var title = ""
    var imageURL: NSURL?
    
}

extension Movie : CustomStringConvertible {
    var description : String {
        get {
            return "Movie: " + self.title + ", " + (self.imageURL != nil ? "has image" : "no image")
        }
    }
}
