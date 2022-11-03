//
// AdapterDestinyFileManagerTests.swift
// AppCompanionTests
// Created in 2022
// Swift 5.0

@testable import AppCompanionMODSD2
import Zip
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

    func test_should_unZipACompressedFile() {
        // given
        let fileManager: FileManager = FileManager.default

        // temp folder
        let tempFolderPath: String = NSTemporaryDirectory()
        let tempFilePath = tempFolderPath + "Destiny\(#function).sqlite3"

        // create file
        fileManager.createFile(atPath: tempFilePath, contents: Data())

		// zip the file
        let urlFileToZip = URL(string: tempFilePath)!

        // document : create a zip in document folder
        guard let documentFilePath = try? Zip.quickZipFiles([urlFileToZip], fileName : "Destiny\(#function)") else {
            XCTFail("error: create zip file in the documenet folder")
            return
        }

        let documentFolderPath = URL(string: documentFilePath.relativePath)!.deletingLastPathComponent().relativePath
        let documentNameOfFile = documentFilePath.lastPathComponent

        // move it in tmp file for purpose of test
        _ = try? fileManager.moveItem(atPath: documentFolderPath + "/" + documentNameOfFile,
                                              toPath: tempFolderPath + documentNameOfFile)

        // remove file (zip) from document
        if fileManager.fileExists(atPath: documentFilePath.relativePath) {
            do { try fileManager.removeItem(at: documentFilePath) }
            catch { XCTFail("error: remove file (zip) in document folder") }
        }

        // remove file (sqlite3) from tmp
        do { try fileManager.removeItem(atPath: tempFilePath) }
        catch  { XCTFail("error: remove file (sqlite3) in tmp folder before unzip") }

        let isUnzipped = sut.unzipDatabase(filepath: tempFolderPath + documentNameOfFile)

        XCTAssertTrue(isUnzipped)
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
