//
// ContentView.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0

import SwiftUI

struct ContentView: View {
    @State private var selectedTabIndex = 1
    init() {
        DestinyDatabaseManager()
    }


    // SwiftUI
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
                    }
                }
            }
        }.onAppear {
            Task {
            //    await responseJsonDestinyNodeStepSummaryDefinitionViewModel.getData() // delegue this to VM
            }
        }
    }
}
struct Current: View {
    var body: some View {
        VStack {
            List {
                HStack {
                    AsyncImage(url: URL(string: "https://www.bungie.net/common/destiny2_content/icons/78ea8b00831b7a02c3e89b68dc3b0d1a.png")! )
                        .background(Color.gray)
                    Text("Mod")
                }
            }
        }.onAppear {
            Task {
//                await nodeStepSummaryViewModel.getData() // delegue this to VM
            }
        }
    }
}


/*
 // connection database sqlit to ios app
 // update database
 // get data transform to json object
 // play with json object
 // make a grid for Manager of mods
 */
