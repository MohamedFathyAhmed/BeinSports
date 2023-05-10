//
//  BeinSportsTests.swift
//  BeinSportsTests
//
//  Created by mo_fathy on 09/05/2023.
//

import XCTest
@testable import BeinSports

final class BeinSportsTests: XCTestCase {
    var date :Date?
    override func setUpWithError() throws {
        date = Date()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetDate() throws {
        var res = Utls.getDate()
        

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        var strDate = dateFormatter.string(from: date!)
        
        XCTAssertEqual(res, strDate)
    }
    
    func testNextDate() throws {
        var res = Utls.getNext30Date()
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        let calendar = Calendar.current
        let newDate = calendar.date(byAdding: .day, value: 14, to: date!)
        var strDate = dateFormatter.string(from: newDate!)
        
        XCTAssertEqual(res, strDate)
    }
    
  

  

}
