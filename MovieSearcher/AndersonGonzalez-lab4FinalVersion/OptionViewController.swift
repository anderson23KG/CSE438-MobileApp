//
//  OptionViewController.swift
//  AndersonGonzalez-lab4FinalVersion
//
//  Created by Anderson Gonzalez on 7/19/20.
//  Copyright © 2020 Anderson Gonzalez. All rights reserved.
//

import UIKit

class OptionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func theTopRated(_ sender: Any) {
        let detailedVC = self.storyboard?.instantiateViewController(identifier: "theOptions") as? TheOptionsViewController
        let urlstring = "https://api.themoviedb.org/3/movie/top_rated?api_key=74f6ede38ece76b9481712023a6e7a80&language=en-US&page=1"
        let theUrl = URL(string: urlstring)
        detailedVC?.theOptionURL = theUrl
        self.navigationController?.pushViewController(detailedVC!, animated: true)
    }
    
    
    @IBAction func theLatest(_ sender: Any) {
        let detailedVC = self.storyboard?.instantiateViewController(identifier: "theOptions") as? TheOptionsViewController
        let urlstring = "https://api.themoviedb.org/3/movie/latest?api_key=74f6ede38ece76b9481712023a6e7a80&language=en-US"
        let theUrl = URL(string: urlstring)
        detailedVC?.theOptionURL = theUrl
        self.navigationController?.pushViewController(detailedVC!, animated: true)
    }
    
    @IBAction func getPopular(_ sender: Any) {
        let detailedVC = self.storyboard?.instantiateViewController(identifier: "theOptions") as? TheOptionsViewController
        let urlstring = "https://api.themoviedb.org/3/movie/popular?api_key=74f6ede38ece76b9481712023a6e7a80&language=en-US&page=1"
        let theUrl = URL(string: urlstring)
        detailedVC?.theOptionURL = theUrl
        self.navigationController?.pushViewController(detailedVC!, animated: true)
    }
    
    @IBAction func getUpcoming(_ sender: Any) {
        let detailedVC = self.storyboard?.instantiateViewController(identifier: "theOptions") as? TheOptionsViewController
              let urlstring = "https://api.themoviedb.org/3/movie/upcoming?api_key=74f6ede38ece76b9481712023a6e7a80&language=en-US&page=1"
              let theUrl = URL(string: urlstring)
              detailedVC?.theOptionURL = theUrl
              self.navigationController?.pushViewController(detailedVC!, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
