//
//  DetailedViewController.swift
//  AndersonGonzalez-lab4FinalVersion
//
//  Created by Anderson Gonzalez on 7/18/20.
//  Copyright © 2020 Anderson Gonzalez. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    var theMovieData: MovieVideos?
    //var theVideoResults: [VideoDetails]
      var theVideoCodes : [String] = []
      var thekey: String  = ""
      struct MovieVideos:Decodable{
          var id:Int
          var results:[VideoDetails]
          
      }
      struct VideoDetails:Decodable{
          var key:String
          var name:String
          var site:String
          var size:Int
      }
    
    
    
    var urlRequestArray : [URLRequest] = []
    var movieTitle: String = "No name"
    var theImage: UIImage = UIImage(named: "sampleImage")!
    var releaseD: String = "Hello"
    var vote_Avg: Int = 0
    var theMovieGenres: String = "Hello3"
    var theMovieId: Int = 0
    
    @IBOutlet weak var detailedImage: UIImageView!
    
    @IBOutlet weak var relasedDate: UILabel!
    
    @IBOutlet weak var score: UILabel!
    
    
    @IBOutlet weak var theGenre: UILabel!
   
    
    @IBOutlet weak var addtoFavorites: UIButton!
    
    
    @IBOutlet weak var playVideoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieTitle
        detailedImage.image = theImage
        relasedDate.text = "Released:  "+releaseD
        score.text = "Score:  \(vote_Avg)/10"
        theGenre.text = "Genre: "+theMovieGenres
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func addToFaves(_ sender: Any) {
        print("I am in button method")
        // Access Shared Defaults Object
        let userDef = UserDefaults.standard
        
        // Get my favorites list
        var myFavorites: [String] = userDef.stringArray(forKey: "myFavs") ?? []
        print(myFavorites.count)
        //check if the movie is alreayd in my favorites
        if(myFavorites.count != 0){
            if myFavorites.contains(self.title!){
                print("movie already in my favorites")
            }
            else{
                myFavorites.append(self.title!)
                print(myFavorites.count)
            }
        }
        else{
            myFavorites.append(self.title!)
            print("the new size =\(myFavorites.count)")
        }
        // Save in favorites
        userDef.set(myFavorites, forKey: "myFavs")
        userDef.synchronize()
        print("Done with Button method")
    }
    
    
    func videoRequest(movieId:Int){
           let videoURL = RequestVideo(id_movie: movieId)
           do{
               let data = try Data(contentsOf:videoURL.videoURL!)
               self.theMovieData = try JSONDecoder().decode(MovieVideos.self, from: data)
               print(data)
           }catch{ print("the was an error retriving data") }
       }

    func getVideoKey(){
        if(theMovieData != nil)
        {
            if self.theMovieData!.results.count != 0{
                self.thekey = theMovieData!.results[0].key}
        }
    }
    
    @IBAction func TimetoPLayVideo(_ sender: Any) {
        DispatchQueue.global(qos: .userInitiated).async {
                    self.videoRequest(movieId: self.theMovieId)
                        self.getVideoKey()
                 DispatchQueue.main.async {
                    let videoVC = self.storyboard?.instantiateViewController(identifier: "videoView") as? WebViewController
                    if(self.theMovieData?.results.count != 0)
                    {
                        videoVC?.theURLString = self.thekey
                    }
                    self.navigationController?.pushViewController(videoVC!, animated: true)
                            }
                          }
        
    }
}
