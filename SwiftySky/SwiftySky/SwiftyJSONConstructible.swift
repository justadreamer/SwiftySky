//
//  SwiftyJSONSerializable.swift
//  SwiftySky
//
//  Created by Eugene Dorfman on 1/30/16.
//  Copyright © 2016 justadreamer. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol SwiftyJSONConstructible {
    init(fromJSON json:JSON)
    static func array(from jsonArray:[JSON]) -> [Self]
}
