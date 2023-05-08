//
//  BeinSportsTests.swift
//  BeinSportsTests
//
//  Created by mo_fathy on 09/05/2023.
//


import XCTest
import Alamofire
@testable import BeinSports

final class MockNetworkManagerTests: XCTestCase {
    let networkManager = MockNetworkManager()
    
    func testDataDecoding_ResultsResult() {

        networkManager.getDataAll(route: .typy("football"), method: .get, params: nil, encoding: URLEncoding.default, headers: nil) { (dataurl: ResultsResult?, error) in
            guard let data = dataurl else {
                
                XCTFail()
                return
            }
            XCTAssertNotEqual(data.result?.count, 0, "Failed")
        }

    }
    
    func testDataDecoding_EventsResult() {

        networkManager.getDataAll(route: .typy("football"), method: .get, params: nil, encoding: URLEncoding.default, headers: nil) { (dataurl: EventsResult?, error) in
            guard let data = dataurl else {
                
                XCTFail()
                return
            }
            XCTAssertNotEqual(data.result?.count, 0, "Failed")
        }

    }
    
    func testDataDecoding_TeamsResult() {

        networkManager.getDataAll(route: .typy("football"), method: .get, params: nil, encoding: URLEncoding.default, headers: nil) { (dataurl: TeamsResult?, error) in
            guard let data = dataurl else {
                
                XCTFail()
                return
            }
            XCTAssertNotEqual(data.result?.count, 0, "Failed")
        }

    }
}
