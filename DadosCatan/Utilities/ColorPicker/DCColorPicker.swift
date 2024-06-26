//
//  DCColorPicker.swift
//  TorneosCatan
//
//  Created by coni garcia on 18/05/2024.
//

import SwiftUI

struct DCColorPicker: View {
    @Binding var color: PlayerColor
    
    var body: some View {
        Menu {
            Picker("", selection: $color) {
                ForEach(PlayerColor.allCases) { col in
                    Image(systemName: "square.fill")
                        .tint(col.color)
                }
            }
            .pickerStyle(.palette)
            .menuActionDismissBehavior(.enabled)
        } label: {
            Image(systemName: "square.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundStyle(color.color)
        }
    }
}

#Preview {
    DCColorPicker(color: .constant(.red))
}
