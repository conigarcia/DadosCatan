//
//  DCButtonStyle.swift
//  TorneosCatan
//
//  Created by coni garcia on 22/05/2024.
//

import SwiftUI

struct DCButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3.smallCaps())
            .fontWeight(.semibold)
            .foregroundStyle(Color(.white))
            .padding()
            .background(Color(.accent))
            .clipShape(.rect(cornerRadius: 15))
    }
}

#Preview {
    Button {
        
    } label: {
        Text("Button")
    }
    .buttonStyle(DCButtonStyle())
}
