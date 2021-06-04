//
//  WebViewController.swift
//  AndersonGonzalez-lab4FinalVersion
//
//  Created by Anderson Gonzalez on 7/19/20.
//  Copyright © 2020 Anderson Gonzalez. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView


class WebViewController: UIViewController{
   
    
   
    @IBOutlet weak var theVideoView: WKYTPlayerView!
    
    
    var theURLString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if theURLString != ""
        {
            theVideoView.load(withVideoId: theURLString)
        }
            // Do any additional setup after loading the view.
    }
    
    
       
   

}
