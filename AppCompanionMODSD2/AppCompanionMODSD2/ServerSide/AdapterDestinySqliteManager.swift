//
// AdapterDestinySqliteManager.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation
import SQLite3

class AdapterDestinySqliteManager: IAdapterDestinySqliteManager {

    private var db: OpaquePointer?

    func openSqliteDatabase(path: String) -> Bool {
        if sqlite3_open(path, &db) == SQLITE_OK {
			return true
        }
            return false
    }

    func readTableFrom(table: DestinySqliteTable) -> [DestinyAnyObject]? {
        var data: [DestinyAnyObject]?
        var selectStatment: OpaquePointer? = nil
        let selectedSQL = "SELECT * FROM DestinyGenderDefinition"

        if sqlite3_prepare(db, selectedSQL, -1, &selectStatment, nil) == SQLITE_OK {
            data = []

            // step
            while sqlite3_step(selectStatment) == SQLITE_ROW {
                let rowUid = sqlite3_column_int(selectStatment, 0) // first column
                let rowJson = String(cString: sqlite3_column_text(selectStatment, 1))

                switch table {
                    case .DestinyGenderDefinition:
                        if let dataJson: Data = rowJson.data(using: .utf8) {
                            data?.append(DestinyAnyObject(uid: rowUid, json: dataJson, type: .DestinyGenderDefinition))
                        }
                        
                    case .DestinyClassDefinition:
                        if let dataJson: Data = rowJson.data(using: .utf8) {
                            data?.append(DestinyAnyObject(uid: rowUid, json: dataJson, type: .DestinyGenderDefinition))
                        }
                }
            }
        }
        sqlite3_finalize(selectStatment)

        return data
    }

    /// ▶ Decode an array of data.
    func decode(type: DestinySqliteTable, withData data: Data) -> [AnyObject]? {
        switch type {
            case .DestinyGenderDefinition:
                let dataDecoded = try? JSONDecoder().decode([GenderCodable].self, from: data)
                debugPrint("dee L\(#line) 🏵 -------> ", dataDecoded)
                debugPrint("dee L\(#line) 🏵 -------> ", dataDecoded)
				return nil

//                return nil
            case .DestinyClassDefinition:
                return nil
        }
    }
}

enum DestinySqliteTable: String {
    case DestinyGenderDefinition
    case DestinyClassDefinition
}
