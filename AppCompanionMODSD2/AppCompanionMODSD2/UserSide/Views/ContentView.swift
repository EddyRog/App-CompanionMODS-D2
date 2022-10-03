//
// ContentView.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0

import SwiftUI

// ==================
// MARK: - Data
// ==================
class ViewModelMods: ObservableObject {
	@Published var items =  ["A", "B", "C"]
}

public class Singleton: ObservableObject {
    public static let sharedInstance = Singleton()
    @Published var dataMods = ViewModelMods()
}

// ==================
// MARK: - UserSide
// ==================
struct ContentView: View {
    @State private var selectedTabIndex = 1

    // SwiftUI
    var body: some View {
        TabView {
            NavigationView {
                Current()
            }
            .tabItem {
                Image(systemName: "wrench.and.screwdriver")
                Text("Current for Test")
            }


            NavigationView {
                VStack {
                 Text("Grid")
                }
            }
            .tabItem {
                Image(systemName: "square.grid.3x1.below.line.grid.1x2")
                Text("grid")
            }


            NavigationView {
                List {
                    Text("Mods")
                    Text("Mods")
                }
            }
            .tabItem {
                Image(systemName: "square.stack")
                Text("All Mods")
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
struct Current: View {
    @StateObject var viewModel = Singleton.sharedInstance.dataMods

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.items, id: \.self) { item in
                    ModsPresentation(imageName: "Default", titleMod: item)
                }
            }
        }.onAppear {
            Destiny2SQLITEManager()
        }
    }
}

// ==================
// MARK: - CustomView
// ==================
struct ModsPresentation: View {
    var imageName: String
    var titleMod: String

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 100, height: 100)
            Text(titleMod)
        }
    }
}
