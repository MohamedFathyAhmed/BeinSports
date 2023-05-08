//
//  PresenterLeaguesTableVC.swift
//  BeinSports
//
//  Created by mo_fathy on 06/05/2023.
//

import Foundation
import Alamofire

protocol ProtocolFixturesVC{
    
    func getEventApi(eventsResult: EventsResult?)
    func getResultApi(resultsResult: ResultsResult?)
    func getTeamApi(teamsResult: TeamsResult?)
    func getHighlightApi(videoResult: videoResult?)
    
}


class PresenterFixturesTableVC {
   
    var protocolVar : ProtocolFixturesVC?
    
    init(protocolVar: ProtocolFixturesVC? = nil) {
        self.protocolVar = protocolVar
    }
    
    func callEventApi(sport :String,leagueId:String = "") {
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
        let param : [String: String] = ["met": "Fixtures","from":from,"to":to ,"leagueId":leagueId]
        APIServices.instance.getDataAll(route: .typy(sport), method: .get, params: param, encoding: URLEncoding.default, headers: nil) { (dataurl: EventsResult?, error) in
            
            self.protocolVar?.getEventApi(eventsResult: dataurl)
               }
 
             }

    func callResultApi(sport :String,leagueId:String = "") {
        let param : [String: String] = ["met": "Livescore","leagueId":leagueId]
        APIServices.instance.getDataAll(route: .typy(sport), method: .get, params: param, encoding: URLEncoding.default, headers: nil) { (dataurl: ResultsResult?, error) in
            self.protocolVar?.getResultApi(resultsResult: dataurl)
               }
 
             }
    
    
    func callTeamApi(sport :String,leagueId:String ) {
        let param : [String: String] = ["met": "Teams","leagueId":leagueId]
        APIServices.instance.getDataAll(route: .typy(sport), method: .get, params: param, encoding: URLEncoding.default, headers: nil) { (dataurl: TeamsResult?, error) in
            self.protocolVar?.getTeamApi(teamsResult: dataurl)
               }
 
             }
    
    func callHighlightApi(sport :String,eventId : Int = 1059523) {
        let event = String(describing: eventId)
        
        let param : [String: String] = ["met": "Videos","eventId":event]
        APIServices.instance.getDataAll(route: .typy(sport), method: .get, params: param, encoding: URLEncoding.default, headers: nil) { (dataurl: videoResult?, error) in
            self.protocolVar?.getHighlightApi(videoResult: dataurl)
               }
             }

    

    
    
}
