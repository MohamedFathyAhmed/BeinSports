//
//  Network.swift
//  BeinSports
//
//  Created by mo_fathy on 01/05/2023.
//

import Foundation
import Alamofire


class Network {
    private init() {}
    static let instance = Network()
   
        func test()  {
            APIServices.instance.getDataWithUrl(route: .typy("football"), completion: {
                (posts: ResultsResult?, error) in
                print(posts?.result.first?.country_name )
    
            })
        }
   // func test()  {
        
       // .Leagues("football")
 //       var param : [String: String] = ["met": "Leagues", "APIkey": "2cdee77a4a65bc36ba2b0114ae157d4c8bfc08a21d4a0762c8169996b2924744"]
//        APIServices.instance.getDataAll(route:.football, method: .get, params: nil, encoding: URLEncoding.default, headers: nil) { (dataurl: ResultsResult?, error) in
//            print(dataurl?.result.first?.country_name )
//        }
        
//    }
}





//APIServices.instance.getDataWithUrl(url: self.postsUri, completion: {
//    (posts: [PostsModel]?, error) in
//})
//
//APIServices.instance.getDataAll(url: "https://yummie.glitch.me/dish-categories", method: .get, params: nil, encoding: URLEncoding.default, headers: nil) { (dataurl: datamodel?, error) in}
//
//
//APIService. instance. fetchData (url: APIConstants. baseURL + APIConstants. loginEndPoind, parameters: params, headers: headers, method: •post) { (loginModel: LoginSuccessMode1?, loginErrorModel:LoginErrorModel?,error) in
//    if let error = error {
//        // network error == offline print (error)
//
//
//    } else if let loginErrorModel = loginErrorModel{
//        // data error
//    }else{
//        guard let loginModel = loginModel else { return }
//        // data
//    }





