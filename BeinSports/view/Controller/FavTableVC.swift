//
//  LeaguesTableVC.swift
//  BeinSports
//
//  Created by mo_fathy on 02/05/2023.
//

import UIKit
import Alamofire
import ReachabilitySwift

class FavTableVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searcgBar: UISearchBar!
    var imageView = UIImageView(image: UIImage(named: "empty"))
    
    var searchActive : Bool = false
    var arrTeams = [DBTeam]()
    var filteredTeams=[DBTeam]()
    var protocolVar : PresenterFavTableVC?
    var arrPlayers = [DBPlayer]()
    var filteredPlayers=[DBPlayer]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableCell", bundle: nil), forCellReuseIdentifier: "CustomTableCell")
        protocolVar  = PresenterFavTableVC(protocolVar: self)
        
      
    }
    
  
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
       return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0 :
            return ""
        default:
            return "players"
        }
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         switch section{
         case 0 :
             if(arrTeams.count == 0 && arrPlayers.count == 0 ){
                 imageView.contentMode = .scaleAspectFit
                 tableView.backgroundView = imageView
             }else{
                 tableView.backgroundView = .none
             }
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            switch indexPath.section{
            case 0 :
                var data :DBTeam?
                if(self.searchActive){
                    data = self.filteredTeams [indexPath.row]
                }else{
                    data = self.arrTeams [indexPath.row]
                }
                let alertController = UIAlertController(title: "Delete", message: "Are you sure you want to delete this Team ?", preferredStyle: .alert)

                let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                    self.protocolVar!.deleteTeam(data: data!)
                    self.arrTeams.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with:.fade)
                //    tableView.reloadData()
                }

                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                   
                }

                alertController.addAction(deleteAction)
                alertController.addAction(cancelAction)

                self.present(alertController, animated: true, completion: nil)
              
            default:
                var data :DBPlayer?
                if(self.searchActive){
                    data = self.filteredPlayers [indexPath.row]
                }else{
                    data = self.arrPlayers [indexPath.row]
                }
                let alertController = UIAlertController(title: "Delete", message: "Are you sure you want to delete this Player ?", preferredStyle: .alert)

                let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                    self.protocolVar!.deletePlayer( data: data!)
                    self.arrPlayers.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with:.fade)
                   // tableView.reloadData()
                }

                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                }
                alertController.addAction(deleteAction)
                alertController.addAction(cancelAction)

                self.present(alertController, animated: true, completion: nil)
            }
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
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
extension FavTableVC :ProtocolFavTableVC {
    
    
}

extension FavTableVC:  NetworkStatusListener{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchActive=false
        tableView.reloadData()
        arrTeams = (protocolVar?.getTeams())!
        arrPlayers = (protocolVar?.getPlayers())!
        tableView.reloadData()
        ReachabilityManager.shared.addListener(listener: self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ReachabilityManager.shared.removeListener(listener: self)
    }
  
    func networkStatusDidChange(status: Reachability.NetworkStatus) {
        switch status {
             case .notReachable:
                 debugPrint("ViewController: Network became unreachable")
            DispatchQueue.main.async {
                Utls.showToast(view: self.view, text: "offline")
            }
             case .reachableViaWiFi , .reachableViaWWAN:
                 debugPrint("ViewController: Network reachable through WiFi")
            DispatchQueue.main.async {
                Utls.showToast(view: self.view, text: "online")
            }
       
             }
         }
  
    
}



