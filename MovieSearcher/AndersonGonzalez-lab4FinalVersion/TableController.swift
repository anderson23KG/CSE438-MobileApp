//
//  TableController.swift
//  AndersonGonzalez-lab4FinalVersion
//
//  Created by Anderson Gonzalez on 7/18/20.
//  Copyright © 2020 Anderson Gonzalez. All rights reserved.
//

import UIKit

class TableController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
   
    
    
    @IBOutlet weak var theFavoritesTable: UITableView!
    @IBOutlet weak var theSearchBar: UISearchBar!
    
    let myRefreshControl = UIRefreshControl()
    var currentlysearching = false
    var theData :[String] = []
    var searchData:[String] = []
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentlysearching{
            return searchData.count
        }
        else{
            return theData.count}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "theFavorite", for: indexPath)
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "theFavorite")
        if currentlysearching{
            cell.textLabel?.text = searchData[indexPath.row]
        }
        else{
            cell.textLabel?.text = theData[indexPath.row]}
        return cell
    }
    
    func fetchData(){
        DispatchQueue.global(qos: .userInitiated).async {
        let userDefaults = UserDefaults.standard
            
        // Get my favorites list
        self.theData = userDefaults.stringArray(forKey: "myFavs") ?? []
        DispatchQueue.main.async {
            self.theFavoritesTable.reloadData()
            }
        }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theFavoritesTable.dataSource = self
        theFavoritesTable.delegate = self
        theSearchBar.delegate = self
        theFavoritesTable.register(UITableViewCell.self, forCellReuseIdentifier: "theFavorite")
        myRefreshControl.addTarget(self, action: #selector(TableController.handleRefresh), for: .valueChanged)
        theFavoritesTable.refreshControl = myRefreshControl
        fetchData()
        // Do any additional setup after loading the view.
    }
    @objc func handleRefresh(_sender:UIRefreshControl){
        DispatchQueue.global(qos: .userInitiated).async {
        let userDefaults = UserDefaults.standard
            
        // Get my favorites list
        self.theData = userDefaults.stringArray(forKey: "myFavs") ?? []
        DispatchQueue.main.async {
            self.theFavoritesTable.reloadData()
            self.myRefreshControl.endRefreshing()
            }
        }
    }
    
    func tableView(_ tableView: UITableView,
      commit editingStyle: UITableViewCell.EditingStyle,
      forRowAt indexPath: IndexPath){
        if editingStyle == .delete
        {
            let userDefaults = UserDefaults.standard
            theData.remove(at: indexPath.row)
            userDefaults.set(theData, forKey: "myFavs")
            theFavoritesTable.reloadData()
        }
    }
    
    //this function was implemented thanks to
    //the tutorial video https://youtu.be/wVeX68Iu43E
    //specially in creating the array for the searched items
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchData = theData.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        currentlysearching = true
        theFavoritesTable.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentlysearching = false
        searchBar.text = ""
        theFavoritesTable.reloadData()
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
