//
// AdapterSqlite.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation

// Server-Side
class AdapterSqlite: IAdapterSqlite {
    func downloadSqliteDatabase(completion: @escaping (Result<Data, DestinyError>) -> Void) {
        // Apple
        completion(.failure(.download))
    }
}
