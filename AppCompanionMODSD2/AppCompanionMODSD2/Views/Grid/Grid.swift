//
// Grid.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0

import SwiftUI

struct Grid: View {
    var body: some View {
        Color.purple
            .overlay(
                VStack {
                    ContainerMod()
                }
            )
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid()
            .previewDevice("iPhone 13")
//        Grid()
//            .previewDevice("iPhone 8")
//            .background(Color.brown)
//        Grid()
//            .previewDevice("iPad mini (6th generation)")
    }
}

// Row mod
struct ContainerMod: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GeometryReader { geoGeneral in
                // General Container
                VStack(spacing: 0) {
                    RowMod(geoGeneral: geoGeneral)// row
                    RowMod(geoGeneral: geoGeneral)// row
                    RowMod(geoGeneral: geoGeneral)// row
                    RowMod(geoGeneral: geoGeneral)// row
                    RowMod(geoGeneral: geoGeneral)// row
                }
                
            }

        }
        .background(Color("Background00"))
        .padding(10)
    }
}

struct RowMod: View {
    let geoGeneral: GeometryProxy

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            let maxMods = 6

            // LEFT
            ContainerLeftMod(maxMods: maxMods, geoGeneral: geoGeneral)

            // RIGHT  -------
            ContainerRightMod(maxMods: maxMods, geoGeneral: geoGeneral)
            // ------
        }
    }
}

struct ContainerLeftMod: View {
    let maxMods: Int
    let geoGeneral: GeometryProxy

    var body: some View {
        Group {
            // MODS x 1
            Image("DefaultArmor")
                .resizable()
        }
        .frame(width: (geoGeneral.size.width / CGFloat(maxMods)) * 1, height: (geoGeneral.size.width / CGFloat(maxMods)) * 1)
        .background(.white)
    }
}
struct ContainerRightMod: View {

    let maxMods: Int
    let geoGeneral: GeometryProxy

    var body: some View {
        VStack(spacing: 0) {
            let countMods: Int = maxMods - 1
            let width1TO6: CGFloat = (geoGeneral.size.width) * (1 / CGFloat(maxMods))
            let width5TO6: CGFloat = (geoGeneral.size.width) * (CGFloat(countMods) / CGFloat(maxMods))
            let width2TO12: CGFloat = (2/12)

            // * Right-Top
            // ENERGY
            ContainerEnergy(width5TO6: width5TO6, width2TO12: width2TO12)

            // * Right-Bottom
            // MODS
            ContainerMods(countMods: countMods, width1TO6: width1TO6, width5TO6: width5TO6)
        }
    }
}

struct ContainerEnergy: View {
    let width5TO6: CGFloat
    let width2TO12: CGFloat

    var body: some View {
        GeometryReader { geoEnergyFrame in
            HStack(alignment: .top, spacing: 0) {
                // ENERGY.Right-Top.Leading
                let widthElement: CGFloat = (geoEnergyFrame.size.width / 12) * 2
                let heightElement: CGFloat = (geoEnergyFrame.size.width / 12) * 2
                Image("EnergyStase")
                    .resizable()
                    .frame(width: widthElement, height: heightElement)
                    .background(.red)

                // ENERGY.Right-Top.trailing
                // let widthEnergy: CGFloat = (geoEnergyFrame.size.width / 12) * 10
                let heightEnergy: CGFloat = (geoEnergyFrame.size.width / 12) * 2

                // ********
                // es 🚦🌁🏝☀️🏖🐬🏝🏞🏜🚦
                // Container (Text energy + rectanle energy )
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    // Text energy
                    Text("8/10 ENERGY")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(0)
                        .controlSize(.mini)

                    // Rectangle energy
                    HStack(spacing: 0) {
                        ForEach(0..<10) { value in
                            Rectangle()
                                .fill(value % 2 == 0 ? .white: .orange)
                                .frame(height: heightEnergy * (1 / 4))
                        }

                    }
                }
            }
        }
        .background(.black)
        .foregroundColor(.white)
        .frame(width: width5TO6, height: ( width5TO6 * width2TO12) )
    }
}
struct ContainerMods: View {
    let countMods: Int
    let width1TO6: CGFloat
    let width5TO6: CGFloat

    var body: some View {
        HStack(spacing: 0) {
            //                                        ForEach(0..<5) { _ in
            ForEach(0..<countMods, id: \.self) { _ in
                Image("Default")
                    .resizable()
                    .frame(width: width1TO6, height: width1TO6)
                    .padding(0)
            }
        }
        .frame(width: width5TO6)
        .background(.black)
        .foregroundColor(.white)
    }
}


