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
    
    var body: some View {
        Map {
            ForEach(datas.boeien, id: \.self) { boei in
                Marker(boei.naam, coordinate: boei.location)
            }
        }
    }
    
}

#Preview {
    ContentView()
}
