//
// DestinyDatabaseManager.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation
import Zip

let defaultFileNameDatabase: String = "DestinyDatabase"
let defaultFolderNameDatabase: String = String(stringLiteral: "Destiny")

class DestinyDatabaseManager {

    init() {
        try? removeDatabaseFolder(folderName: "DestinyDatabaseEDDY")
        try? createDatabaseFolder()
        try? downloadDatabase { data in
            guard let data = data else { return }

            try? self.generateDatabaseSqlite(with: data)
        }
    }

    func createDatabaseFolder() throws {
        let manager = FileManager.default
        guard let root = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw DestinyDatabaseManagerError.emptyUrlsArray
        }

        let folderName: String = String(stringLiteral: "DestinyDatabase")
        let folder = root.appending(component: folderName)
        do {
            try manager.createDirectory(at: folder, withIntermediateDirectories: true)
        } catch {
            throw DestinyDatabaseManagerError.cannotCreateFolder
        }
    }
    func removeDatabaseFolder(folderName:String) throws {
        let manager = FileManager.default
        guard let root = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw DestinyDatabaseManagerError.emptyUrlsArray
        }

        do {
            let pathFolderToRemove = root.appending(component: folderName)
            try manager.removeItem(at: pathFolderToRemove)
        } catch {
            throw DestinyDatabaseManagerError.cannotFindOrDeleteFolder
        }
    }
    func downloadDatabase(destinyUrl: String = "https://www.bungie.net/common/destiny2_content/sqlite/fr/world_sql_content_aa813698cf6492188dde4fa1fe4d38d8.content", completionHandler: @escaping (_ data: Data?) -> Void) throws {
        guard let urlDataBase = URL(string: destinyUrl) else {
            throw DestinyDatabaseManagerError.errorEndPointDatabase
        }

        URLSession.shared.dataTask(with: urlDataBase) { data, response, error in
                completionHandler(data)
        }.resume()
    }
    func generateDatabaseSqlite(fileName: String = "DestinyDatabase.zip",with  dataFile: Data = Data(), at nameOfRootFolder: String = "DestinyDatabase") throws {
        let extensionToChange: String =  "content"
        let extensionToAdd: String = String(stringLiteral: "sqlite3")
        let manager = FileManager.default
        guard let root = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw DestinyDatabaseManagerError.emptyUrlsArray
        }
        let rootFolder = root.appending(component: nameOfRootFolder)

        // --- Check If the File Exist.
        if manager.fileExists(atPath: rootFolder.relativePath) {
            let rootFile: URL = rootFolder.appending(component: fileName)

            // --- Create Zip file with data.
            manager.createFile(atPath: rootFile.relativePath, contents: dataFile)

            // --- Get the zip file .
            do { _ = try Zip.quickUnzipFile(rootFile) } catch { throw DestinyDatabaseManagerError.unzipFileImpossible }

            // --- Delete the zipped file.
            do { _ = try manager.removeItem(at: rootFile) } catch { throw DestinyDatabaseManagerError.removeFileImpossible }

            //
            // --- Get all files in the folder.
            guard let files = try? manager.contentsOfDirectory(atPath: rootFolder.relativePath) else { throw DestinyDatabaseManagerError.noFilesFoundsInTheFolder }

            for file in files {
                // --- cast the current file for convenience access.
                let filename = file as NSString // world_sql_content_aa813698cf6492188dde4fa1fe4d38d8.content

                let oldNameDatabase = fileName as NSString // DestinyDatabase.zip
                let prefixOldNameDatabase = oldNameDatabase.deletingPathExtension as NSString // "DestinyDatabase"

                guard let newNameDatabase =  prefixOldNameDatabase.appendingPathExtension(extensionToAdd) else { throw DestinyDatabaseManagerError.changesExtensionDatabaseImpossible }

                if filename.pathExtension == extensionToChange {
                    do {
                        // --- Rename database of destiny.
                        try manager.moveItem(atPath: rootFolder.appending(path: file).relativePath ,
                                             toPath: rootFolder.appending(path: newNameDatabase).relativePath)
                    } catch {  throw DestinyDatabaseManagerError.cannotRenameFile }
                }
            }

        } else {
            throw DestinyDatabaseManagerError.folderDoesntExist
        }
    }
}

enum DestinyDatabaseManagerError: Error {
    case cannotCreateFolder
    case emptyUrlsArray
    case cannotFindOrDeleteFolder
    case errorEndPointDatabase
    case folderDoesntExist
    case unzipFileImpossible
    case removeFileImpossible
    case noFilesFoundsInTheFolder
    case cannotRenameFile
    case changesExtensionDatabaseImpossible
}
