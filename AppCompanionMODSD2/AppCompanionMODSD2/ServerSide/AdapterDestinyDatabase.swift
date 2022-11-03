//
// AdapterDestinyDatabase.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation

class AdapterDestinyDatabase: IAdapterDestinyDatabaseManager {
    // "https://www.bungie.net/common/destiny2_content/sqlite/fr/world_sql_content_aa813698cf6492188dde4fa1fe4d38d8.content"
    func downloadDatabase(myUrl: String ,completion: @escaping (Result<Data, AdapterDestinyDatabaseError>) -> Void ) {

        guard let url = URL(string: myUrl) else { completion(.failure(.fetchData)); return }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(.fetchData))
            } else {
                if let data {
                    completion(.success(data))
                } else {
                    completion(.failure(.noData))
                }
            }
        }.resume()
    }
}
