//
// DestinyDatabaseManager.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation
import SQLite3

class DestinyDatabaseManager {
    init() {
        print("DestinyDatabaseManager")
        let filemanager = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        print(filemanager)
    }

}
