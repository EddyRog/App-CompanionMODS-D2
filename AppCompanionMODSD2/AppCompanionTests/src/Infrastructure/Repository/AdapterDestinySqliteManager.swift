//
// AdapterDestinySqliteManager.swift
// AppCompanionTests
// Created in 2022
// Swift 5.0

@testable import AppCompanionMODSD2
import XCTest

final class AdapterDestinySqliteManagerTest: XCTestCase {
    var sut: AdapterDestinySqliteManager!
    override func setUp() {
        super.setUp()
        sut = AdapterDestinySqliteManager()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_should_notbeNil() {
        XCTAssertNotNil(sut)
    }

    func test_should_openSqliteDatabase() {
        // given
        // Create location manager
        let manager: FileManager = FileManager.default
        let documentFolderPath = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let tempSqliteDatabasePath: String = documentFolderPath!.relativePath + "/world.sqlite3"
        debugPrint("dee L\(#line) 🏵 -------> ", tempSqliteDatabasePath)

        // when
        let actualOpenedDatabase = sut.openSqliteDatabase(path: tempSqliteDatabasePath)

        // then
        XCTAssertTrue(actualOpenedDatabase)
    }

    func test_should_cannotOpenSqliteDatabase() {
        // when
        let actualOpenedDatabase = sut.openSqliteDatabase(path: "-")

        // then
        XCTAssertFalse(actualOpenedDatabase)
    }

    func test_should_readTableInDatabase() {
        // Create location manager
        let manager: FileManager = FileManager.default
        let documentFolderPath = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let tempSqliteDatabasePath: String = documentFolderPath!.relativePath + "/world.sqlite3"
        // givenh!.relativePath + "/world.sqlite3"
        debugPrint("dee L\(#line) 🏵 -------> ", tempSqliteDatabasePath)

        _ = sut.openSqliteDatabase(path: tempSqliteDatabasePath)
        let data = sut.readTableFrom(table: .DestinyGenderDefinition)

        XCTAssertNotNil(data)
    }

    func test_should_DecodeGender() {
        let jsonDataForOneEntry = dataJsonFrom(table: .DestinyGenderDefinition)

        let object = DestinyAnyObject(uid: 000, json: jsonDataForOneEntry, type: .DestinyGenderDefinition)
        debugPrint("dee L\(#line) 🏵 -------> ", object.type)
        debugPrint("dee L\(#line) 🏵 -------> ", object.type)



      //  XCTAssertEqual(object.info.genderType, 0)
    }

    /*
    func test_should_DecodeGender() {
        // given
        let dataTable = dataJsonFrom(table: .DestinyGenderDefinition)

        // when
        let objects = sut.decode(type: .DestinyGenderDefinition, withData: dataTable)

        // then
        XCTAssertNotNil(objects)
    }
     */
}

private func dataJsonFrom(table: DestinyTableDatabase) -> Data {
    var nameOfFile = ""
    let extensionOfFile = "json"

    switch table {
        case .DestinyGenderDefinition:
            nameOfFile = "json_\(table.rawValue)"
        case .DestinyClassDefinition:
            nameOfFile = "json_\(table.rawValue)"
    }
    // MARK: - Get file Path
    guard let pathJson = Bundle.main.path(forResource: nameOfFile, ofType: extensionOfFile) else {
        fatalError("Failed to find \(nameOfFile).\(extensionOfFile)")
    }

    // MARK: - Stringlify content of File
    guard let contentJsonFile = try? String(contentsOfFile: pathJson) else {
        fatalError("Failed to get content of \(String(describing: pathJson)) from bundle.")
    }

    // MARK: - Map content to data type
    guard let dataJson = contentJsonFile.data(using: .utf8) else {
        fatalError("Failed to transform \(contentJsonFile) in data type.")
    }

    return dataJson
}




extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
