//
//  testLabTests.swift
//  testLabTests
//
//  Created by mo_fathy on 07/05/2023.
//

import XCTest
import Alamofire
@testable import BeinSports

final class UnitTestingNetwork: XCTestCase {
    
    var sport = "football"
    var leagueId = ""
    
    override func setUpWithError() throws {
       // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadDataFromURL() {
        let expectation = expectation(description: "Waiting for the API")
        let from :String = Utls.getDate()
        let to :String = Utls.getNext30Date()
        
        
        let param : [String: String] = ["met": "Fixtures","from":from,"to":to ,"leagueId":leagueId]
        APIServices.instance.getDataAll(route: .typy(sport), method: .get, params: param, encoding: URLEncoding.default, headers: nil) { (dataurl: EventsResult?, error) in
            
            guard let data = dataurl else {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(data.result?.count, 0, "API Failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        
        }
 
   
    
    
    
    
    
    
    
    
    
    }
    
    

