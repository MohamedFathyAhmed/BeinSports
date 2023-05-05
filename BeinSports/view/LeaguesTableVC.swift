//
//  LeaguesTableVC.swift
//  BeinSports
//
//  Created by mo_fathy on 02/05/2023.
//

import UIKit
import Alamofire
import SDWebImage
class LeaguesTableVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searcgBar: UISearchBar!
    var searchActive : Bool = false
    var arrLeagues = [Result]()
    var filtered=[Result]()
    var sport:String = "football"
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(sport) Leagues"
        let param : [String: String] = ["met": "Leagues"]
        APIServices.instance.getDataAll(route: .typy(sport), method: .get, params: param, encoding: URLEncoding.default, headers: nil) { (dataurl: ResultsResult?, error) in
                   self.arrLeagues=dataurl?.result ?? [Result]()
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                   }
               }
        
        tableView.register(UINib(nibName: "CustomTableCell", bundle: nil), forCellReuseIdentifier: "CustomTableCell")
        
      
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive){
            return filtered.count
        }else{
           return arrLeagues.count
        }
        
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var data = Result()
         if(searchActive){
            data = filtered [indexPath.row]
         }else{
             data = arrLeagues [indexPath.row]
         }
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableCell", for: indexPath) as! CustomTableCell
        cell.countryLabel.text = data.country_name
        cell.nameLabel.text = data.league_name
        
        cell.imgView.sd_setImage(with: URL(string: data.league_logo ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         var data = Result()
         if(searchActive){
            data = filtered [indexPath.row]
         }else{
             data = arrLeagues [indexPath.row]
         }
         
        let vc = storyboard?.instantiateViewController(withIdentifier: "FixturesVC" ) as! FixturesVC
        vc.leagueId = String(describing: data.league_key!)
        vc.sport=sport
        navigationController? .pushViewController(vc , animated : true )
    }
}


extension LeaguesTableVC :UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
          searchActive = true
      }

      func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
          searchActive = false
      }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          searchActive = false;

          searchBar.text = nil
          searchBar.resignFirstResponder()
          tableView.resignFirstResponder()
          searchBar.showsCancelButton = false
          tableView.reloadData()
      }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false
        }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
                    return true
        }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText == ""){
            self.searchActive = false;
            searchBar.showsCancelButton = false
            tableView.reloadData()
        }else {
            self.searchActive = true;
            searchBar.showsCancelButton = true
            filtered = arrLeagues.filter({ Result in
                return  Result.league_name!.lowercased().contains(searchText.lowercased())
            })
            tableView.reloadData()
        }
    }

   
    
    
    
    
}

