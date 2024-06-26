//
//  GameTable.swift
//  DadosCatan
//
//  Created by coni garcia on 17/03/2024.
//

import SwiftUI

struct GameTable: View {
    let game: Game
    var attack_rolls: [Int] {game.attack_rolls()}
    
    var body: some View {
        List {
            ForEach(Array(game.rolls.enumerated()), id: \.offset) { (idx, roll) in
                let player = game.players[idx%(game.players.count)]
                let is_attack_roll = attack_rolls.contains(idx)
                GameTableRow(roll: roll, idx: idx, player: player, is_attack_roll: is_attack_roll)
                    .listRowBackground(roll.alchemist ? Color.alchemist.opacity(0.2) : (is_attack_roll ? Color.redDice.opacity(0.2) : Color(.appSecondaryBackground)))
            }
        }
        .scrollContentBackground(.hidden)
        .background(.appBackground)
    }
}

struct GameTableRow: View {
    let roll: DiceRoll
    let idx: Int
    let player: String
    let is_attack_roll: Bool
    
    var body: some View {
        HStack {
            Text(idx+1, format: .number)
                .foregroundStyle(Color(.secondaryLabel))
                .padding(.leading, 10)
            
            Text(player)
                .padding(.leading, 15)
                .padding(.trailing, 20)
            
            Spacer()
            
            Image("n\(roll.num_value)")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.trailing, 10)
            
            Image("y\(roll.yel_value)")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.trailing, 10)
            
            Image("r\(roll.red_value)")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.trailing, 10)
            
            Group {
                Image("a\(roll.act_value)")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .frame(width: 25, height: 25)
            .background(is_attack_roll ? Color.red : Color.clear)
            .cornerRadius(6)
            .padding(.trailing, 10)
        }
    }
}
