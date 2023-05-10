//
//  LeaguesTableVC.swift
//  BeinSports
//
//  Created by mo_fathy on 02/05/2023.
//

import UIKit
import Alamofire

class LeaguesTableVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let imageView = UIImageView(image: UIImage(named: "noresult2"))
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searcgBar: UISearchBar!
    var searchActive : Bool = false
    var arrLeagues = [Result]()
    var filtered=[Result]()
    var sport:String = "football"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!Utls.hasConnectivity()){
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            }))
                    self.present(alert, animated: true, completion: nil)

        }else{
            title = "\(sport) Leagues"
            tableView.register(UINib(nibName: "CustomTableCell", bundle: nil), forCellReuseIdentifier: "CustomTableCell")
            
            let protocolVar : PresenterLeaguesTableVC = PresenterLeaguesTableVC(protocolVar: self)
            protocolVar.getLeagues(sport: sport)
        }
      
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

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 1
        }
       
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let v = UIView()
            v.backgroundColor = UIColor.clear
            return v;
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
         cell.imgView.downloadImage(url: data.league_logo, placeHolder: UIImage(named: sport))
       // cell.imgView.sd_setImage(with: URL(string: data.league_logo ?? ""), placeholderImage: UIImage(named: sport))
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



extension LeaguesTableVC : ProtocolLeaguesTableVC{
    
    func getLeagues(resultsResult: ResultsResult?) {
        self.arrLeagues=resultsResult?.result ?? [Result]()
        DispatchQueue.main.async {
            if(self.arrLeagues.count == 0){
                self.imageView.contentMode = .scaleAspectFit
                
                self.tableView.backgroundView = self.imageView
            }else{
                self.tableView.backgroundView = .none
                
                self.tableView.reloadData()
                
            }
        }
    }
    
    
}
