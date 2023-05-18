//
//  testPresenterBasketball.swift
//  BeinSportsTests
//
//  Created by mo_fathy on 09/05/2023.
//


import XCTest
import Alamofire
@testable import BeinSports

final class testPresenterBasketball: XCTestCase {
    
    var protocolVar : PresenterFixturesTableVC?
    var sport = "basketball"
    var leagueId = ""
    var expectation  : XCTestExpectation?
    override func setUpWithError() throws {
        protocolVar = PresenterFixturesTableVC(protocolVar: self )
        expectation = expectation(description: "Waiting for the API")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
            
 
    func testLoadDataFromURL_callResultApi() {
        protocolVar?.callResultApi(sport: sport)
        waitForExpectations(timeout: 5)
        
    }
    func testLoadDataFromURL_callTeamApi() {
        protocolVar?.callTeamApi(sport: sport, leagueId: leagueId)
        waitForExpectations(timeout: 5)
        
    }
   
    
    

        
        
        
    }



extension testPresenterBasketball : ProtocolFixturesVC {
    
    func getResultApi(resultsResult: BeinSports.ResultsResult?) {
        guard let data = resultsResult else {
            XCTFail()
            expectation!.fulfill()
            return
        }
        XCTAssertNotEqual(data.result?.count, 0, "API Failed")
        expectation!.fulfill()
    }
    
    func getTeamApi(teamsResult: BeinSports.TeamsResult?) {
        guard let data = teamsResult else {
            XCTFail()
            expectation!.fulfill()
            return
        }
        XCTAssertNotEqual(data.result?.count, 0, "API Failed")
        expectation!.fulfill()
    }
    
    func getHighlightApi(videoResult: BeinSports.videoResult?) {
        guard let data = videoResult else {
            XCTFail()
            expectation!.fulfill()
            return
        }
        XCTAssertNotEqual(data.result?.count, 0, "API Failed")
        expectation!.fulfill()
    }
    
    func getEventApi(eventsResult: BeinSports.EventsResult?) {
                
                guard let data = eventsResult else {
                    XCTFail()
                    expectation!.fulfill()
                    return
                }
                XCTAssertNotEqual(data.result?.count, 0, "API Failed")
                expectation!.fulfill()
                
    }
  
}
    

