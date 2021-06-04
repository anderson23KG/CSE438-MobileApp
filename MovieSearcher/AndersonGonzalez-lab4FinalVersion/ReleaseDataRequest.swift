//
//  ReleaseDataRequest.swift
//  AndersonGonzalez-lab4FinalVersion
//
//  Created by Anderson Gonzalez on 7/18/20.
//  Copyright © 2020 Anderson Gonzalez. All rights reserved.
//

import Foundation
import UIKit

struct MovieDetailsRequest{
     var requestURL: URL?
     let API_Key:String = "74f6ede38ece76b9481712023a6e7a80"
    
    init(movieID:Int){
      let urlString  =  "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(API_Key)&language=en-US"
        guard let url = URL(string:urlString) else {
            print("Error Invalid URL")
                return }
        self.requestURL = url
            }
}
