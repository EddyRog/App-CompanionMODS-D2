//
// IAdapterDestinyFileManager.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation

protocol IAdapterDestinyFileManager {
    func changeExtensionToZip(_ pathOfFile: String) throws -> String
    func createFileWithData(path: String, destinyNameFile: String, data: Data) throws -> String
    func deleteFileAtPath(_ tempFile: String) -> Bool
    func unzipDatabase(filepath: String) -> Bool 
}
