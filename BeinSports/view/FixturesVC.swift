//
//  FixturesVC.swift
//  BeinSports
//
//  Created by mo_fathy on 02/05/2023.
//

import UIKit
import Alamofire
import AVKit
import AVFoundation

class FixturesVC: UIViewController {
    @IBOutlet weak var eventCollection: UICollectionView!
    @IBOutlet weak var teamsCollection: UICollectionView!
    @IBOutlet weak var resultsCollection: UICollectionView!
    var leagueId:String = ""
    var sport:String = ""
    var arrEvent = [Event]()
    var arrResult=[Result]()
    var arrTeams=[Teams]()
    var arrTennisPlayer = [Player]()
    
    var protocolVar : PresenterFixturesTableVC?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        protocolVar = PresenterFixturesTableVC(protocolVar: self)
        
        registerCells()
        protocolVar?.callEventApi(sport: sport)
        protocolVar?.callResultApi(sport: sport)
        protocolVar?.callTeamApi(sport: sport,leagueId: leagueId)
    }
    

   
   
  
    
    
}






//MARK: -UICollectionView
extension FixturesVC :UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case eventCollection:
            return arrEvent.count
        case resultsCollection:
            return arrResult.count
        case teamsCollection:
            if(sport == "tennis"){
                return arrTennisPlayer.count
            }else{
                return arrTeams.count
            }
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            //MARK: -event Cell
        case eventCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCVCell", for: indexPath) as! EventCVCell
            cell.dateLabel.text = arrEvent[indexPath.row].event_date
            cell.timeLabel.text = arrEvent[indexPath.row].event_time
            if(sport == "tennis"){
                cell.homeImageE.sd_setImage(with: URL(string: arrEvent[indexPath.row].event_first_player_logo ?? ""), placeholderImage: UIImage(named: sport))
                cell.awayImageE.sd_setImage(with: URL(string: arrEvent[indexPath.row].event_second_player_logo ?? ""), placeholderImage: UIImage(named: sport))
            
                cell.nameHomeLab.text = arrEvent[indexPath.row].event_first_player
                cell.nameAwayLab.text = arrEvent[indexPath.row].event_second_player
            }else{
                cell.homeImageE.sd_setImage(with: URL(string: arrEvent[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: sport))
                cell.awayImageE.sd_setImage(with: URL(string: arrEvent[indexPath.row].away_team_logo ?? ""), placeholderImage: UIImage(named: sport))
            
                cell.nameHomeLab.text = arrEvent[indexPath.row].event_home_team
                cell.nameAwayLab.text = arrEvent[indexPath.row].event_away_team
            }
            return cell
            
            
            
            
            //MARK: -results Cell
        case resultsCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCVCell", for: indexPath) as! ResultCVCell
            cell.timeLabel.text=arrResult[indexPath.row].event_time
            cell.resultLabel.text = arrResult[indexPath.row].event_final_result
            cell.dateLabel.text = arrResult[indexPath.row].event_date
            
            if(sport == "tennis"){
                cell.awayImage.sd_setImage(with: URL(string: arrResult[indexPath.row].event_second_player_logo ?? ""), placeholderImage: UIImage(named: sport))
                cell.homeImage.sd_setImage(with: URL(string: arrResult[indexPath.row].event_first_player_logo ?? ""), placeholderImage: UIImage(named: sport))
                cell.awayNameLab.text=arrResult[indexPath.row].event_second_player
                cell.homeNameLab.text=arrResult[indexPath.row].event_first_player
                
            }else{
                cell.awayImage.sd_setImage(with: URL(string: arrResult[indexPath.row].event_away_team_logo ?? ""), placeholderImage: UIImage(named: sport))
                cell.homeImage.sd_setImage(with: URL(string: arrResult[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: sport))
                cell.awayNameLab.text=arrResult[indexPath.row].event_away_team
                cell.homeNameLab.text=arrResult[indexPath.row].event_home_team
            }
            return cell
            
            
            //MARK: -teams Cell
        case teamsCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCVCell", for: indexPath) as! TeamCVCell
            if(sport == "tennis"){
                
                cell.teamLabel.text=arrTennisPlayer[indexPath.row].player_name
                cell.teamLogo.sd_setImage(with: URL(string: arrTennisPlayer[indexPath.row].player_logo ?? ""), placeholderImage: UIImage(named: sport))
                
            }else{
                cell.teamLabel.text=arrTeams[indexPath.row].team_name
                
                cell.teamLogo.sd_setImage(with: URL(string: arrTeams[indexPath.row].team_logo ?? ""), placeholderImage: UIImage(named: sport))
            }
            return cell
        default: return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case eventCollection:
            return CGSize(width: eventCollection.frame.width  , height: eventCollection.frame.height )
        case resultsCollection:
            return CGSize(width: resultsCollection.frame.width , height: resultsCollection.frame.height )
        case teamsCollection:
            return CGSize(width: teamsCollection.frame.width / 3, height: teamsCollection.frame.height - 20)
        default:
            return CGSize(width: 100, height: 100)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case eventCollection: break
            
        case resultsCollection:
          // break
            //arrResult[indexPath.row].event_key ?? 0
            protocolVar?.callHighlightApi(sport: sport )
            
        case teamsCollection:
            if(sport == "tennis"){
                
            }else{
                let vc = storyboard?.instantiateViewController(withIdentifier: "TeamDetailsVC" ) as! TeamDetailsVC
                vc.sport=sport
                vc.team = arrTeams[indexPath.row]
                navigationController? .pushViewController(vc , animated : true )
            }
        default: break
        }
    }
    
}



//MARK: -
extension FixturesVC{
    
    
    func getArrTennisPlayer(arrEvent : [Event]){
        
        arrEvent.forEach { Event in
          var player1 = Player()
            player1.player_name = Event.event_first_player
            player1.player_logo = Event.event_first_player_logo
            player1.player_key = Event.first_player_key
            arrTennisPlayer.append(player1)
            var player2 = Player()
              player2.player_name = Event.event_second_player
              player2.player_logo = Event.event_second_player_logo
              player2.player_key = Event.second_player_key
            arrTennisPlayer.append(player2)

        }

        teamsCollection.reloadData()
    }
    
    func registerCells() {
       eventCollection.register(UINib(nibName: "EventCVCell", bundle: nil), forCellWithReuseIdentifier: "EventCVCell")
       teamsCollection.register(UINib(nibName: "TeamCVCell" ,bundle: nil), forCellWithReuseIdentifier: "TeamCVCell")
       resultsCollection.register(UINib(nibName: "ResultCVCell", bundle: nil), forCellWithReuseIdentifier: "ResultCVCell")
   }
   
    
    func playVideo(url: URL) {
         let player = AVPlayer(url: url)

         let vc = AVPlayerViewController()
         vc.player = player
        
         self.present(vc, animated: true) { vc.player?.play() }
     }
  

}


extension FixturesVC : ProtocolFixturesVC{
    
    func getEventApi(eventsResult: EventsResult?) {
        self.arrEvent=eventsResult?.result ?? [Event]()
       
        DispatchQueue.main.async {
            self.eventCollection.reloadData()
            self.getArrTennisPlayer(arrEvent : self.arrEvent)
        }
    }
    
    
    func getResultApi(resultsResult: ResultsResult?) {
        self.arrResult=resultsResult?.result ?? [Result]()
               DispatchQueue.main.async {
                   self.resultsCollection.reloadData()
               }
    }
    
    func getTeamApi(teamsResult: TeamsResult?) {
        self.arrTeams=teamsResult?.result ?? [Teams]()
               DispatchQueue.main.async {
                   self.teamsCollection.reloadData()
               }
    }
    
    func getHighlightApi(videoResult: videoResult?) {
        let res = videoResult?.result ?? [video]()
               DispatchQueue.main.async {
                   if let videoURL = res.first?.video_url.asUrl{
                       self.playVideo(url:videoURL)
                   }
               }
    }
    
    
}
