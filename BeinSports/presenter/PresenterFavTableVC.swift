//
//  PresenterFavTableVC.swift
//  BeinSports
//
//  Created by mo_fathy on 08/05/2023.
//


import Foundation


import Foundation
import Alamofire

protocol ProtocolFavTableVC{

  

}


class PresenterFavTableVC {

    var protocolVar : ProtocolFavTableVC?

    init(protocolVar: ProtocolFavTableVC? = nil) {
        self.protocolVar = protocolVar
    }

    func deleteTeam(data: DBTeam!){
        CoreData.shared.deleteTeam(Team: data!)
    }
    func deletePlayer( data: DBPlayer!){
        CoreData.shared.deletePlayer( Team: data!)
    }
    
    func getTeams() -> [DBTeam]{
       return CoreData.shared.readTeams()
    }
    func getPlayers() -> [DBPlayer]{
        return CoreData.shared.readPlayers()
    }
    
}
