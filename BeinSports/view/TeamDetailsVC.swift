//
//  TeamDetailsVC.swift
//  BeinSports
//
//  Created by mo_fathy on 04/05/2023.
//

import UIKit

class TeamDetailsVC: UIViewController {
    var team : Teams?
    var players :[Player]?
    @IBOutlet weak var teamImg: UIImageView!
    @IBOutlet weak var teamNameLab: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        players = team?.players
        teamNameLab.text=team?.team_name
        teamImg.sd_setImage(with: URL(string: team?.team_logo ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "PlayersTableCell", bundle: nil), forCellReuseIdentifier: "PlayersTableCell")
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
        return players?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersTableCell", for: indexPath) as! PlayersTableCell
 
        cell.namePlayer.text = players?[indexPath.row].player_name
        cell.numberPlayer.text = players?[indexPath.row].player_number
        cell.img.sd_setImage(with: URL(string: players?[indexPath.row].player_image ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "FixturesVC" ) as! FixturesVC
//        vc.leagueId = String(describing: arrLeagues[indexPath.row].league_key!)
//        vc.sport=sport
//        navigationController? .pushViewController(vc , animated : true )
//    }
}
