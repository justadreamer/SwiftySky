//
//  Movie+JSON.swift
//  SwiftySky
//
//  Created by Eugene Dorfman on 1/30/16.
//  Copyright © 2016 justadreamer. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Movie : SwiftyJSONConstructible {
    init(fromJSON json:JSON) {
        title = json["title"].string ?? ""
        imageURL = NSURL(string:json["imageURL"].string ?? "")
    }

    static func array(from jsonArray:[JSON]) -> [Movie] {
        return jsonArray.map { Movie(fromJSON:$0) }
    }
}
