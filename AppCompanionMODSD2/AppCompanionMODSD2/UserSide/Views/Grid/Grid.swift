//
// Grid.swift
// AppCompanionMODSD2
// Created in 2022
// Swift 5.0


import SwiftUI

struct Grid: View {
    var body: some View {
        Color.purple
//            .ignoresSafeArea()
            .overlay(

                    VStack {
                        GeometryReader { geo in
                            ModsRow(geo: geo)
                        }
//                        Spacer()
                    }
                    .background(Color("Background00"))
                    .padding(10)
            )
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid()
            .background(Color.brown)
    }
}

struct ModsRow: View {
    var geo: GeometryProxy


    var body: some View {
        let spacingElement: CGFloat = geo.size.width * 0.005



        VStack(alignment: .leading, spacing: 5) {
            Text("geo : \(geo.size.debugDescription)")
                .foregroundColor(.white)
            // GEO

            // Info Mods
            VStack (alignment: .leading, spacing: 0) {
                HStack(alignment: .bottom, spacing: 0) {
                    // Energy (Square)
                    // left


                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: geo.size.width * 0.1, height: geo.size.width * 0.1)


                    // Energy (Text) + square
                    VStack(alignment: .leading, spacing: 0) {
                        // right
                        Text("8/10 ENERGY")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .lineLimit(0)
                            .controlSize(/*@START_MENU_TOKEN@*/.mini/*@END_MENU_TOKEN@*/)

                        HStack(alignment: .lastTextBaseline, spacing: spacingElement) {
                            ForEach(0..<10) { value in
                                Rectangle()
                                    .fill(value % 2 == 0 ? .white : .orange)
                                    .frame(width: ((geo.size.width * 0.9) / 10 ) - (spacingElement) + (spacingElement / 10), height: 15)

                            }
                        }
                    }
                }
            }

            // Object Mods
            HStack(spacing: 0) {
                ForEach(0..<6) { _ in
                    Image("Default")
                        .resizable()
                        .frame(width: geo.size.width / 6, height: geo.size.width / 6)
                        .padding(0)
                }
            }
        }
    }
}
