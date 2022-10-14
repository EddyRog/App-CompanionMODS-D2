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

                                let maxMods = 6
                                // LEFT
                                Group {
                                    // MODS x 1
                                    Image("Empty")
                                        .resizable()
                                }
                                .frame(width: (geoGeneral.size.width / CGFloat(maxMods)) * 1, height: (geoGeneral.size.width / CGFloat(maxMods)) * 1)
                                .background(.white)

                                // RIGHT  -------
                                VStack(spacing: 0) {
                                    let countMods: Int = maxMods - 1
                                    let width1TO6: CGFloat = (geoGeneral.size.width) * (1 / CGFloat(maxMods))
                                    let width5TO6: CGFloat = (geoGeneral.size.width) * (CGFloat(countMods) / CGFloat(maxMods))
                                    let width2TO12: CGFloat = (2/12)

                                    // * Right-Top
                                    // ENERGY
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
                                            let widthEnergy: CGFloat = (geoEnergyFrame.size.width / 12) * 10
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
                                                    //                                                // Energy (Square)
                                                    //                                                // left Element Type
                                                    //                                                Rectangle()
                                                    //                                                    .fill(Color.blue)
                                                    //                                                    .frame(width: geo.size.width * 0.1, height: geo.size.width * 0.1)
                                                    //
                                                    //                                                // Energy (Text) + square
                                                    //                                                VStack(alignment: .leading, spacing: 0) {
                                                    //                                                    // right
                                                    //                                                    Text("8/10 ENERGY")
                                                    //                                                        .font(.footnote)
                                                    //                                                        .fontWeight(.bold)
                                                    //                                                        .foregroundColor(Color.white)
                                                    //                                                        .lineLimit(0)
                                                    //                                                        .controlSize(/*@START_MENU_TOKEN@*/.mini/*@END_MENU_TOKEN@*/)
                                                    //
                                                    //                                                    HStack(alignment: .lastTextBaseline, spacing: spacingElement) {
                                                    //                                                        ForEach(0..<10) { value in
                                                    //                                                            Rectangle()
                                                    //                                                                .fill(value % 2 == 0 ? .white : .orange)
                                                    //                                                                .frame(width: ((geo.size.width * 0.9) / 10 ) - (spacingElement) + (spacingElement / 10), height: 15)
                                                    //
                                                    //                                                        }
                                                    //                                                    }
                                                    //                                                }
                                                }
                                            }


                                            // $$$$$$$
//                                            Text("right")
//                                                .frame(width: widthEnergy, height: heightEnergy)
//                                        	    .background(.green)
                                        }
                                    }
                                    .background(.black)
                                    .foregroundColor(.white)
                                    .frame(width: width5TO6, height: ( width5TO6 * width2TO12) )


                                    // * Right-Bottom
                                    // MODS
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
            .previewDevice("iPhone 13")
        Grid()
            .previewDevice("iPhone 8")
            .background(Color.brown)
        Grid()
            .previewDevice("iPad mini (6th generation)")
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
