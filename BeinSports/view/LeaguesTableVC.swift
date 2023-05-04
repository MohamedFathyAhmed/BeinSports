//
//  LeaguesTableVC.swift
//  BeinSports
//
//  Created by mo_fathy on 02/05/2023.
//

import UIKit
import Alamofire
import SDWebImage
class LeaguesTableVC: UITableViewController {
    var arrLeagues = [Result]()
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

    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLeagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableCell", for: indexPath) as! CustomTableCell
        cell.countryLabel.text = arrLeagues[indexPath.row].country_name
        cell.nameLabel.text = arrLeagues[indexPath.row].league_name
        
        cell.imgView.sd_setImage(with: URL(string: arrLeagues[indexPath.row].league_logo ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FixturesVC" ) as! FixturesVC
        vc.leagueId = String(describing: arrLeagues[indexPath.row].league_key!)
        vc.sport=sport
        navigationController? .pushViewController(vc , animated : true )
    }
}
