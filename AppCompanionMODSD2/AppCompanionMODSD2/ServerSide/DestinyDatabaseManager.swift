//
// DestinyDatabaseManager.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation
import Zip

let defaultFileNameDatabase: String = String(stringLiteral: "DestinyDatabase")
let defaultFolderNameDatabase: String = String(stringLiteral: "Destiny")

class DestinyDatabaseManager {

    init() {
        initDatabaseFromBungie()

//        do {
//            // setup for un zip
//            let manager: FileManager = FileManager.default
//            let path = manager.urls(for: .documentDirectory, in: .userDomainMask)
//            let folder = path[0].appendingPathComponent(defaultFileNameDatabase)
//            let filePath = folder.appendingPathComponent(defaultFileNameDatabase + ".zip")
//
//			// zip
//            _ = try Zip.quickUnzipFile(filePath) // unzip destiny.zip
//            _ = try manager.removeItem(atPath: filePath.relativePath) // remove destiny.zip
//
//            // read inside of the file
//            let files = try? manager.contentsOfDirectory(atPath: folder.relativePath)
//
//            // list all the file inside
//            for file in files ?? [] {
//                if file.contains(.localizedName(of: ".content".fastestEncoding)) {
//                    print("ok")
//                } else {
//                    print("not")
//                }
//
//				// if the only file containt the extension .content
//                // rename it
//                // and change the extension
//            }
//        }
//        catch {
//            print("Something went wrong")
//        }
    }

    func initDatabaseFromBungie() {
        // remove, create folder download, create filezipé
//		downloadDatabase()


        let manager: FileManager = FileManager.default
        let rootBase = manager.urls(for: .documentDirectory, in: .userDomainMask) // /Users/eddy.rogier/Library/Developer/CoreSimulator/Devices/B0391668-5E0E-48F8-BB63-74762488CBD2/data/Containers/Data/Application/AE6D65B2-C76A-42AC-BD8E-3EF0CED0BE17/Documents/
        let rootDestinyFolder = rootBase[0].appendingPathComponent(defaultFileNameDatabase)  // /Documents/DestinyDatabase/

        // get zip file
        let rootFileZip = rootDestinyFolder.appendingPathComponent(defaultFileNameDatabase + ".zip") // Documents/DestinyDatabase/DestinyDatabase.zip

        // unzip it
        _ = try? Zip.quickUnzipFile(rootFileZip) // unzip destiny.zip
        // remove zip file
        _ = try? manager.removeItem(atPath: rootFileZip.relativePath) // remove destiny.zip

        // get folder
        let files = try? manager.contentsOfDirectory(atPath: rootDestinyFolder.relativePath)

        // parse everything inside
        for file in files ?? [] {
            // get only the file with content
            let filename = file as NSString
            let extensionFile = filename.pathExtension

            // get file unzip
            if extensionFile == "content" {
                let prefix = filename.deletingPathExtension as NSString
                let newFileName = prefix.appendingPathExtension("sqlite3")
                // MARK: - Rename
                try? manager.moveItem(atPath: rootDestinyFolder.appendingPathComponent(file).relativePath,
                                      toPath: rootDestinyFolder.appendingPathComponent(newFileName ?? "f").relativePath)

            }
        }

        // rename it

        // change extension
    }

	// ✔︎
    /// ▶ Create.
    func createFolderInDocumentFromIphone(_ folderName: String = defaultFileNameDatabase) {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let folder = url.appendingPathComponent(folderName)
        do {
            try manager.createDirectory(at: folder, withIntermediateDirectories: true)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    /// ▶ Delete/Remove.
    func removeFolderInDocumentFromIphone() {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }


        do {
            let pathForRemove = url.appendingPathComponent(defaultFileNameDatabase)
            try manager.removeItem(atPath: pathForRemove.path)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    /// ▶ Create a file with content. //!\ ◼︎◼︎◼︎ Important ◼︎◼︎◼︎ /!\\ need to create folder before
    func createFileInDocumentFromIphone(contentDatabase: Data) {
        // --- create file.
        let manager: FileManager = FileManager.default
        let path = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let folder = path[0].appendingPathComponent(defaultFileNameDatabase)
        let file = folder.appendingPathComponent(defaultFileNameDatabase + ".zip")
        manager.createFile(atPath: file.relativePath, contents: contentDatabase)
    }

    /// ▶ Download Database in.
    func downloadDatabase() {
        guard let urlDataBase = URL(string: "https://www.bungie.net/common/destiny2_content/sqlite/fr/world_sql_content_aa813698cf6492188dde4fa1fe4d38d8.content") else { return }
        URLSession.shared.dataTask(with: urlDataBase) { (database, response, error) in

            // ****************** save file
            if let data = database {
                // there is data
                self.removeFolderInDocumentFromIphone()
                self.createFolderInDocumentFromIphone()
                self.createFileInDocumentFromIphone(contentDatabase: data)
            }
//            self.createFileInDocumentFromIphone())
            // ******************

        }.resume()
        print("nop")
    }



}

// ✘
extension  DestinyDatabaseManager {
    /// ▶ Get.
    func getPathDataBase(_ databaseName: String = defaultFileNameDatabase) {
        let cheminDossier = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        debugPrint("dee L\(#line) 🏵 ------->  ⬇️")
        debugPrint("dee L\(#line) 🏵 ------->  ➡️ ", cheminDossier?.debugDescription as Any , "◀️")
        debugPrint("dee L\(#line) 🏵 ------->  ⬆️ ")
    }
}
