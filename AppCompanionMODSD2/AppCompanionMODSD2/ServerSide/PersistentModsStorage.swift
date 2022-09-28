// Class qui stock les mods de la base de donnée de destiny
// PersistentModsStorage.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0

import Foundation
import SQLite3

class PersistentModsStorage {
    var db: OpaquePointer?

    init(){
        _ = openDataBase()
        prepareReadTable(with: .DestinyClassDefinition)

    }

    private func openDataBase() -> OpaquePointer? {

        let manager: FileManager = FileManager.default
        guard let documentFolder = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } // /Documents/
        let locationDatabase: URL = documentFolder.appending(component: "Destiny/Destiny.sqlite3")


        // open database
        if sqlite3_open(locationDatabase.path(), &db) != SQLITE_OK {
            print("🟥 error db")
            return nil
        } else {
            print("🟩 connected db")
            return db
        }
    }
    private func prepareReadTable(with table: DestinyTableDatabase) {
        var selectStatment: OpaquePointer? = nil
        let selectSQL = "SELECT * FROM \(table.rawValue)"

        // --- prepare.
        if sqlite3_prepare(db, selectSQL, -1, &selectStatment, nil) == SQLITE_OK {
            while sqlite3_step(selectStatment) == SQLITE_ROW {
                let rowID = sqlite3_column_int(selectStatment, 0) // first column
                let rowJson = String(cString: sqlite3_column_text(selectStatment, 1))

                print("id = \(rowID)")
                printJson(rowJson)
            }
        }
        sqlite3_finalize(selectStatment)
    }

    private func printJson(_ value: String) {
        if let prettyJson = value.data(using: .utf8)?.prettyPrintedJSONString {
            debugPrint(prettyJson, terminator: "\n \n ⬇️⬇️⬇️⬇️ \n")

        } else {
            debugPrint("🟥 impossible to print beautifully the json")
        }
    }
}

enum DestinyTableDatabase: String {
    case DestinyGenderDefinition
    case DestinyClassDefinition
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
