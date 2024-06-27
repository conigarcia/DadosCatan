//
//  ActiveGameView.swift
//  DadosCatan
//
//  Created by coni garcia on 14/03/2024.
//

import SwiftUI
import SwiftData

struct ActiveGameView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var alert = false
    @State var stats = false
    @State var attack = false
    
    let game: Game

    @State var dice = DiceRoll(red_value: 1, yel_value: 1, act_value: 1)
    
    @State var attack_board_shown = false
    
    var body: some View {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                RollView(dice: $dice)
                    .padding(.vertical, 25)
                
                Spacer()

                HStack {
                    Button {
                        withAnimation(Animation.bouncy) {
                            dice.alchemist = true
                            load_roll(dice: dice)
                            dice.reset()
                        }
                    } label: {
                        Text("alquimista")
                            .frame(width: 120, height: 25)
                    }
                    .buttonStyle(DCButtonStyle())
                    .padding(.trailing, 20)

                    Button {
                        withAnimation(Animation.bouncy) {
                            load_roll(dice: dice)
                            dice.reset()
                        }
                    } label: {
                        Text("cargar")
                            .frame(width: 120, height: 25)
                    }
                    .buttonStyle(DCButtonStyle())
                }
                .padding(.bottom, 100)
            }
            
            VStack {
                Spacer()
                AttackCounterView(is_shown: $attack_board_shown, boat_position: game.boat_position)
            }
        }
        .onChange(of: attack_board_shown) { oldVal, newVal in
            if game.boat_position == 7 && newVal == false {
                game.boat_position = 0
            }
        }
        .navigationTitle("Turno de \(game.players[(game.rolls.count)%game.players.count])")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    stats = true
                } label: {
                    Image(systemName: "chart.bar.xaxis")
                }
                .disabled(game.rolls.isEmpty)
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    unload_roll()
                } label: {
                    Image(systemName: "arrow.uturn.backward.circle.fill")
                }
                .disabled(game.rolls.isEmpty)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    alert = true
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
                .disabled(game.rolls.isEmpty)
                .alert("Seguro querés terminar la partida?", isPresented: $alert) {
                    Button("Si") {
                        game.new_game = false
                        dismiss()
                    }
                    Button("No") {}
                }
            }

        }
        .navigationDestination(isPresented: $stats) {
            GameDetailView(game: game)
                .navigationTitle("Estadísticas")
        }
        .popover(isPresented: $attack) {
            VStack {
                Text("LLEGARON LOS BÁRBAROS")
                    .font(.system(size: 25, weight: .heavy))
                    .multilineTextAlignment(.center)
                    .presentationDetents([.height(330)])
                    .padding(.top, 50)
                
                Spacer()
                
                Image("a1")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 50)
            }
        }
    }
    
    func load_roll(dice: DiceRoll) {
        /* add roll */
        game.rolls.append(dice)

        /* update boat position */
        if dice.act_value == 1 {
            game.boat_position += 1
            if game.boat_position == 7 {
                game.stats!.attack_rolls.append(game.rolls.count)
                attack_board_shown = true
            }
        }
        
        /* update stats */
        if !dice.alchemist {
            game.stats!.num_values[dice.num_value-2] += 1
            game.stats!.red_values[dice.red_value-1] += 1
            game.stats!.yel_values[dice.yel_value-1] += 1
        }
        game.stats!.act_values[dice.act_value-1] += 1
        for num in 2...12 {
            if num == dice.num_value {
                game.stats!.no_num_streak[num-2] = 0
            } else {
                game.stats!.no_num_streak[num-2] += 1
            }
        }
        if dice.act_value == 2 {
            game.stats!.yellow_red_values[dice.red_value-1] += 1
        }
        if dice.act_value == 3 {
            game.stats!.green_red_values[dice.red_value-1] += 1
        }
        if dice.act_value == 4 {
            game.stats!.blue_red_values[dice.red_value-1] += 1
        }
    }
    
    func unload_roll() {
        /* remove roll */
        let deleted_roll = game.rolls.removeLast()
        
        /* update boat position */
        if deleted_roll.act_value == 1 {
            if game.boat_position > 0 {
                game.boat_position -= 1
            } else {
                game.stats!.attack_rolls.removeLast()
                game.boat_position = 6
            }
        }
        
        /* update stats */
        if !deleted_roll.alchemist {
            game.stats!.num_values[deleted_roll.num_value-2] -= 1
            game.stats!.red_values[deleted_roll.red_value-1] -= 1
            game.stats!.yel_values[deleted_roll.yel_value-1] -= 1
        }
        game.stats!.act_values[deleted_roll.act_value-1] -= 1
        game.stats!.calculate_no_num_streak()
        if deleted_roll.act_value == 2 {
            game.stats!.yellow_red_values[deleted_roll.red_value-1] -= 1
        }
        if deleted_roll.act_value == 3 {
            game.stats!.green_red_values[deleted_roll.red_value-1] -= 1
        }
        if deleted_roll.act_value == 4 {
            game.stats!.blue_red_values[deleted_roll.red_value-1] -= 1
        }
    }
}
