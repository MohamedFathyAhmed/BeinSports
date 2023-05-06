//
//  LeaguesTableVC.swift
//  BeinSports
//
//  Created by mo_fathy on 02/05/2023.
//

import UIKit
import Alamofire
import SDWebImage
class FavTableVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searcgBar: UISearchBar!
    var searchActive : Bool = false
    var arrTeams = [DBTeam]()
    var filteredTeams=[DBTeam]()
    
    var arrPlayers = [DBPlayer]()
    var filteredPlayers=[DBPlayer]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableCell", bundle: nil), forCellReuseIdentifier: "CustomTableCell")
        
        //var protocolVar : PresenterLeaguesTableVC = PresenterLeaguesTableVC(protocolVar: self)
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchActive=false
        tableView.reloadData()
        arrTeams = CoreData.shared.readTeams()
        arrPlayers = CoreData.shared.readPlayers()
        tableView.reloadData()
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
       return 2
    }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section{
//        case 0 :
//            return "teams"
//        default:
//            return "players"
//        }
//    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         switch section{
         case 0 :
             if(searchActive){
                return filteredTeams.count
            }else{
               return arrTeams.count
            }
         case 1 :
             if(searchActive){
                return filteredPlayers.count
            }else{
               return arrPlayers.count
            }
         default:
             return 0
         }
       
        
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableCell", for: indexPath) as! CustomTableCell
         
         switch indexPath.section{
         case 0 :
             var data :DBTeam?
             if(searchActive){
                data = filteredTeams [indexPath.row]
             }else{
                 data = arrTeams [indexPath.row]
             }
             
           cell.countryLabel.text = data?.sport
             cell.nameLabel.text = data?.name
             cell.imgView.sd_setImage(with: URL(string: data?.logo ?? ""), placeholderImage: UIImage(named: data?.sport ?? "placeholder"))
         default :
             var data :DBPlayer?
             if(searchActive){
                data = filteredPlayers [indexPath.row]
             }else{
                 data = arrPlayers [indexPath.row]
             }
             
           cell.countryLabel.text = data?.sport
             cell.nameLabel.text = data?.name
             cell.imgView.sd_setImage(with: URL(string: data?.logo ?? ""), placeholderImage: UIImage(named: data?.sport ?? "placeholder"))
         }
         
       
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         switch indexPath.section{
         case 0 :
             
             var data :DBTeam?
             if(searchActive){
                 data = filteredTeams [indexPath.row]
             }else{
                 data = arrTeams [indexPath.row]
             }
             
             let vc = storyboard?.instantiateViewController(withIdentifier: "TeamDetailsVC" ) as! TeamDetailsVC
             vc.fromNetwork = true
             vc.sport=data?.sport ?? ""
             vc.teamId = String(describing: data!.key)
           
             navigationController? .pushViewController(vc , animated : true )
         default:
             var data :DBPlayer?
             if(searchActive){
                 data = filteredPlayers [indexPath.row]
             }else{
                 data = arrPlayers [indexPath.row]
             }
             
             let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerDetailsVC" ) as! PlayerDetailsVC
             vc.fromNetwork = true
             vc.sport = data?.sport ?? ""
             vc.playerId = String(describing: data!.key)
             
             navigationController? .pushViewController(vc , animated : true )

         }
    }
}


extension FavTableVC :UISearchBarDelegate{
    
  
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          searchActive = false

          searchBar.text = nil
          searchBar.resignFirstResponder()
          tableView.resignFirstResponder()
          searchBar.showsCancelButton = false
          tableView.reloadData()
      }

    

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
                    return true
        }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText == ""){
            self.searchActive = false
            searchBar.showsCancelButton = false
            tableView.reloadData()
        }else {
            self.searchActive = true
            searchBar.showsCancelButton = true
            filteredTeams = arrTeams.filter({ Result in
                return  Result.name!.lowercased().contains(searchText.lowercased())
            })
            filteredPlayers = arrPlayers.filter({ Result in
                return  Result.name!.lowercased().contains(searchText.lowercased())
            })
            tableView.reloadData()
        }
    }

   
    
    
    
    
}




