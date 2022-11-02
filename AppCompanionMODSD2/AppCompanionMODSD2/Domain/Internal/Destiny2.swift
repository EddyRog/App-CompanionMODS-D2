//
// All.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0

import Foundation

class Destiny2 {

    var adapterSqlite: IAdapterSqlite
    var fileManager: IAdapterDestinyFileManager

    internal init(adapterSqlite: IAdapterSqlite, fileManager: IAdapterDestinyFileManager) {
        self.adapterSqlite = adapterSqlite
        self.fileManager = fileManager
    }

    func getAllDestinyMods() throws -> [Mod] {
        throw Destiny2Errors.getDestinyMods
        // download
//        adapterSqlite.downloadSqliteDatabase { _ in
//            // TODO: ❎ statm ❎
//            //
//        }
        // Create File
        // Change content to zip
        // un zip
    }
}
