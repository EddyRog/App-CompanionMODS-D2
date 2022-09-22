//
// ContentView.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0

import Collections
import SwiftUI

struct ContentView: View {
    @StateObject private var responseJsonDestinyNodeStepSummaryDefinitionViewModel = ResponseJsonDestinyNodeStepSummaryDefinitionViewModel()
    var body: some View {
        VStack {
            List {
                ForEach(responseJsonDestinyNodeStepSummaryDefinitionViewModel.results) { row in
                    HStack {
                        // --- Image.
                        if let urlString = row.icon {
                            AsyncImage(url: URL(string: Constant.urlbase.rawValue + urlString)) { image in
                                image
                                    .resizable()

                            } placeholder: { Color.red }
                                .background(Color.blue)
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        } else {
                            Image(systemName: "person")

                        }
                        Text("\(row.name)")
                    }
                }
            }
        }.onAppear {
            Task {
                await responseJsonDestinyNodeStepSummaryDefinitionViewModel.getData() // delegue this to VM
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
