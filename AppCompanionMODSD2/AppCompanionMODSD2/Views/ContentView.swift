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
        TabView(selection: $selectedTabIndex) {
            NavigationView {
                Current()
            }
            .tabItem {
                Image(systemName: "wrench.and.screwdriver")
                Text("Current for Test")
            }.tag(0)


            NavigationView {
                VStack {
                    Grid()
                        .onAppear {

                            let service = DestinyService(DestinyDAO())
                            service.downloadContentDatabaseForMods0 { result in
                                switch result {
                                    case .success(_):
                                        print("ok")
                                        selectedTabIndex = 1
                                    case .failure(_):
                                        print("not")
                                }
                            }
                        print("Grid appear")

                    }
                }
            }.tag(1)
            .tabItem {
                Image(systemName: "square.grid.3x1.below.line.grid.1x2")
                Text("Grid")
            }


            NavigationView {
                List {
                    Text("Mods")
                    Text("Mods")
                }
            }.tag(2)
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
