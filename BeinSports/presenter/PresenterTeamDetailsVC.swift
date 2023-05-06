//
//  PresenterLeaguesTableVC.swift
//  BeinSports
//
//  Created by mo_fathy on 06/05/2023.
//

import Foundation
import Alamofire

protocol ProtocolTeamDetailsVC{

    func getTeamApi(teamsResult: TeamsResult?)


}


class PresenterTeamDetailsVC {

    var protocolVar : ProtocolTeamDetailsVC?

    init(protocolVar: ProtocolTeamDetailsVC? = nil) {
        self.protocolVar = protocolVar
    }

    func callTeamApi(sport :String,teamId :String) {
        let param : [String: String] = ["met": "Teams","teamId": teamId]
        APIServices.instance.getDataAll(route: .typy(sport), method: .get, params: param, encoding: URLEncoding.default, headers: nil) { (dataurl: TeamsResult?, error) in
            self.protocolVar?.getTeamApi(teamsResult: dataurl)
               }
             }


}