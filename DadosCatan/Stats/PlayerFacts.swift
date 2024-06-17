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
        ScrollView {
            PlayerAttackRollsCard(game: game, player: player)
            
            PlayerAlchemistRollsCard(game: game, player: player)
            
            PlayerNumbersChart(game: game, player: player)
            
            PlayerActionsChart(game: game, player: player)
        }
        .background(Color(.systemGroupedBackground))
        .padding(.bottom)
    }
}

struct PlayerAttackRollsCard: View {
    let game: Game
    let player: String
    
    var body: some View {
        let attack_rolls = game.player_attack_rolls(player: player)
        
        if attack_rolls == 0 {
            GroupBox {
                HStack {
                    Text("Nunca hizo llegar a los bárbaros")
                        .bold()
                    Spacer()
                }
            }
            .groupBoxStyle(.gameFact)
            .padding(.horizontal, 25)
            .padding(.top)
        } else {
            GroupBox {
                HStack {
                    Text("Hizo llegar a los bárbaros \(attack_rolls) \(attack_rolls == 1 ? "vez" : "veces")")
                        .bold()
                    Spacer()
                }
            }
            .groupBoxStyle(.gameFact)
            .padding(.horizontal, 25)
            .padding(.top)
        }
    }
}

struct PlayerAlchemistRollsCard: View {
    let game: Game
    let player: String
    
    var body: some View {
        let alchemist_rolls = game.player_alchemist_rolls(player: player)
        
        if alchemist_rolls == 0 {
            GroupBox {
                HStack {
                    Text("Nunca usó el alquimista")
                        .bold()
                    Spacer()
                }
            }
            .groupBoxStyle(.gameFact)
            .padding(.horizontal, 25)
        } else {
            GroupBox {
                HStack {
                    Text("Usó el alquimista \(alchemist_rolls) \(alchemist_rolls == 1 ? "vez" : "veces")")
                        .bold()
                    Spacer()
                }
            }
            .groupBoxStyle(.gameFact)
            .padding(.horizontal, 25)
        }
    }
}

struct PlayerNumbersChart: View {
    let game: Game
    let player: String
    
    var body: some View {
        let values = game.player_values(player: player)
        
        GroupBox {
            NumChart(values: values)
        }
        .groupBoxStyle(.gameFact)
        .padding(.horizontal, 25)
        .padding(.top, 20)
    }
}

struct PlayerActionsChart: View {
    let game: Game
    let player: String
    
    var body: some View {
        let act_values = game.player_act_values(player: player)
        
        GroupBox {
            ActChart(values: act_values)
        }
        .groupBoxStyle(.gameFact)
        .padding(.horizontal, 25)
        .padding(.top, 20)
    }
}
