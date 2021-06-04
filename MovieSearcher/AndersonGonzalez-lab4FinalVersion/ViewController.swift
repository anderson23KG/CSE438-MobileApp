//
//  ViewController.swift
//  AndersonGonzalez-lab4FinalVersion
//
//  Created by Anderson Gonzalez on 7/17/20.
//  Copyright © 2020 Anderson Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    

    
    @IBOutlet weak var moviesCollection: UICollectionView!
    
    @IBOutlet weak var movieGeneralSearch: UISearchBar!
    
    
    @IBOutlet weak var theSpinner: UIActivityIndicatorView!
    
    //all the data needed from API
       struct APIResults:Decodable {
           let page: Int
           let total_results: Int
           let total_pages: Int
           let results: [Movie]
       }
       
       struct Movie:Decodable {
           let id: Int!
           let poster_path: String?
           let title: String
           let release_date: String
           let vote_average: Double
           //let overview: String
           let vote_count:Int!
       }
    struct DetailsofMovie:Decodable{
        let budget:Int
        let genres:[Genres]
    }
    struct Genres:Decodable{
        let id:Int
        let name:String
    }
    
   /* struct ReleaseDates:Decodable{
        let id: Int!
        let results: [Unwanted]
    }
    
    struct Unwanted:Decodable{
        let iso_3166_1: String?
        let release_dates: [MovieDates]
    }
    struct MovieDates:Decodable{
        let certification: String
        let iso_639_1: String
        let release_date: String
        let type: Int
        let note:String
    }*/
    
    
       
       //all the elements needed to store data
       var theFullData: APIResults?
       var theData:[Movie] = []
       var theImageCache: [UIImage] = []
       var theImageLink: [String] = []
       var theDetails:DetailsofMovie?
       
       //all the global variables
       private let sectionInsets = UIEdgeInsets(top: 0,
       left: 15.0,
       bottom: 0,
       right: 15.0)
       private var itemsPerRow = 3
       let sample = UIImage(named: "sampleImage")
   
    
    //loading View
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        moviesCollection.delegate = self
        moviesCollection.dataSource = self
        movieGeneralSearch.delegate = self
        theSpinner.hidesWhenStopped = true
        //retriveallData()
    }
    
    //add to favorites
    func addToFaves(movie_Title:String) {
        print("I am in button method")
        // Access Shared Defaults Object
        let userDef = UserDefaults.standard
        
        // Get my favorites list
        var myFavorites: [String] = userDef.stringArray(forKey: "myFavs") ?? []
        print(myFavorites.count)
        //check if the movie is alreayd in my favorites
        if(myFavorites.count != 0){
            if myFavorites.contains(movie_Title){
                print("movie already in my favorites")
            }
            else{
                myFavorites.append(movie_Title)
                print(myFavorites.count)
            }
        }
        else{
            myFavorites.append(movie_Title)
            print("the new size =\(myFavorites.count)")
        }
        // Save in favorites
        userDef.set(myFavorites, forKey: "myFavs")
        userDef.synchronize()
        print("Done with Button method")
    }
    
    //cache Images
    func cacheImages(){
        let baseUrlSize = "https://image.tmdb.org/t/p/w500"
        for item in theData {
            if(item.poster_path != nil)
            {
                let urlString = baseUrlSize + item.poster_path!
                self.theImageLink.append(urlString)
                let urlImage = URL(string:urlString)
                do{
                    let data = try Data(contentsOf:urlImage!)
                    let image = UIImage(data: data)
                    self.theImageCache.append(image!)
                    print(urlString)
                }catch{print("something went wrong with url")}
            }
            else{
                self.theImageLink.append("")
                self.theImageCache.append(self.sample!)
            }
        }
    }
    
    //fetch the Movie information
    func fetchSearchData(movieName: String){
        let movieRequest = MovieRequest(movieTitle: movieName)
        do{
            let data = try Data(contentsOf: movieRequest.movieURL!)
            self.theFullData = try JSONDecoder().decode(APIResults.self, from: data)
            self.theData = self.theFullData!.results
        }catch{ print("the was an error retriving data") }
    }

    
  
    func MovieDetails(movieId:Int){
        let requestUrl = MovieDetailsRequest(movieID: movieId)
        do{
            let data = try Data(contentsOf: requestUrl.requestURL!)
            self.theDetails = try JSONDecoder().decode(DetailsofMovie.self, from: data)
            print(data)
        }catch{ print("the was an error retriving data") }
    }
    
    
    //set up the data:
    func retriveallData(){
        print("About to retrive data")
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchSearchData(movieName: "Airbender")
            self.cacheImages()
        DispatchQueue.main.async {
            print(self.theImageLink)
            print(self.theData.count)
            print(self.theImageCache.count)
            self.moviesCollection.reloadData()
            }
          }
    }
    
    func displayGenres(theMovieGenres:[Genres])->String
    {
        
        var genres: String = ""
        var newArray:[String] = []
        if theMovieGenres.count != 0
        {
            for item in theMovieGenres{
                newArray.append(item.name)
            }
            genres = newArray.joined(separator: ",")
        }
        return genres
    }
    
    //all code used to cet up cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.theData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! CollectionViewCell
        cell.theImage.image = theImageCache[indexPath.row]
        cell.theLabel.text = theData[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets{
        return sectionInsets
    }
    
    //size of cells
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize{
        let paddingSpace = sectionInsets.left * CGFloat(itemsPerRow + 1)
        let availableWidth = view.frame.width-paddingSpace
        let widthPerItem = availableWidth/CGFloat(itemsPerRow)
        let availableHeight =  moviesCollection.bounds.height
        let heightPerItem = availableHeight/3
        return CGSize(width:widthPerItem, height: heightPerItem)
    }
    
    //minimum line spacing
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt: Int) -> CGFloat{
        return 5
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("About to retrive data")
        if(movieGeneralSearch.text != nil){
            self.theImageCache = []
            let stringToPass = movieGeneralSearch.text!
            self.theSpinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                self.fetchSearchData(movieName: stringToPass)
                self.cacheImages()
            DispatchQueue.main.async {
                print(self.theImageLink)
                print(self.theData.count)
                print(self.theImageCache.count)
                self.moviesCollection.reloadData()
                self.theSpinner.stopAnimating()
                if(self.theData.count == 0)
                {
                    self.movieGeneralSearch.text = "No movies found!"
                }
                }
              }
        }
        else{
            print("there was an error")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("About to fetch Movie details")
        self.theSpinner.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            self.MovieDetails(movieId: self.theData[indexPath.row].id)
            DispatchQueue.main.async {
                       print("done fetching Data")
                       self.theSpinner.stopAnimating()
                       let theInt = self.theDetails?.budget
                       let theSize = self.theDetails?.genres.count
                       print("theBudget was: \(theInt!), size: \(theSize!)")
                let detailedVC = self.storyboard?.instantiateViewController(identifier: "DetialedViewController") as? DetailedViewController
                detailedVC?.movieTitle = self.theData[indexPath.row].title
                detailedVC?.theImage = self.theImageCache[indexPath.row]
                detailedVC?.releaseD = self.theData[indexPath.row].release_date
                detailedVC?.vote_Avg = Int(self.theData[indexPath.row].vote_average)
                detailedVC?.theMovieGenres = self.displayGenres(theMovieGenres: self.theDetails!.genres)
                detailedVC?.theMovieId = self.theData[indexPath.row].id
                self.navigationController?.pushViewController(detailedVC!, animated: true)
                       }
                     }
        
    }
    
    /*the function could have been accomplished without the turotial provided by this link
    https://medium.com/better-programming/ios-context-menu-collection-view-a03b032fe330*/
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
         let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil){ action in
                let favoritesMenu = UIAction(title: "Add to Favorite", image: UIImage(named: "favorites"), identifier: UIAction.Identifier(rawValue: "favorites")) {_ in
                    self.addToFaves(movie_Title: self.theData[indexPath.row].title)
                        print("button clicked..")
            }
            return UIMenu(title: self.theData[indexPath.row].title, image: nil, identifier: nil, children: [favoritesMenu])
        }
    return configuration
    }
}

