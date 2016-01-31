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

enum MoviesLoaderResult {
    case Movies([Movie])
    case Error(String)
}

class MoviesLoader {
    private var callback : (MoviesLoaderResult -> Void)?

    init (callback: MoviesLoaderResult -> Void) {
        self.callback = callback
    }

    func load() {
        let URL = NSURL(string: "http://www.fandango.com")!
        let XSLTURL = NSBundle.mainBundle().URLForResource("XSLT/main", withExtension: "xsl")!
        let t = SkyXSLTransformation(XSLTURL: XSLTURL)!
        
        NSURLSession.sharedSession().dataTaskWithURL(URL) { (data : NSData?, response : NSURLResponse?, error : NSError?) -> Void in
            guard let responseData = data else {
                self.notify(MoviesLoaderResult.Error(error?.localizedDescription ?? ""))
                return
            }

            do {
                let jsonObject = try t.JSONObjectFromXMLData(responseData, withParams: [:])
                let json = JSON(jsonObject)
                if let entries = json["entries"].array {
                    let result = MoviesLoaderResult.Movies(Movie.array(from: entries))
                    self.notify(result)
                }
            } catch let e as NSError {
                print("error:\(e)")
                self.notify(MoviesLoaderResult.Error(e.localizedDescription))
            }
        }.resume()
    }
    
    /**
     Is called implicitly when the movies list is updated.  
     Call explicitly in the event of error.
     */

    private func notify(result: MoviesLoaderResult) {
        dispatch_async(dispatch_get_main_queue()) {
            self.callback?(result)
        }
    }
}
