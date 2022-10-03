// Manage the database of destiny2
// Destiny2SQLITEManager.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0

import Foundation
import SQLite3
import Zip

class Destiny2SQLITEManager {

    private static let defaultUrlDatabase: String = "https://www.bungie.net/common/destiny2_content/sqlite/fr/world_sql_content_aa813698cf6492188dde4fa1fe4d38d8.content"
    private var fileManager = FileManager.default
    private var nameFolderDestiny = "Destiny2"
    private var db: OpaquePointer?

    init() {
        _ = openDataBase()
        prepareReadTable(with: .DestinyGenderDefinition)
    }

    // ==================
    // MARK: - Extract data from sqlite database
    // ==================
    private func openDataBase() -> OpaquePointer? {

        let manager: FileManager = FileManager.default
        guard let documentFolder = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } // /Documents/
        let locationDatabase: URL = documentFolder.appending(component: "\(nameFolderDestiny)/\(nameFolderDestiny).sqlite3")


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

                // printJson(rowJson)
                // field
                guard let dataJson = rowJson.data(using: .utf8) else { return }

                switch table {
                        // !!!:  a supprimer juste pour les test ! ⭐️❎
                    case .DestinyGenderDefinition:
                        // decode
                        let data = try? JSONDecoder().decode(GenderCodable.self, from: dataJson)
                        print(Gender(id: rowID.hashValue, hash: data!.hash, name: data!.displayProperties.name))
                    case .DestinyClassDefinition:
                        break
                }

            }
        }
        sqlite3_finalize(selectStatment)
    }

	// helper
    private func printJson(_ value: String) {
        if let prettyJson = value.data(using: .utf8)?.prettyPrintedJSONString {
            debugPrint(prettyJson, terminator: "\n \n ⬇️⬇️⬇️⬇️ \n")
        } else {
            debugPrint("🟥 impossible to print beautifully the json")
        }
    }


    // ==================
    // MARK: - Downloading database operation
    // ==================
	/// ▶ Download once the database from Destiny2 server and generate sqlite3 database
    /// the Data it s save into `UserDefault`
    /// You can generate many time as you want the sqlite file.
    /// Use `refreshDatabase()` to refresh the data base
    func loadDatabase() {
    getDatabase()
    // --- Generate sqliteDatabase.
    if let databaseData = DestinyUserDefault.getData() {
        try? createFolderForDatabaseDownloaded()
        try? generateSqliteDatabase(from: databaseData)
    } else {
        debugPrint("dee L-\(#line) 🚗💨🚓 cannot generate database, userdefault empty 🥎")
        // !!!:  download database and retry ! ⭐️❎
    }
}

    /// ▶ if the database on the Destiny servers is available and the download completed successfully
    ///  then the old database and old SQL files will be overwritten by the new ones.
    func refreshDatabase() {
        debugPrint("dee L-\(#line) 🚗💨🚓 refresh data running 🥎")
        try? downloadDatabase(url: Destiny2SQLITEManager.defaultUrlDatabase) { result in
            switch result {
                case.success(let data):
                    debugPrint("dee L-\(#line) 🚗💨🚓 deleting data... 🥎")
                    DestinyUserDefault.deleteData()
                    try? self.removeSqliteDatabase()
                    debugPrint("dee L-\(#line) 🚗💨🚓 saving data... 🥎")
                    DestinyUserDefault.saveDataUserDefault(data)
                    debugPrint("dee L-\(#line) 🚗💨🚓 data refreshed! 🥎")
                    self.loadDatabase()
                case .failure(_):
                    // TODO: ❎ impl ❎
                    debugPrint("dee L-\(#line) 🚗💨🚓 probleme to data on refresh! 🥎")
                    break
            }
        }
    }
}

extension Destiny2SQLITEManager {
    // --
    private func getDatabase() {
        if DestinyUserDefault.isDataExist() {
            debugPrint("dee L-\(#line) 🚗💨🚓 data already exist 🥎")
            return // no need to download
        }

        try? downloadDatabase(url: Destiny2SQLITEManager.defaultUrlDatabase) { result in
            switch result {
                case.success(let data):
                    DestinyUserDefault.saveDataUserDefault(data)
                    debugPrint("dee L-\(#line) 🚗💨🚓 data saved 🥎")
                case .failure(_):
                    // TODO: ❎ impl ❎
                    debugPrint("dee L-\(#line) 🚗💨🚓 probleme fetching 🥎")
                    break
            }
        }
    }
    private func downloadDatabase(url: String, completion: @escaping (Result<Data, Error>) -> Void) throws {
        guard let url = URL(string: url) else { throw Destiny2Error.errorUrl }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(Destiny2Error.errorFetching(reason: "\(error.localizedDescription)")))
            } else {
                if let data = data {
                    completion(.success(data))
                }
            }
        }.resume()
    }
    private func createFolderForDatabaseDownloaded() throws {
        guard let folderDocument = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { throw Destiny2Error.cannotGetDocumentFolder }
        let folderDestiny2 = folderDocument.appending(component: self.nameFolderDestiny) // Document/ destiny2
        do {
            try fileManager.createDirectory(at: folderDestiny2, withIntermediateDirectories: true)
        } catch { throw Destiny2Error.cannotCreateFolder  }
    }
    private func generateSqliteDatabase(from data: Data) throws {
        debugPrint("dee L-\(#line) 🚗💨🚓 Generate database... 🥎")
        guard let folderDocument = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { throw Destiny2Error.cannotGetDocumentFolder }
        // --- Add path of folder to : ~/Document/.
        let folderDestiny2 = folderDocument.appending(component: self.nameFolderDestiny) // Document/ destiny2

        // --- Checks if the `Destiny2 folder has been created.
        if fileManager.fileExists(atPath: folderDestiny2.relativePath) {
            debugPrint("dee L-\(#line) 🚗💨🚓 continue 🥎")

            // --- Create the path to the files `Destiny2.zip`.
            let pathDestinyFileZipped: String = folderDestiny2.relativePath + "/\(nameFolderDestiny).zip"

            // --- Create the zip file with data downloaded previously.
            let pathFileSqlite3AlreadyCreated = folderDestiny2.relativePath + "/\(nameFolderDestiny).sqlite3"

            // --- Check if a database already exist during the reload.
            if fileManager.fileExists(atPath: pathFileSqlite3AlreadyCreated) {
                // --- Delete it.
                try fileManager.removeItem(atPath: pathFileSqlite3AlreadyCreated)
            }

            // --- Create a new one at a specific location.
            fileManager.createFile(atPath: pathDestinyFileZipped , contents: DestinyUserDefault.getData())


            // --- Unzip the file to get the content
            guard let urlPathDestinyFileZipped: URL = URL(string: pathDestinyFileZipped) else { throw Destiny2Error.errorUrl }
            do { _ = try Zip.quickUnzipFile(urlPathDestinyFileZipped) } catch let error { print(error.localizedDescription)  } // world_sql_content_aa813698cf6492188dde4fa1fe4d38d8.content

            // --- Delete the zipped file.
            do { try fileManager.removeItem(atPath: urlPathDestinyFileZipped.relativePath) } catch { throw Destiny2Error.cannotRemoveFile }

            // --- Get all files in the folder.
            guard let files = try? fileManager.contentsOfDirectory(atPath: folderDestiny2.relativePath) else { throw Destiny2Error.cannotFindFilesInTheFolder }

            // --- At this point when the file is unzipped u get a new file with the `.content`extension.
            // --- `.content`need to be change by `.sqlite3`.
            for file in files {

                let filename = file as NSString // world_sql_content_aa813698cf6492188dde4fa1fe4d38d8.content

                if filename.pathExtension == "content" {
                    do {
                        let pathForFileContentExtension: String = folderDestiny2.relativePath + "/\(file)" // xxx.content
                        let pathForFileSqlite3Extension: String = folderDestiny2.relativePath + "/\(nameFolderDestiny).sqlite3"

                        // --- Rename the file and change the extension.
                        try fileManager.moveItem(atPath: pathForFileContentExtension, toPath: pathForFileSqlite3Extension)
                    }
                    catch { throw Destiny2Error.cannotRenameFile  }
                }
            }
        }


    }
    private func removeSqliteDatabase() throws {
        /// ▶ Remove files and Folders.
        guard let folderDocument = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { throw Destiny2Error.cannotGetDocumentFolder }

        let folderDestiny2 = folderDocument.appending(component: self.nameFolderDestiny) // Document/ destiny2
        do {
            try fileManager.removeItem(at: folderDestiny2)
        } catch {
            throw Destiny2Error.cannotFindOrDeleteFolder
        }
    }
}

enum Destiny2Error: Error {
    case errorUrl
    case errorFetching(reason: String)
    case cannotGetDocumentFolder
    case cannotCreateFolder
    case cannotRenameFile
    case cannotRemoveFile
    case cannotFindFilesInTheFolder
    case cannotFindOrDeleteFolder
}

// ==================
// MARK: - Destiny User Default
// use to save data download from serveur of destiny
// ==================

enum DestinyTableDatabase: String {
    case DestinyGenderDefinition
    case DestinyClassDefinition
}


struct DestinyUserDefault {
    /// ▶ GET the key user default.
    fileprivate static let userDefaultKey: String = String(stringLiteral:  "Destiny2Data")

    /// ▶ GET data from userDefault.
    fileprivate static func getData() -> Data? {
        return UserDefaults.standard.data(forKey: userDefaultKey)
    }

    /// ▶ SAVE into userdefault.
    fileprivate static func saveDataUserDefault(_ data: Data) {
        UserDefaults.standard.set(data, forKey:userDefaultKey)
    }

    /// ▶ CHECK if the data exist.
    fileprivate static func isDataExist() -> Bool {
        return UserDefaults.standard.object(forKey: userDefaultKey ) != nil
    }

    /// ▶ DELETE data.
    fileprivate static func deleteData() {
        UserDefaults.standard.removeObject(forKey: userDefaultKey)
    }
}
