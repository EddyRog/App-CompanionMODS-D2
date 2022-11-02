//
// AdapterDestinyFileManager.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation

class AdapterDestinyFileManager: IAdapterDestinyFileManager {

    func changeExtensionToZip(_ pathOfFile: String) throws -> String {
        if let destinyUrl = URL(string: pathOfFile) {
            let pathWithoutExtension = destinyUrl.deletingPathExtension()
            let pathWithZipExtension: URL = pathWithoutExtension.appendingPathExtension("zip")
            let fileName: String = pathWithZipExtension.lastPathComponent
            return fileName
        }
        throw AdapterDestinyFileManagerError.changeExtensionToZip
    }

    func createFileWithData(path: String, destinyNameFile: String, data: Data) throws -> String {
        let fileManager = FileManager.default
        let isFileCreated: Bool = fileManager.createFile(atPath: "\(path)\(destinyNameFile)", contents: data)
        if isFileCreated {
            return "\(path)\(destinyNameFile)"
        }
        throw AdapterDestinyFileManagerError.createFile
    }

    func deleteFileAtPath(_ file: String) -> Bool {
        let fileManager: FileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: file)
            return true
        } catch {
            return false
        }
    }

}
