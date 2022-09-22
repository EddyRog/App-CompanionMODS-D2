//
// All.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0

import Foundation

// swiftlint:disable type_name
// swiftlint:disable line_length
// --- Generique.
enum Constant: String {
    case urlbase = "https://www.bungie.net/"
    case jsonDestinyNodeStepSummaryDefinition = "common/destiny2_content/json/fr/DestinyNodeStepSummaryDefinition-c749fcce-2388-496f-b5a6-4859830183e4.json"
}

// ==================
// MARK: - WebService
// ==================
class WebService {
	// --- ResponseJsonDestinyNodeStepSummaryDefinition.
    func fetchData(with url: String = Constant.urlbase.rawValue + Constant.jsonDestinyNodeStepSummaryDefinition.rawValue) async throws -> ResponseJsonDestinyNodeStepSummaryDefinition? {
        guard let unwUrl = URL(string: url) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: unwUrl)
        let response = try JSONDecoder().decode(ResponseJsonDestinyNodeStepSummaryDefinition.self, from: data)

        return response
    }
}

// ==================
// MARK: - jsonDestinyNodeStepSummaryDefinition
// ==================

// --- Response.
typealias ResponseJsonDestinyNodeStepSummaryDefinition = [String: ResponseJsonDestinyNodeStepSummaryDefinitionValue]
// --- Codable.
struct ResponseJsonDestinyNodeStepSummaryDefinitionValue: Codable {
	#warning("dee 🔲 match Key only")
    var displayProperties: DisplayProperties
}
struct DisplayProperties: Codable {
    var name: String
    var icon: String?
}

// --- Model.
struct ResponseJsonDestinyNodeStepSummaryDefinitionValueModel: Identifiable {
    var id = UUID()
    var key: String
    var name: String
    var icon: String?
}

// --- ViewModel.
@MainActor // allow to replace DispatchQueue.main.async
class ResponseJsonDestinyNodeStepSummaryDefinitionViewModel: ObservableObject {

    // --- Expose to the view.
    @Published var results: [ResponseJsonDestinyNodeStepSummaryDefinitionValueModel] = []

    func getData() async {
        do {
            // get data response from the server
            let response = try await WebService().fetchData()

            // extract data
            response?.forEach({ (key: String, value: ResponseJsonDestinyNodeStepSummaryDefinitionValue) in

                let key = key
                let name = value.displayProperties.name
                let icon = value.displayProperties.icon

                self.results.append(
                    ResponseJsonDestinyNodeStepSummaryDefinitionValueModel(
                        key: key,
                        name: name,
                        icon: icon
                    )
                )
            })

        } catch let error {
            debugPrint("dee L\(#line) 🏵 -------> Error fetching => ", error.localizedDescription)
        }
    }
}
