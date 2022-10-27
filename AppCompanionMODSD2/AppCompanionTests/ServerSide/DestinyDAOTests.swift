//
// DestinyRepoTests.swift
// AppCompanionTests
// Created in 2022
// Swift 5.0

import XCTest
@testable import AppCompanionMODSD2

final class DestinyDAOTests: XCTestCase {
    var sut: DestinyService!
    static var DATASTUBBED = "file.content".data(using: .utf8)

    override func setUp() {
        super.setUp()
		sut = DestinyService(DestinyDAOStub())
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    fileprivate func setBefore(destinyDAOStub: IDestinyDAO) {
        let destinyDAOStub = destinyDAOStub
        sut = DestinyService(destinyDAOStub)
    }


    func test_should_notReturnContentDabase() {
        let destinyDAOStub = DestinyDAOStub()
        destinyDAOStub.dataStubbed = nil
        setBefore(destinyDAOStub: destinyDAOStub)

        // when
        let dataForMods: Data? = sut.downloadContentDatabaseForMods()

        // then
        XCTAssertNil(dataForMods)
    }
    func test_should_ReturnContentDabase() {
        // given
        let destinyDAOStub = DestinyDAOStub()
        destinyDAOStub.dataStubbed = "file.content".data(using: .utf8)
        setBefore(destinyDAOStub: destinyDAOStub)

        // when
        let dataForMods: Data? = sut.downloadContentDatabaseForMods()

        // then
        XCTAssertNotNil(dataForMods)
    }

    func test_should_ReturnAsyncData() {
        try? XCTSkipUnless(true)
        let expectation = XCTestExpectation(description: #function)
        var myExpectedData: Data?
        sut.downloadContentDatabaseForMods0 { result in
            switch result {
                case .success(let data):
                    print("ok")
                    myExpectedData = data
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("error : \(error)")
            }
        }
        wait(for: [expectation], timeout: 3.0)

        XCTAssertEqual(myExpectedData, Data())
    }
    
}
