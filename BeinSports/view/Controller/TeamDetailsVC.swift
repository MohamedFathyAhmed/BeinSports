//
//  TeamDetailsVC.swift
//  BeinSports
//
//  Created by mo_fathy on 04/05/2023.
//

import UIKit
import SDWebImage
class TeamDetailsVC: UIViewController {
    var fromNetwork = false
    var team : Teams?
    var arrPlayers :[Player]?
    var sport:String = ""
    var teamId:String = ""
    var protocolVar : PresenterTeamDetailsVC?
    @IBOutlet weak var favButton: UIBarButtonItem!
    @IBOutlet weak var teamImg: UIImageView!
    @IBOutlet weak var teamNameLab: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (!Utls.hasConnectivity()){
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            }))
                    self.present(alert, animated: true, completion: nil)

        }else{
            tableView.register(UINib(nibName: "PlayersTableCell", bundle: nil), forCellReuseIdentifier: "PlayersTableCell")
            
            favButton.isHidden = fromNetwork
            protocolVar = PresenterTeamDetailsVC(protocolVar: self)
            if(fromNetwork){
                protocolVar?.callTeamApi(sport: sport, teamId: teamId)
                
            }else{
                arrPlayers = team?.players
                teamNameLab.text=team?.team_name
                teamImg.sd_setImage(with: URL(string: team?.team_logo ?? ""), placeholderImage: UIImage(named: sport))
                if( self.protocolVar?.isFav(key: self.team!.team_key!) ?? false){
                    self.favButton.isEnabled = false
                    self.favButton.image = UIImage(systemName: "star.fill")
                }
            }
        }
    }

    @IBAction func favClick(_ sender: Any) {
        favButton.isEnabled = false
        favButton.image = UIImage(systemName: "star.fill")
        
        
        protocolVar!.insertTeam(key:  team?.team_key ?? 0 , name: team?.team_name ?? "", logo: team?.team_logo ?? "", sport: sport)
        Utls.showToast(view: self.view, text: "added to favorites")
    }
}

extension TeamDetailsVC:UITableViewDelegate,UITableViewDataSource{

    
    override func viewWillLayoutSubviews() {
        self.tableViewheight.constant = self.tableView.contentSize.height
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPlayers?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersTableCell", for: indexPath) as! PlayersTableCell
 
        cell.namePlayer.text = arrPlayers?[indexPath.row].player_name
        cell.numberPlayer.text = arrPlayers?[indexPath.row].player_number
        cell.img.downloadImage(url: arrPlayers?[indexPath.row].player_image, placeHolder:  UIImage(named: sport))
       // cell.img.sd_setImage(with: URL(string: arrPlayers?[indexPath.row].player_image ?? ""), placeholderImage: UIImage(named: sport))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerDetailsVC" ) as! PlayerDetailsVC
        vc.sport=sport
        vc.playerId = String(describing:  arrPlayers![indexPath.row].player_key!)
        navigationController? .pushViewController(vc , animated : true )
    }
}


extension TeamDetailsVC :ProtocolTeamDetailsVC {
    func getTeamApi(teamsResult: TeamsResult?) {
        self.team = teamsResult?.result?.first ?? Teams()
               DispatchQueue.main.async {
                  
                   self.arrPlayers = self.team?.players
                   self.teamNameLab.text=self.team?.team_name
                   self.teamImg.sd_setImage(with: URL(string: self.team?.team_logo ?? ""), placeholderImage: UIImage(named: self.sport))
                   self.tableView.reloadData()
                
                   if( self.protocolVar?.isFav(key: self.team!.team_key!) ?? true){
                       self.favButton.isEnabled = false
                       self.favButton.image = UIImage(systemName: "star.fill")
                   }
               }
     
    }
    
    
}
