//
// All.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0

import Foundation

class Destiny2 {

    var adapterDestinySqliteManager: IAdapterDestinySqliteManager
    var adapterDestinyFileManager: IAdapterDestinyFileManager

    internal init(adapterDestinySqliteManager: IAdapterDestinySqliteManager, adapterDestinyFileManager: IAdapterDestinyFileManager) {
        self.adapterDestinySqliteManager = adapterDestinySqliteManager
        self.adapterDestinyFileManager = adapterDestinyFileManager
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
