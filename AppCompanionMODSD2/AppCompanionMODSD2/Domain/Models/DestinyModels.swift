//
// DestinyModels.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation

// ==================
// MARK: - Model + Codable
// ==================

// MARK: - 	Gender
struct Gender {
    var id: Int
    var hash: Int
    var name: String
}
struct GenderCodable: Decodable {
    let hash: Int
    let displayProperties: GenderDisplayProperties
}
struct GenderDisplayProperties: Codable {
    let name: String
}
