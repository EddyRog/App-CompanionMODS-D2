//
// DestinyDAOStub.swift
// AppCompanionTests
// Created in 2022
// Swift 5.0

import Foundation
@testable import AppCompanionMODSD2

// ==================
// MARK: - Test doubles
// ==================
class DestinyDAOStub: IDestinyDAO {
    var dataStubbed: Data?
    func downloadContentDatabaseForMods() -> Data? {
        // mock real json retuned
        return dataStubbed
    }
}
