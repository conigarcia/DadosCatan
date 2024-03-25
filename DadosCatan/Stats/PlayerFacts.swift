//
//  PlayerFacts.swift
//  DadosCatan
//
//  Created by coni garcia on 17/03/2024.
//

import SwiftUI
import Charts

struct PlayerFacts: View {
    let game: Game
    let player: String

    var body: some View {
        List {
            Section("") {
                let attack_rolls = game.player_attack_rolls(player: player)
                if attack_rolls == 0 {
                    Text("Nunca hizo llegar a los bárbaros")
                        .fontWeight(.medium)
                } else {
                    Text("Hizo llegar a los bárbaros \(attack_rolls) \(attack_rolls == 1 ? "vez" : "veces")")
                        .fontWeight(.medium)
                }
                
                let alchemist_rolls = game.player_alchemist_rolls(player: player)
                if alchemist_rolls == 0 {
                    Text("Nunca usó el alquimista")
                        .fontWeight(.medium)
                } else {
                    Text("Usó el alquimista \(alchemist_rolls) \(alchemist_rolls == 1 ? "vez" : "veces")")
                        .fontWeight(.medium)
                }
            }
            
            Section {
                let values = game.player_values(player: player)
                NumChart(values: values)
                    .padding(.vertical)
            }
            
            Section {
                let values = game.player_act_values(player: player)
                ActChart(values: values)
            }
        }
    }
}
