//
// IAdapterSqlite.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation

protocol IAdapterSqlite {
    func downloadSqliteDatabase(completion: @escaping (Result<Data, DestinyError>) -> Void)
}
