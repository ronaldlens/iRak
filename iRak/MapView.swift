//
//  ContentView.swift
//  iRak
//
//  Created by Ronald Lens on 12/08/2023.
//

import SwiftUI
import SwiftData
import MapKit

struct MapView: View {
    var model = MapViewModel.shared
    
    var body: some View {
        Map {
            if model.showBouys {
                ForEach(model.reachData.bouys, id: \.self) { bouy in
                    Annotation(
                        bouy.name,
                        coordinate: bouy.location,
                        anchor: .bottom
                    ) {
                        Image(systemName: "pencil")
                            .imageScale(.small)
                            .padding(2)
                            .foregroundStyle(.white)
                            .background(Color.indigo)
                            .cornerRadius(10)
                        
                    }
                    
                }
            }
            
            if model.showReaches {
                ForEach(model.reachData.reaches, id: \.self) { reach in
                    MapPolyline(coordinates: reach.coords)
                        .stroke(.green, lineWidth: 2)
                }
            }
            
        }
//        .mapControls() {
//            MapUserLocationButton()
//        }
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
    MapView()
}
