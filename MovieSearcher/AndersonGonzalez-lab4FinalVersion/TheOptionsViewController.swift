//
//  TheOptionsViewController.swift
//  AndersonGonzalez-lab4FinalVersion
//
//  Created by Anderson Gonzalez on 7/19/20.
//  Copyright © 2020 Anderson Gonzalez. All rights reserved.
//

import UIKit

class TheOptionsViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet weak var moviesCollection: UICollectionView!
    
   
    var theOptionURL:URL?
    
    //all the data needed from API
         struct APIResults:Decodable {
             let page: Int
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
     
      
     
      
         
         //all the elements needed to store data
         var theFullData: APIResults?
         var theData:[Movie] = []
         var theImageCache: [UIImage] = []
         var theImageLink: [String] = []
         
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
          retriveallData()
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
      func fetchSearchData(){
          do{
            let data = try Data(contentsOf: self.theOptionURL!)
              self.theFullData = try JSONDecoder().decode(APIResults.self, from: data)
              self.theData = self.theFullData!.results
          }catch{ print("the was an error retriving data") }
      }

      
    
    
      
      
      //set up the data:
      func retriveallData(){
          print("About to retrive data")
          DispatchQueue.global(qos: .userInitiated).async {
              self.fetchSearchData()
              self.cacheImages()
          DispatchQueue.main.async {
              print(self.theImageLink)
              print(self.theData.count)
              print(self.theImageCache.count)
              self.moviesCollection.reloadData()
              }
            }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
