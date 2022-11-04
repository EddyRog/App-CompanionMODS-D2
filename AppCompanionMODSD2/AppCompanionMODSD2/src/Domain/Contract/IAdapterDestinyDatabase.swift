//
// IAdapterDestinyDatabase.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation

protocol IAdapterDestinyDatabaseManager {
    func downloadDatabase(myUrl: String ,completion: @escaping (Result<Data, AdapterDestinyDatabaseError>) -> Void )
}
