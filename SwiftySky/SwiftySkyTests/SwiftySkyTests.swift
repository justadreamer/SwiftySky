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
            let json : NSDictionary = try t.JSONObjectFromHTMLData(html, withParams:[:]) as! NSDictionary
            XCTAssertNotNil(json)
            XCTAssertTrue(json.count>0)
        } catch {
            XCTFail("xslt parsing failed with error: \(error)")
        }
    }
}
