//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"

import SwiftyJSON
let exampleURL = [#FileReference(fileReferenceLiteral: "example.json")#]

let jsonString = try! NSString(contentsOfURL: exampleURL, encoding: NSUTF8StringEncoding)

let json = JSON.parse(jsonString as String)
let entries = json["entries"].array?
    .map { $0.dictionary }
    .map { (dict : [String : JSON]?) -> [String : String]? in
        if dict != nil {
            return dict?.reduce([:]) { (acc : [String:String], kv : (String, JSON)) -> [String:String] in
                let (k,v) = kv
                if v.string != nil {
                    var acc2 = acc
                    acc2[k] = v.string
                    return acc2
                }
                return acc
            }
        }
        return nil
    }
    .reduce([]) { (acc : [[String:String]], cur:[String : String]?) -> [[String:String]] in
        if cur != nil {
            var acc2 = acc
            acc2.append(cur!)
            return acc2
        }
        return acc
    }

extension Movie : CustomStringConvertible {
    public var description : String {
        get {
            return "Movie: " + self.title + ", " + (self.imageURL != nil ? "has image" : "no image")
        }
    }
}

let movies = entries?.map { Movie(dictionary: $0) }
movies?.forEach { print($0) }

let m = movies![0]

let mirror = Mirror(reflecting: m)

print("\(mirror.children)")
mirror.children.forEach { print("\($0) : \($1)") }






