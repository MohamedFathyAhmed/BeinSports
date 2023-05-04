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
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        callEventApi()
        callResultApi()
        callTeamApi()
    }
    

     func registerCells() {
        eventCollection.register(UINib(nibName: "EventCVCell", bundle: nil), forCellWithReuseIdentifier: "EventCVCell")
        teamsCollection.register(UINib(nibName: "TeamCVCell" ,bundle: nil), forCellWithReuseIdentifier: "TeamCVCell")
        resultsCollection.register(UINib(nibName: "ResultCVCell", bundle: nil), forCellWithReuseIdentifier: "ResultCVCell")
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
            return arrTeams.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            //MARK: -event Cell
        case eventCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCVCell", for: indexPath) as! EventCVCell
            cell.homeImageE.sd_setImage(with: URL(string: arrEvent[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            cell.awayImageE.sd_setImage(with: URL(string: arrEvent[indexPath.row].away_team_logo ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            
            return cell
            
            
            
            
            //MARK: -results Cell
        case resultsCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCVCell", for: indexPath) as! ResultCVCell
            cell.awayImage.sd_setImage(with: URL(string: arrResult[indexPath.row].event_away_team_logo ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            cell.homeImage.sd_setImage(with: URL(string: arrResult[indexPath.row].home_team_logo ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            cell.resultLabel.text = arrResult[indexPath.row].event_final_result
            
            return cell
            
            
            //MARK: -teams Cell
        case teamsCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCVCell", for: indexPath) as! TeamCVCell
            cell.teamLabel.text=arrTeams[indexPath.row].team_name
          
            cell.teamLogo.sd_setImage(with: URL(string: arrTeams[indexPath.row].team_logo ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
        default: return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case eventCollection:
            return CGSize(width: eventCollection.frame.width , height: eventCollection.frame.height )
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
            callHighlightApi(eventId:  arrResult[indexPath.row].event_key ?? 0)
        case teamsCollection:
            let vc = storyboard?.instantiateViewController(withIdentifier: "TeamDetailsVC" ) as! TeamDetailsVC
            vc.team = arrTeams[indexPath.row]
            navigationController? .pushViewController(vc , animated : true )
        default: break
        }
    }
    
}



//MARK: -call api func
extension FixturesVC{
    func callEventApi() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        let calendar = Calendar.current
        let newDate = calendar.date(byAdding: .day, value: 14, to: date)
        
        let from :String = dateFormatter.string(from: date)
        let to :String = dateFormatter.string(from: newDate!)
      //  print(from + to)
      //  var from :String = "2023-03-18"
      // var to :String = "2023-04-29"
        let param : [String: String] = ["met": "Fixtures","from":from,"to":to,"leagueId":leagueId]
        APIServices.instance.getDataAll(route: .typy(sport), method: .get, params: param, encoding: URLEncoding.default, headers: nil) { (dataurl: EventsResult?, error) in
                   self.arrEvent=dataurl?.result ?? [Event]()
                   DispatchQueue.main.async {
                       self.eventCollection.reloadData()
                   }
               }
 
             }

    func callResultApi() {
        let param : [String: String] = ["met": "Livescore","leagueId":leagueId]//
        APIServices.instance.getDataAll(route: .typy(sport), method: .get, params: param, encoding: URLEncoding.default, headers: nil) { (dataurl: ResultsResult?, error) in
            self.arrResult=dataurl?.result ?? [Result]()
                   DispatchQueue.main.async {
                       self.resultsCollection.reloadData()
                   }
               }
 
             }
    func callTeamApi() {
        let param : [String: String] = ["met": "Teams","leagueId":leagueId]
        APIServices.instance.getDataAll(route: .typy(sport), method: .get, params: param, encoding: URLEncoding.default, headers: nil) { (dataurl: TeamsResult?, error) in
            self.arrTeams=dataurl?.result ?? [Teams]()
                   DispatchQueue.main.async {
                       self.teamsCollection.reloadData()
                   }
               }
 
             }
    func callHighlightApi(eventId  : Int) {
        var event = String(describing: eventId)
       // event="1059523"
        var param : [String: String] = ["met": "Videos","eventId":event]
        APIServices.instance.getDataAll(route: .typy(sport), method: .get, params: param, encoding: URLEncoding.default, headers: nil) { (dataurl: videoResult?, error) in
            let res = dataurl?.result ?? [video]()
                   DispatchQueue.main.async {
                       let videoURL = res.first?.video_url.asUrl
                       self.playVideo(url:videoURL! as URL)
                   }
               }
             }
    func playVideo(url: URL) {
         let player = AVPlayer(url: url)

         let vc = AVPlayerViewController()
         vc.player = player

         self.present(vc, animated: true) { vc.player?.play() }
     }

}
