//
// APIDestiny2.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation

enum Destiny2API {}

// ==================
// MARK: - Type
// ==================
extension Destiny2API {
    enum request { }
    enum response { }
}

// ==================
// MARK: - Client
// ==================
extension Destiny2API {
    class Client {
        static let shared = Client()
        func fetch() { }
    }
}
