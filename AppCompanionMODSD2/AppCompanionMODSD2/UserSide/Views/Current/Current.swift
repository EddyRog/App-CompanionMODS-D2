//
// Current.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import SwiftUI

// ==================
// MARK: - Subview
// ==================
struct Current: View {
    @StateObject var viewModel = Singleton.sharedInstance.dataMods
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.items, id: \.self) { item in
                    Mod(imageName: "Default", titleMod: item)
                }
            }
        }.onAppear {
            // TODO: ❎ Impl ❎
//            _ = Destiny2SQLITEManager()
        }
    }
}

struct Current_Previews: PreviewProvider {
    static var previews: some View {
        Current()
    }
}
