//
// Destiny2Tests.swift
// AppCompanionTests
// Created in 2022
// Swift 5.0


import XCTest
@testable import AppCompanionMODSD2

final class Destiny2Tests: XCTestCase {

    func test_should_notGetModsThenThrowException() {
        let stubAdapterSqlite = StubAdapterSqlite()
        let stubFileManager = DummyAdapterDestinyFileManager()
        let sut = Destiny2(adapterSqlite: stubAdapterSqlite, fileManager: stubFileManager)
        var thrownError: Error?

        XCTAssertThrowsError(try sut.getAllDestinyMods() ) {
            thrownError = $0
        }
        XCTAssertEqual(thrownError as? Destiny2Errors, .getDestinyMods)
    }
    // TODO: ❎ test get All Mods ❎

	// should only check if unzip is called that it

    // ==================
    // MARK: - Test doubles
    // ==================
    class StubAdapterSqlite: IAdapterSqlite {

        var invokedDownloadSqliteDatabase = false
        var invokedDownloadSqliteDatabaseCount = 0

        func downloadSqliteDatabase(completion: @escaping (Result<Data, AppCompanionMODSD2.DestinyError>) -> Void) {
            invokedDownloadSqliteDatabase = true
            invokedDownloadSqliteDatabaseCount += 1
            completion(.failure(.download))
        }
    }
    class DummyAdapterDestinyFileManager: IAdapterDestinyFileManager {

        func changeExtensionToZip(_ pathOfFile: String) throws -> String {
            ""
        }

        func createFileWithData(path: String, destinyNameFile: String, data: Data) throws -> String {
            ""
        }

        func deleteFileAtPath(_ tempFile: String) -> Bool {
            return false
        }
    }
}
