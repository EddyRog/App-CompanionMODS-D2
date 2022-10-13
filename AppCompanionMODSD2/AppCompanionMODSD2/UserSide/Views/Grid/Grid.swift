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
                VStack(alignment: .leading, spacing: 0) {

                    GeometryReader { geoGeneral in

                        // General Container
                        VStack(spacing: 0) {
                            // Left and Right
                            HStack(alignment: .bottom, spacing: 0) {

                                // LEFT
                                Group {
                                    // MODS x 1
                                    Image("Default")
                                        .resizable()
                                }
                                .frame(width: (geoGeneral.size.width / 6) * 1, height: (geoGeneral.size.width / 6) * 1)
                                .background(.white)

                                // RIGHT  -------
                                VStack(spacing: 0) {
                                    // * Right-Top
                                    // ENERGY
                                    let width5TO6: CGFloat = (geoGeneral.size.width) * (5/6)
                                    let width2TO12: CGFloat = (2/12)

                                    GeometryReader { geoEnergyFrame in
                                        HStack(spacing: 0) {
                                            let widthElement: CGFloat = (geoEnergyFrame.size.width / 12) * 2
                                            let heightElement: CGFloat = (geoEnergyFrame.size.width / 12) * 2
                                            Text("left")
                                                .frame(width: widthElement, height: heightElement)
                                            .background(.red)

                                            let widthEnergy: CGFloat = (geoEnergyFrame.size.width / 12) * 10
                                            let heightEnergy: CGFloat = (geoEnergyFrame.size.width / 12) * 2
                                            Text("right")
                                                .frame(width: widthEnergy, height: heightEnergy)
                                            .background(.green)
                                        }
                                    }
                                    .background(.black)
                                    .foregroundColor(.white)
                                    .frame(width: (geoGeneral.size.width / 6) * 5, height: ( width5TO6 * width2TO12) )

                                    // * Right-Bottom
                                    // MODS
                                    HStack(spacing: 0) {
                                        ForEach(0..<5) { _ in
                                            Image("Default")
                                                .resizable()
                                                .frame(width: (geoGeneral.size.width / 6) * 1, height: (geoGeneral.size.width / 6) * 1)
                                                .padding(0)
                                        }
                                    }
                                    .frame(width: (geoGeneral.size.width / 6) * 5)
                                    .background(.black)
                                    .foregroundColor(.white)
                                }
                                // ------
                            }
                        }
                    }

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
            // --- Row.
            GeometryReader { geoRight in
                // --- Row n°1.
                //                VStack(spacing: 0) {
                //                    // --- ROW Line 1.
                HStack(alignment: .bottom, spacing: 0) {
                    // --- SUB-LEFT side.
                    Text("Armor")
                        .frame(maxWidth: .infinity)
                        .frame(height: geoRight.size.width / 6)
                        .padding(0)
                        .background(.white)


                    // --- SUB-RIGHT side.
                    VStack(alignment:.leading ,spacing: 0) {
                        Text("Mods Top, \(geoRight.size.width)")
                            .foregroundColor(.white)
                            .frame(minHeight: 50)
                            .background(Color.yellow)
                        // --- TOP.
                        EnergyView(geoRight: geoRight)

                        // --- Bottom.
                        ModsView(geo: geoRight)
                    }
                    .background(Color.red)
                }
                //                }
                //                .background(Color.pink)


            }

            // Info Mods
            //            VStack (alignment: .leading, spacing: 0) {
            //                HStack(alignment: .bottom, spacing: 0) {
            //                    // Energy (Square)
            //                    // left Element Type
            //                    Rectangle()
            //                        .fill(Color.blue)
            //                        .frame(width: geo.size.width * 0.1, height: geo.size.width * 0.1)
            //
            //                    // Energy (Text) + square
            //                    VStack(alignment: .leading, spacing: 0) {
            //                        // right
            //                        Text("8/10 ENERGY")
            //                            .font(.footnote)
            //                            .fontWeight(.bold)
            //                            .foregroundColor(Color.white)
            //                            .lineLimit(0)
            //                            .controlSize(/*@START_MENU_TOKEN@*/.mini/*@END_MENU_TOKEN@*/)
            //
            //                        HStack(alignment: .lastTextBaseline, spacing: spacingElement) {
            //                            ForEach(0..<10) { value in
            //                                Rectangle()
            //                                    .fill(value % 2 == 0 ? .white : .orange)
            //                                    .frame(width: ((geo.size.width * 0.9) / 10 ) - (spacingElement) + (spacingElement / 10), height: 15)
            //
            //                            }
            //                        }
            //                    }
            //                }
            //            }

            // Object Mods
            //            HStack(spacing: 0) {
            //                ForEach(0..<5) { _ in
            //                    Image("Default")
            //                        .resizable()
            //                        .frame(width: geo.size.width / 6, height: geo.size.width / 6)
            //                        .padding(0)
            //                }
            //            }
        }
    }
}

struct EnergyView: View {
    var geoRight: GeometryProxy
    var body: some View {


        HStack(alignment: .bottom, spacing: 0) {
            /*
             // Energy (Square)
             // left Element Type
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
             */
        }



        //        Text("Mods Top, \(geoRight.size.width)")
        //            .foregroundColor(.white)
        //            .frame(minHeight: 50)
        //            .background(Color.yellow)
    }
}

struct ModsView: View {
    var geo: GeometryProxy
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5) { _ in
                Image("Default")
                    .resizable()
                    .frame(width: geo.size.width / 6, height: geo.size.width / 6)
                    .padding(0)
            }
        }
        //        Text("Mods Bottom")
        //            .foregroundColor(.white)
        //            .frame(maxWidth: geo.size.width * 0.8, minHeight: 50)
        //            .background(Color.orange)
    }
}
