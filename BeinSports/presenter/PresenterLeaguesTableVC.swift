//
//  PresenterLeaguesTableVC.swift
//  BeinSports
//
//  Created by mo_fathy on 06/05/2023.
//

import Foundation
import Alamofire

protocol ProtocolLeaguesTableVC{
    
    func getLeagues(resultsResult: ResultsResult?)
    
    
}


class PresenterLeaguesTableVC {
   
    var protocolVar : ProtocolLeaguesTableVC?
    
    init(protocolVar: ProtocolLeaguesTableVC? = nil) {
        self.protocolVar = protocolVar
    }
    
    func getLeagues(sport:String){
        let param : [String: String] = ["met": "Leagues"]
        APIServices.instance.getDataAll(route: .typy(sport), method: .get, params: param, encoding: URLEncoding.default, headers: nil) {   (dataurl: ResultsResult?, error) in
            self.protocolVar?.getLeagues(resultsResult: dataurl)
        }
    }
    
    
}
