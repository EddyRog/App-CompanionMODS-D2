//
// ContentView.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0

import Collections
import SwiftUI

struct ContentView: View {
    @State private var selectedTabIndex = 1
    var body: some View {
        TabView {

            NavigationView {
                Current()
            }
            .tabItem {
                Image(systemName: "person")
                Text("Current")
            }


            NavigationView {
                List {
                    NavigationLink("responseJsonDestinyNodeStepSummaryDefinitionViewModel") {
                        NodeStepSummary()
                    }
                }
            }
            .tabItem {
                Image(systemName: "externaldrive")
                Text("OK")
            }
        }

    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// ==================
// MARK: - Subview
// ==================

struct NodeStepSummary: View {
    @StateObject private var responseJsonDestinyNodeStepSummaryDefinitionViewModel = NodeStepSummaryViewModel()
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
struct Current: View {
//    @StateObject private var nodeStepSummaryViewModel = ResponseNodeStepSummaryViewModel()
    var body: some View {
        VStack {
//            List {
//                ForEach(nodeStepSummaryViewModel.results) { row in
//                    HStack {
//                        // --- Image.
//                        if let urlString = row.icon {
//                            AsyncImage(url: URL(string: Constant.urlbase.rawValue + urlString)) { image in
//                                image
//                                    .resizable()
//
//                            } placeholder: { Color.red }
//                                .background(Color.blue)
//                                .frame(width: 50, height: 50)
//                                .clipShape(RoundedRectangle(cornerRadius: 25))
//                        } else {
//                            Image(systemName: "person")
//
//                        }
//                        Text("\(row.name)")
//                    }
//                }
//            }
        }.onAppear{
            Task {
//                await nodeStepSummaryViewModel.getData() // delegue this to VM
            }
        }
    }
}
