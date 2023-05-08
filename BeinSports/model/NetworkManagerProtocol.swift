//
//  Network.swift
//  BeinSports
//
//  Created by mo_fathy on 01/05/2023.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func getDataAll<T: Decodable>(route: Route, method: HTTPMethod ,params: Parameters?, encoding: ParameterEncoding ,headers: HTTPHeaders? ,completion: @escaping (T?,  Error?)->())
    
}




