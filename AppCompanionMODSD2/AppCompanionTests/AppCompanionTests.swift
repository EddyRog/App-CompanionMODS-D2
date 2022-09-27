//
// AppCompanionTests.swift
// AppCompanionTests
// Created in 2022
// Swift 5.0


import XCTest
@testable import AppCompanionMODSD2

final class AppCompanionTests: XCTestCase {
    var sut: DestinyDatabaseManager!
    override func setUp() {
        super.setUp()
        sut = DestinyDatabaseManager()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }


//    func test_database_getDatabase__expect_databaseExist() {
//        let databaseName = "destinyDatabaseSQLite.sqlite3"
//        let isDatabaseExist = sut.getdatabase(databaseName)
//        XCTAssertTrue(isDatabaseExist)
//    }

    func test_downloadDatabase__expect_folderIsNotEmpty() {
//        let isFolderEmpty = sut.downloadDatabase()
//        XCTAssertFalse(isFolderEmpty)
    }
}
