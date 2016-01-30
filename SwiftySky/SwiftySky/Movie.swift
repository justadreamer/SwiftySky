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
    
    init (dictionary: [String:String]) {
        if let title = dictionary["title"] {
            self.title = title
        }
        if let URLString = dictionary["imageURL"],
            let imageURL = NSURL(string:URLString) {
            self.imageURL = imageURL
        }
    }
}

extension Movie : CustomStringConvertible {
    var description : String {
        get {
            return "Movie: " + self.title + ", " + (self.imageURL != nil ? "has image" : "no image")
        }
    }
}
