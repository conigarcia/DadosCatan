//
//  AttackCountView.swift
//  DadosCatan
//
//  Created by coni garcia on 24/06/2024.
//

import SwiftUI

struct AttackCountView: View {
    @Binding var boat_rolls: Int

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 300, height: 10)
                .foregroundStyle(.blue)
                .clipShape(.capsule)
            
            HStack {
                Spacer()
                ForEach(0...7, id: \.self) { pos in
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(pos == boat_rolls ? .red : Color(.label))
                    Spacer()
                    
                }
            }
            .frame(width: 300)
        }
    }
}

#Preview {
    AttackCountView(boat_rolls: .constant(1))
}
