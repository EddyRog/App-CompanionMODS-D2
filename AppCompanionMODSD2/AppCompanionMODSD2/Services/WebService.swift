//
// WebService.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import Foundation

class WebService {
    // --- ResponseJsonDestinyNodeStepSummaryDefinition.
    func fetchData(with url: String = Constant.urlbase.rawValue + Constant.jsonDestinyNodeStepSummaryDefinition.rawValue) async throws -> NodeStepSummaryResponse? {
        guard let unwUrl = URL(string: url) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: unwUrl)
        let response = try JSONDecoder().decode(NodeStepSummaryResponse.self, from: data)

        return response
    }
}
