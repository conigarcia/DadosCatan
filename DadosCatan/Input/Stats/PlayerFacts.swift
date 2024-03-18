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
    
    var attack_rolls: Int {game.player_attack_rolls(player: player)}
    var alchemist_rolls: Int {game.player_alchemist_rolls(player: player)}
    
    var values: [Int] {game.player_values(player: player)}
    var act_values: [Int] {game.player_act_values(player: player)}

    var body: some View {
        List {
            Section("") {
                HStack {
//                    Image("a1")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .padding(.trailing, 5)
                    if attack_rolls == 0 {
                        Text("Nunca hizo llegar a los bárbaros")
                            .fontWeight(.medium)
                    } else {
                        Text("Hizo llegar a los bárbaros \(attack_rolls) \(attack_rolls == 1 ? "vez" : "veces")")
                            .fontWeight(.medium)
                    }
                }

                Text("Usó el alquimista \(alchemist_rolls) \(alchemist_rolls == 1 ? "vez" : "veces")")
                    .fontWeight(.medium)
            }
            Section {
                NumChart(values: values)
                    .padding(.vertical)
            }
            Section {
                ActChart(values: act_values, roll_count: act_values.reduce(0, +))
            }
        }
    }
}
