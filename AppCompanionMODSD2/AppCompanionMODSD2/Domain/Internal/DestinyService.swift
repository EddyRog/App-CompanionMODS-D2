//
// ALL.swift

import Foundation

// MARK: - UserSide


// MARK: - Domaine
class DestinyService {
    private var destinyDAO: IDestinyDAO

    init(_ destinyDAO: IDestinyDAO) {
        self.destinyDAO = destinyDAO
    }

    func downloadContentDatabaseForMods() -> Data? {
        return destinyDAO.downloadContentDatabaseForMods()
    }
    func downloadContentDatabaseForMods0(completion: @escaping (Result<Data, Error>) -> Void) {
        // url

        completion(.success(Data()))
    }
}
