//
//  TestCoreData.swift
//  BeinSportsTests
//
//  Created by mo_fathy on 10/05/2023.
//

import XCTest
@testable import BeinSports

final class CoredataTest: XCTestCase {
    var coreData :CoreData?
    override func setUpWithError() throws {
        coreData = CoreData.shared
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    
    func testCoreData_readTeams() throws {
        var num = coreData!.readTeams().count + 1
        coreData!.insertTeam(key: 1, name: "", logo: "", sport: "")
        var res = coreData!.readTeams()
        XCTAssertEqual(res.count, num)
    }
    
    func testCoreData_deleteTeams() throws {
        var num = coreData!.readTeams().count
        coreData!.insertTeam(key: 1, name: "", logo: "", sport: "")
        var team = coreData!.readTeams().last
        coreData?.deleteTeam(Team: team!)
        var res = coreData!.readTeams()
        XCTAssertEqual(res.count, num)
    }

  

}
