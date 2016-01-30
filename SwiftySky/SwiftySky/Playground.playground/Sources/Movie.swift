//
//  Moview.swift
//  SwiftySky
//
//  Created by Eugene Dorfman on 1/17/16.
//  Copyright © 2016 justadreamer. All rights reserved.
//

import Foundation

public struct Movie {
    public var title = ""
    public var imageURL: NSURL?
    
    public init (dictionary: [String:String]) {
        if let title = dictionary["title"] {
            self.title = title
        }
        if let URLString = dictionary["image_url"],
            let imageURL = NSURL(string:URLString) {
            self.imageURL = imageURL
        }
    }
}
