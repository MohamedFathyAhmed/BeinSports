//
//  PresenterPlayerDetailsVC.swift
//  BeinSports
//
//  Created by mo_fathy on 07/05/2023.
//

import Foundation


import Foundation
import Alamofire

protocol ProtocolPlayerDetailsVC{

    func getPlayerApi(playerResult: PlayerResult?)


}


class PresenterPlayerDetailsVC {

    var protocolVar : ProtocolPlayerDetailsVC?

    init(protocolVar: ProtocolPlayerDetailsVC? = nil) {
        self.protocolVar = protocolVar
    }

    func callPlayerApi(sport :String,playerId :String) {
        let param : [String: String] = ["met": "Players","playerId": playerId]
        APIServices.instance.getDataAll(route: .typy(sport), method: .get, params: param, encoding: URLEncoding.default, headers: nil) { [weak self] (dataurl: PlayerResult?, error) in
            self?.protocolVar?.getPlayerApi(playerResult: dataurl)

               }
             }

    func insertPlayer (key: Int ,name: String , logo :String,sport :String ){
        CoreData.shared.insertPlayer(key:  key , name: name, logo: logo, sport: sport)
    }
    
    func isFav (key : Int) -> Bool{
        var flag = false
        let data =  CoreData.shared.readPlayers()
        data.forEach { Player in
            if( Player.key  == key ){
                flag = true
            }
        }
        return flag
    }
    
}
