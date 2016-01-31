//
//  ImageLoader.swift
//  SwiftySky
//
//  Created by Eugene Dorfman on 1/31/16.
//  Copyright © 2016 justadreamer. All rights reserved.
//

import Foundation
import UIKit

typealias ImageLoaderResultCallback = UIImage? -> Void

class ImageLoader {
    private var callback: ImageLoaderResultCallback?

    private var task : NSURLSessionDataTask?

    init (callback: ImageLoaderResultCallback) {
        self.callback = callback
    }

    func load(URL: NSURL) {
        self.task?.cancel()
        self.task = NSURLSession.sharedSession().dataTaskWithURL(URL) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            guard let responseData = data else {
                print("error: \(error)")
                self.notify(nil)
                return
            }

            self.notify(UIImage(data: responseData))
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }

    private func notify(image: UIImage?) {
        dispatch_async(dispatch_get_main_queue()) {
            self.callback?(image)
        }
    }
}
