//
//  TeamDetailsVC.swift
//  BeinSports
//
//  Created by mo_fathy on 04/05/2023.
//

import UIKit
import Alamofire

class PlayerDetailsVC: UIViewController {
    
    var fromNetwork = false
    var player : Player?
    var des :[String]?
    var sport:String = ""
    var playerId:String = ""
    
    @IBOutlet weak var favButton: UIBarButtonItem!
    @IBOutlet weak var teamImg: UIImageView!
    @IBOutlet weak var teamNameLab: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    var protocolVar : PresenterPlayerDetailsVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        if (!Utls.hasConnectivity()){
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            }))
                    self.present(alert, animated: true, completion: nil)

        }else{
            des = [String]()
            protocolVar = PresenterPlayerDetailsVC(protocolVar: self)
            favButton.isHidden = fromNetwork
            protocolVar!.callPlayerApi(sport: sport, playerId: playerId)
        }
    
    
    }

    @IBAction func favClick(_ sender: Any) {
        favButton.isEnabled = false
        favButton.image = UIImage(systemName: "star.fill")
        
        
      var logo = ""
        if(sport == "tennis"){
            logo = player?.player_logo ?? ""
        }else{
           logo = player?.player_image ?? ""
        }
        
        protocolVar!.insertPlayer(key:  player?.player_key ?? 0 , name: player?.player_name ?? "", logo: logo, sport: sport)
        Utls.showToast(view: self.view, text: "added to favorites")
    }
  
}

extension PlayerDetailsVC:UITableViewDelegate,UITableViewDataSource{

    
    override func viewWillLayoutSubviews() {
        self.tableViewheight.constant = self.tableView.contentSize.height
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return des?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
 
        cell.textLabel?.text = des?[indexPath.row]
     
        return cell
    }
    

}


extension PlayerDetailsVC  {
   
   
    
    

    
    func getDes(player: Player?){
        if let player = player {
            if(sport == "tennis"){
         
                if let player_country = player.player_country{
                    des?.append("player country : \(player_country)")
                }
                
                if let player_bday = player.player_bday{
                    des?.append("player bday : \(player_bday)")
                }
                
            }
            //MARK: -
            else{
                
                if let player_number = player.player_number{
                    des?.append("player number : \(player_number)")
                }
                
                if let team_name = player.team_name{
                    des?.append("team name : \(team_name)")
                }
                
                if let player_type = player.player_type{
                    des?.append("player type : \(player_type)")
                }
                if let player_country = player.player_country{
                    des?.append("player country : \(player_country)")
                }
                if let player_age = player.player_age{
                    des?.append("player age : \(player_age)")
                }
                if let player_goals = player.player_goals{
                    des?.append("player goals : \(player_goals)")
                }
                if let player_bday = player.player_bday{
                    des?.append("player bday : \(player_bday)")
                }
                if let player_yellow_cards = player.player_yellow_cards{
                    des?.append("player yellow cards : \(player_yellow_cards)")
                }
                if let player_red_cards = player.player_red_cards{
                    des?.append("player red cards : \(player_red_cards)")
                }
                if let player_assists = player.player_assists{
                    des?.append("player assists : \(player_assists)")
                }
                if let player_minutes = player.player_minutes{
                    des?.append("player minutes : \(player_minutes)")
                }
                if let player_match_played = player.player_match_played{
                    des?.append("player match played : \(player_match_played)")
                }
                if let player_is_captain = player.player_is_captain{
                    des?.append("player is captain : \(player_is_captain)")
                }
                if let player_shots_total = player.player_shots_total{
                    des?.append("player shots total : \(player_shots_total)")
                }
                if let player_goals_conceded = player.player_goals_conceded{
                    des?.append("player goals conceded : \(player_goals_conceded)")
                }
                if let player_fouls_commited = player.player_fouls_commited{
                    des?.append("player fouls commited : \(player_fouls_commited)")
                }
                if let player_tackles = player.player_tackles{
                    des?.append("player tackles : \(player_tackles)")
                }
                if let player_blocks = player.player_blocks{
                    des?.append("player blocks : \(player_blocks)")
                }

            
            }
        }
        self.tableView.reloadData()
    }
}


extension PlayerDetailsVC : ProtocolPlayerDetailsVC{
    func getPlayerApi(playerResult: PlayerResult?) {
        self.player = playerResult?.result?.first
        self.getDes(player: self.player)
        
        self.teamNameLab.text=self.player?.player_name
        if(sport == "tennis"){
            self.teamImg.sd_setImage(with: URL(string: self.player?.player_logo ?? ""), placeholderImage: UIImage(named: self.sport))
        }else{
            self.teamImg.sd_setImage(with: URL(string: self.player?.player_image ?? ""), placeholderImage: UIImage(named: self.sport))
        }
       
        if( protocolVar?.isFav(key: player!.player_key!) ?? false){
            favButton.isEnabled = false
            favButton.image = UIImage(systemName: "star.fill")
        }

    }
    
    
    
    
}
