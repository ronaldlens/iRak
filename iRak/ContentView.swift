//
//  ContentView.swift
//  iRak
//
//  Created by Ronald Lens on 12/08/2023.
//

import SwiftUI
import SwiftData
import MapKit

struct ContentView: View {
    @State var datas = ReadData()
    @State var showBoeien = true
    @State var showRakken = true
    
    var body: some View {
        Map {
            if showBoeien {
                ForEach(datas.boeien, id: \.self) { boei in
                    Annotation(
                        boei.naam,
                        coordinate: boei.location,
                        anchor: .bottom
                    ) {
                        Image(systemName: "arrow.down.to.line.compact")
                            .imageScale(.small)
                            .padding(2)
                            .foregroundStyle(.white)
                            .background(Color.indigo)
                            .cornerRadius(10)
                        
                    }
                }
            }
            
            if showRakken {
                ForEach(datas.rakken, id: \.self) { rak in
                    MapPolyline(coordinates: rak.coords)
                        .stroke(.green, lineWidth: 2)
                }
            }
            
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                BottomButtons()
                    .padding(.top)
                Spacer()
            }
            .background(.thinMaterial)
        }
    }
    
}

#Preview {
    ContentView()
}
