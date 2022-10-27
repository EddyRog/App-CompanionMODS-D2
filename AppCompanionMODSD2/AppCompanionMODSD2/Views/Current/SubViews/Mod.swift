//
// Mods.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import SwiftUI

// ==================
// MARK: - CustomView
// ==================
struct Mod: View {
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

struct ModsPresentation_Previews: PreviewProvider {
    static var previews: some View {
        Mod(imageName: "Default", titleMod: "ModsPresentation")
    }
}
