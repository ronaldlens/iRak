//
//  BottomButtons.swift
//  iRak
//
//  Created by Ronald Lens on 13/08/2023.
//

import SwiftUI

struct BottomButtons: View {
    var model = MapViewModel.shared
    
    var body: some View {
        HStack {
            Button {
                model.showBouys = !model.showBouys
            } label: {
                Label("Boeien", systemImage: "pencil")
            }  
            .buttonStyle(.borderedProminent)
            
            Button {
                model.showReaches = !model.showReaches
            } label: {
                Label("Rakken", systemImage: "arrow.triangle.swap")
            }
            .buttonStyle(.borderedProminent)
            Button {
                
            } label: {
                Label("Dashboard", systemImage: "gauge.with.dots.needle.33percent")
            }
            .buttonStyle(.borderedProminent)
            
        }
        .labelStyle(.iconOnly)
    }
}

#Preview {
    BottomButtons()
}
