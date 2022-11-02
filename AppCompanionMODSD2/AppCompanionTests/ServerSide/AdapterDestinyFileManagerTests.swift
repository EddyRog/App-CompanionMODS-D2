//
// AdapterDestinyFileManagerTests.swift
// AppCompanionTests
// Created in 2022
// Swift 5.0

@testable import AppCompanionMODSD2
import XCTest

final class AdapterDestinyFileManagerTests: XCTestCase {
    var sut: AdapterDestinyFileManager!

    override func setUp() {
        super.setUp()
        sut = AdapterDestinyFileManager()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }


    func test_should_unzipFile() {
        // given
        // Remote and create file in memory
        let fileManager: FileManager = FileManager.default
        let tempRoot: String = NSTemporaryDirectory()
        let tempFile = tempRoot + "Destiny\(#function).content"
        fileManager.contents(atPath: tempFile)
        fileManager.createFile(atPath: tempFile, contents: Data())

        // when
        let actualPathName = try? sut.changeExtensionToZip(tempFile)

        // then
        XCTAssertEqual("\(tempRoot)Destiny\(#function).zip", "\(tempRoot)\(actualPathName!)")
    }

    func test_should_throwErrorWhenIsNil() {
        // given
        var thrownError: Error?

        XCTAssertThrowsError(try sut.changeExtensionToZip("")) {
            thrownError = $0
        }
        XCTAssertTrue(thrownError is AdapterDestinyFileManagerError)
    }

    func test_should_createFileWithDataToSpecifiquePath() {
        let destinyPathRoot = NSTemporaryDirectory()

        let actualPath = try? sut.createFileWithData(path: destinyPathRoot,
                                                     destinyNameFile: "Destiny\(#function).content",
                                                     data: "Data-Destiny".data(using: .utf8)!)

        let expectedPath = "\(destinyPathRoot)Destiny\(#function).content"
		XCTAssertEqual(expectedPath, actualPath)
    }

    func test_should_thrownErrorWhenNameIsEmpty() {
        var thrownError: Error?
        let destinyPathRoot = NSTemporaryDirectory()

        XCTAssertThrowsError(try sut.createFileWithData(
            path: destinyPathRoot,
            destinyNameFile: "",
            data: Data())
        ) {
			thrownError = $0
        }
        XCTAssertEqual(thrownError as? AdapterDestinyFileManagerError, .createFile)


    }

    func test_should_deleteAfileFromPath() {
		// given
        let tempPathFile = makeTempFileAt(nameFile: "Destiny\(#function).content")

        // when
        let isFileDeleted = sut.deleteFileAtPath(tempPathFile)

        // then
        XCTAssertTrue(isFileDeleted)
    }

    func test_should_notDeleteAfileFromPathBecauseDoesntExist() {
        let tempRoot: String = NSTemporaryDirectory()
        let tempFile = tempRoot + "Destiny\(#function).content"

        let isFileDeleted = sut.deleteFileAtPath(tempFile)

        XCTAssertFalse(isFileDeleted)
    }

    // Helper
    func makeTempFileAt(nameFile: String) -> String {
        let fileManager: FileManager = FileManager.default

        let tempRoot: String = NSTemporaryDirectory()
        let tempFile = tempRoot + "\(nameFile)"
        fileManager.createFile(atPath: tempFile, contents: Data())

        return tempFile
    }
}
