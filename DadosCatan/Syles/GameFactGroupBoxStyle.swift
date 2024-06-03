//
//  GameFactGroupBoxStyle.swift
//  DadosCatan
//
//  Created by coni garcia on 02/05/2024.
//

import SwiftUI

struct GameFactGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.label
                .bold()
            
            configuration.content
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(.rect(cornerRadius: 8))
    }
}

extension GroupBoxStyle where Self == GameFactGroupBoxStyle {
    static var gameFact: GameFactGroupBoxStyle { .init() }
}
