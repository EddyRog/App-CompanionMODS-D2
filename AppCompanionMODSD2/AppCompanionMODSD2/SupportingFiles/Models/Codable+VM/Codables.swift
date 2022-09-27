//
// DestinyNodeStepSummaryDefinition.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0

import Foundation

// ==================
// MARK: - NodeStepSummary
// ==================
// --- Response.
typealias NodeStepSummaryResponse = [String: NodeStepSummaryDefinitionResponseValue]
// --- Codable.
struct NodeStepSummaryDefinitionResponseValue: Codable {
    #warning("dee 🔲 match Key only")
    var displayProperties: DisplayPropertiesCodable
}
struct DisplayPropertiesCodable: Codable {
    var name: String
    var icon: String?
}
// --- Model.
struct NodeStepSummaryModel: Identifiable {
    var id = UUID()
    var key: String
    var name: String
    var icon: String?
}
// --- ViewModel.
@MainActor // allow to replace DispatchQueue.main.async
class NodeStepSummaryViewModel: ObservableObject {

    // --- Expose to the view.
    @Published var results: [NodeStepSummaryModel] = []

    func getData() async {
        do {
            // get data response from the server
            let response = try await WebService().fetchData()

            // extract data
            response?.forEach({ (key: String, value: NodeStepSummaryDefinitionResponseValue) in

                let key = key
                let name = value.displayProperties.name
                let icon = value.displayProperties.icon

                self.results.append(
                    NodeStepSummaryModel(
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

