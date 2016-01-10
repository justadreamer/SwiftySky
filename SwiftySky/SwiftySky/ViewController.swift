//
//  ViewController.swift
//  SwiftySky
//
//  Created by Eugene Dorfman on 1/9/16.
//  Copyright © 2016 justadreamer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let xsltURL = NSBundle.mainBundle().URLForResource("main", withExtension: "xsl")
        let t = SkyXSLTransformation(XSLTURL: xsltURL)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

