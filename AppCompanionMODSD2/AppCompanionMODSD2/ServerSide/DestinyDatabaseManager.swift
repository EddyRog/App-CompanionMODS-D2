//
// DestinyDatabaseManager.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation
import Zip

class DestinyDatabaseManager {
    static let defaultUrlDatabase: String = "https://www.bungie.net/common/destiny2_content/sqlite/fr/world_sql_content_aa813698cf6492188dde4fa1fe4d38d8.content"
    static var nameDatabase: String = "Destiny" // should be the unique SPM ZIP unzip file inside of folder with the same name of the zip file
    // --
    private static var defaultFileNameDatabase: String { nameDatabase }
    private static var defaultFolderNameDatabase: String { nameDatabase }
    private let manager = FileManager.default
    private var root: URL? {
        manager.urls(for: .documentDirectory, in: .userDomainMask).first
    }

    init() {
        let obj = generateDataBaseDestiny2()
        print(obj.url)
    }

    fileprivate func reGenerateDataBaseDestiny2()  {
        try? downloadDatabase { data in
			// check if data is available before to trash database
            guard let data = data else { return }
            try? self.removeDatabaseFolder()
            try? self.createDatabaseFolder()

            try? self.generateDatabaseSqlite(with: data)
        }
    }
    fileprivate func generateDataBaseDestiny2() -> InfoDataBase {
        guard let root = root else { return  InfoDataBase(url: "") }
//        try? removeDatabaseFolder()
        try? createDatabaseFolder()
        try? downloadDatabase { data in
            guard let data = data else { return }
            try? self.generateDatabaseSqlite(with: data)
        }

        let urlPathDatabase = root.appending(component: DestinyDatabaseManager.defaultFolderNameDatabase).appending(component: DestinyDatabaseManager.defaultFileNameDatabase + ".sqlite3").relativePath
        return InfoDataBase(url: urlPathDatabase)
    }
}

extension DestinyDatabaseManager {

    private func createDatabaseFolder(folderName: String = defaultFolderNameDatabase) throws {
        guard let root = root else { throw DestinyDatabaseManagerError.emptyUrlsArray }

        let folder = root.appending(component: folderName)
        do {
            try manager.createDirectory(at: folder, withIntermediateDirectories: true)
        } catch {
            throw DestinyDatabaseManagerError.cannotCreateFolder
        }
    }

    private func removeDatabaseFolder(folderName: String = "\(defaultFolderNameDatabase)") throws {
        guard let root = root else { throw DestinyDatabaseManagerError.emptyUrlsArray }

        do {
            let pathFolderToRemove = root.appending(component: folderName)
            try manager.removeItem(at: pathFolderToRemove)
        } catch {
            throw DestinyDatabaseManagerError.cannotFindOrDeleteFolder
        }
    }

    private func downloadDatabase(destinyUrl: String = defaultUrlDatabase, completionHandler: @escaping (_ data: Data?) -> Void) throws {
        guard let urlDataBase = URL(string: destinyUrl) else {
            throw DestinyDatabaseManagerError.errorEndPointDatabase
        }

        URLSession.shared.dataTask(with: urlDataBase) { data, response, error in
            completionHandler(data)
        }.resume()
    }

    private func generateDatabaseSqlite(fileZipped: String = "\(defaultFileNameDatabase).zip",with  dataFile: Data = Data(), at nameOfRootFolder: String = defaultFolderNameDatabase) throws {
        let extensionToChange: String =  "content"
        let extensionToAdd: String =  "sqlite3"
        guard let root = root else { throw DestinyDatabaseManagerError.emptyUrlsArray }

        let rootFolder = root.appending(component: nameOfRootFolder)

        // --- Check If the File Exist.
        if manager.fileExists(atPath: rootFolder.relativePath) {
            let rootFile: URL = rootFolder.appending(component: fileZipped)

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

                let oldNameDatabase = fileZipped as NSString // DestinyDatabase.zip
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

    struct InfoDataBase {
        var url: String
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
