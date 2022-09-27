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
}
