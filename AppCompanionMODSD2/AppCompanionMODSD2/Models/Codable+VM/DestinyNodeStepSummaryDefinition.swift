//
// DestinyNodeStepSummaryDefinition.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0

import Foundation

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

