//
// DestinyDAO.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation

//class DestinyDAO: IDestinyDAO {
//    var serviceDataBase = ServiceDatabase()
//    func downloadContentDatabaseForMods() -> Data? {
//        var  dataFetchToReturn: Data?
//
//        ServiceDatabase().download { result in
//            print("coucou")
//            switch result {
//                case .failure(_):
//                    dataFetchToReturn = nil
//                case .success(let data):
//                    dataFetchToReturn = data
//            }
//        }
//
//        return dataFetchToReturn
//    }
//}
//
//class ServiceDatabase {
//    func download(completion: @escaping (Result<Data, Error>) -> Void) {
//        guard let url = URL(string: "https://api.agify.io/?name=eddy") else { return }
//        let urlRequest = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            if let _ = error {
//                completion(Result.failure(DestinyError.NoData))
//            } else {
//                if let myData = data {
//                    completion(Result.success(myData))
//                } else {
//                    completion(Result.failure(DestinyError.NoData))
//                }
//            }
//        }
//    }
//}
//
//enum DestinyError: Error, Equatable {
//    case NoData
//}
