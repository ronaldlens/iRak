//
//  BottomButtons.swift
//  iRak
//
//  Created by Ronald Lens on 13/08/2023.
//

import SwiftUI

struct BottomButtons: View {
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Label("Boeien", systemImage: "arrow.down.to.line.compact")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                
            } label: {
                Label("Rakken", systemImage: "road.lanes")
            }
            .buttonStyle(.borderedProminent)
        }
        .labelStyle(.iconOnly)
    }
}

#Preview {
    BottomButtons()
}
