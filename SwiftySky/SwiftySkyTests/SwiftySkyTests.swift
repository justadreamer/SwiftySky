//
//  SwiftySkyTests.swift
//  SwiftySkyTests
//
//  Created by Eugene Dorfman on 1/9/16.
//  Copyright © 2016 justadreamer. All rights reserved.
//

import XCTest
@testable import SwiftySky
import SkyScraper
import SwiftyJSON

/*
xsltproc --html -xincludestyle -xinclude SwiftySky/XSLT/main.xsl SwiftySkyTests/fandango.html | jsonlint
*/

class SwiftySkyTests: XCTestCase {
    func testXSLTScraping() {
        let bundle = NSBundle(forClass: self.classForCoder)

        guard let xsltURL = bundle.URLForResource("XSLT/main", withExtension: "xsl") else {
            XCTFail("no xslt")
            return
        }
    
        guard let t = SkyXSLTransformation(XSLTURL: xsltURL) else {
            XCTFail("no transformation")
            return
        }
        
        guard let htmlURL = bundle.URLForResource("fandango", withExtension: "html") else {
            XCTFail("no html")
            return
        }

        let html = NSData(contentsOfFile:htmlURL.path!)
        
        XCTAssertNotNil(html)
        XCTAssertTrue(html!.length>0)
        
        do {
            let jsonObject : NSDictionary = try t.JSONObjectFromHTMLData(html, withParams:[:]) as! NSDictionary
            XCTAssertNotNil(jsonObject)
            XCTAssertTrue(jsonObject.count>0)
            
            let json = JSON(jsonObject)
            XCTAssertEqual(json["entries"][0]["title"].string!, "Star Wars: The Force Awakens")
            XCTAssertEqual(json["entries"].count, 8)
            XCTAssertEqual(json["entries"][1]["image_url"], "http://images.fandango.com/r98.9/ImageRenderer/131/200/redesign/static/img/default_poster.png/0/images/masterrepository/fandango/185166/hatefuleight_sm.jpg")
        } catch {
            XCTFail("xslt parsing failed with error: \(error)")
        }
    }
}
