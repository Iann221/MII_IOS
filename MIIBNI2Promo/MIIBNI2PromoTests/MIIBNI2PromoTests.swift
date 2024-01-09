//
//  MIIBNI2PromoTests.swift
//  MIIBNI2PromoTests
//
//  Created by Vincentius Ian Widi Nugroho on 24/11/23.
//

import XCTest
@testable import MIIBNI2Promo

final class MIIBNI2PromoTests: XCTestCase {
    var datas: [PromoEntity] = []

    override func setUpWithError() throws {
        let interactor = PromoInteractor()
        let expectation = XCTestExpectation(description: "Data loading completed")
        interactor.getData(completion: {promos in
            self.datas = promos
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
    }

    override func tearDownWithError() throws {
        datas = []
    }

    func testGetData() throws {
        XCTAssertTrue(self.datas.count > 0, "data fetching failed")
        let data = datas[0]
        XCTAssertEqual(data.title, "promo1")
    }

}
