//
//  Loader.swift
//  SwiftySky
//
//  Created by Eugene Dorfman on 1/17/16.
//  Copyright © 2016 justadreamer. All rights reserved.
//

import Foundation
import SkyScraper
import SwiftyJSON

class Loader {
    var movies : [Movie]? {
        didSet {
            guard self.movies != nil else { return }
            notify()
        }
    }

    var callback : (Void -> Void)?

    func toMovie (entry: [String : String]) -> Movie {
        return Movie(dictionary: entry)
    }
    
    func toMovies(entries: [[String : String]]) -> [Movie] {
        return entries.map(toMovie)
    }

    init (callback: Void -> Void) {
        self.callback = callback
    }

    func load() {
        let URL = NSURL(string: "http://fandango.com")!
        let XSLTURL = NSBundle.mainBundle().URLForResource("XSLT/main", withExtension: "xsl")!
        let t = SkyXSLTransformation(XSLTURL: XSLTURL)!
        
        NSURLSession.sharedSession().dataTaskWithURL(URL) { (data : NSData?, response : NSURLResponse?, error : NSError?) -> Void in
            switch data {
                case .Some(let responseData):
                    do {
                        let jsonObject = try t.JSONObjectFromXMLData(responseData, withParams: [:])
                        let json = JSON(jsonObject)
                        if let entries = json["entries"].array {
                            let movies = Movie.array(from: entries)
                            dispatch_async(dispatch_get_main_queue()) {
                                self.movies = movies
                            }
                        }
                    } catch {
                        print("error:\(error)")
                        self.notify()
                    }
                
                case .None:
                    print("error loading: \(error)")
                    self.notify()
            }
        }.resume()
    }
    
    /**
     Is called implicitly when the movies list is updated.  
     Call explicitly in the event of error.
     */

    func notify() {
        if let callback = self.callback {
            callback()
        }
    }
}
