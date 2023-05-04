//
//  Network.swift
//  BeinSports
//
//  Created by mo_fathy on 01/05/2023.
//
//MARK: -  alamofire + decoder
import Foundation
import Alamofire

//MARK: - Route
enum Route {
    static let baseUrl = "https://apiv2.allsportsapi.com"
    static let APIkey = "74239ff4b0776dba5295debe45f7691ae79a6ed3ce907cacb868ab9107212fd4"
    //74239ff4b0776dba5295debe45f7691ae79a6ed3ce907cacb868ab9107212fd4
    //2cdee77a4a65bc36ba2b0114ae157d4c8bfc08a21d4a0762c8169996b2924744
    case typy(String)
    
    
    var description: String {
        switch self {
        case .typy(let category):
            return "\(Route.baseUrl)/\(category)/?APIkey=\(Route.APIkey)"
       
        }
    }
}

class APIServices {
    private init() {}
    static let instance = APIServices()
    //MARK: - getDataWithErrorAll
    func getDataWithError<T: Decodable, E: Decodable>(route: Route, method: HTTPMethod ,params: Parameters?, encoding: ParameterEncoding ,headers: HTTPHeaders? ,completion: @escaping (T?, E?, Error?)->()) {
        
        Alamofire.request(route.description, method: method, parameters: params, encoding: encoding, headers: headers)
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                switch response.result {
                case .success(_):
                    guard let data = response.data else { return }
                    do {
                        let jsonData = try JSONDecoder().decode(T.self, from: data)
                        completion(jsonData, nil, nil)
                    } catch let jsonError {
                        print(jsonError)
                    }
                    
                case .failure(let error):
                    // switch on Error Status Code
                    guard let data = response.data else { return }
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode {
                    case 400..<500:
                        do {
                            let jsonError = try JSONDecoder().decode(E.self, from: data)
                            completion(nil, jsonError, nil)
                        } catch let jsonError {
                            print(jsonError)
                        }
                    default:
                        completion(nil, nil, error)
                    }
                }
            }
    }
    
    
    //MARK: - getDataWithUrl
    
    func getDataWithUrl<T: Decodable>(route: Route, completion: @escaping (T?, Error?)->Void) {
        Alamofire.request(route.description).responseJSON { (response) in
            guard let data = response.data else { return }
            switch response.result {
            case .success(_):
                do {
                    let posts = try JSONDecoder().decode(T.self, from: data)
                    completion(posts, nil)
                } catch let jsonError{
                    print(jsonError)
                }
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    
    
    //MARK: - getDataAll
    func getDataAll<T: Decodable>(route: Route, method: HTTPMethod ,params: Parameters?, encoding: ParameterEncoding ,headers: HTTPHeaders? ,completion: @escaping (T?,  Error?)->()) {
        
        Alamofire.request(route.description, method: method, parameters: params, encoding: encoding, headers: headers)
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                switch response.result {
                case .success(_):
                    guard let data = response.data else { return }
                    do {
                        let jsonData = try JSONDecoder().decode(T.self, from: data)
                        completion(jsonData,  nil)
                    } catch let jsonError {
                        print(jsonError)
                    }
                    
                case .failure(let error):
                    completion(nil,  error)
                }
            }
    }
}





