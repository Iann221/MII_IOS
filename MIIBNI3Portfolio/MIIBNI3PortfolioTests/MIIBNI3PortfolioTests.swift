//
//  MIIBNI3PortfolioTests.swift
//  MIIBNI3PortfolioTests
//
//  Created by Vincentius Ian Widi Nugroho on 22/11/23.
//

import XCTest
@testable import MIIBNI3Portfolio

final class MIIBNI3PortfolioTests: XCTestCase {
    var portfolioInteractor = PortfolioInteractor()

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
    }

    func testGetData() throws {
        let data = portfolioInteractor.getData()
        XCTAssertTrue(data != nil)
    }
    
    func testGetYear() throws {
        let data = portfolioInteractor.getYearData()
        XCTAssertEqual(data.count, 12)
    }
    
    func testGetMonth() throws {
        let data = portfolioInteractor.getMonthData()
        XCTAssertEqual(data.count, 4)
    }
    
    func testGetDetail() throws {
        let data = portfolioInteractor.getDetailData(typeInt: 0)
        XCTAssertEqual(data.count, 3)
    }
}
