//
//  MovieRequest.swift
//  AndersonGonzalez-lab4FinalVersion
//
//  Created by Anderson Gonzalez on 7/17/20.
//  Copyright © 2020 Anderson Gonzalez. All rights reserved.
//

import Foundation
import UIKit

struct MovieRequest{
    var movieURL: URL?
    let API_Key:String = "74f6ede38ece76b9481712023a6e7a80"
   
    init(movieTitle:String){
        let spaceRemoved = self.spaceChanged(movieString: movieTitle)
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(self.API_Key)&language=en-US&query=\(spaceRemoved)&page=1&include_adult=false"
        guard let url = URL(string:urlString) else {
            print("Error Invalid URL")
            return }
        self.movieURL = url
    }
    //proper url must replace spaces for %20
    func spaceChanged(movieString: String)->String{
        var newstring = ""
        for char in movieString{
            if(char == " ")
            {
                newstring.append("%20")
            }
            else{
                newstring.append(char)
            }
        }
        return newstring
    }
}
