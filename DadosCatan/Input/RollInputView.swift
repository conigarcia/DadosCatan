//
//  RollInputView.swift
//  DadosCatan
//
//  Created by coni garcia on 14/03/2024.
//

import SwiftUI
import SwiftData

struct RollInputView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var alert = false
    @State var stats = false
    @State var attack = false
    
    let game: Game

    @State var dice = DiceRoll(red_value: 1, yel_value: 1, act_value: 1)
    @State var boat_rolls = 0
    
    var body: some View {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea()
            
            VStack {
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
                
                DiceRollView(dice: $dice)
                    .padding(.vertical, 25)
                
                HStack {
                    Button {
                        game.rolls.append(dice)
                        if dice.act_value == 1 {
                            boat_rolls += 1
                            if boat_rolls == 7 {
                                attack = true
                                boat_rolls = 0
                            }
                        }
                        dice.reset()
                    } label: {
                        Text("cargar")
                            .frame(width: 120, height: 25)
                    }
                    .buttonStyle(DCButtonStyle())
                    .padding(.trailing, 20)
                    
                    Button {
                        dice.alchemist = true
                        game.rolls.append(dice)
                        if dice.act_value == 1 {
                            boat_rolls += 1
                            if boat_rolls == 7 {
                                attack = true
                                boat_rolls = 0
                            }
                        }
                        dice.reset()
                    } label: {
                        Text("ALQUIMISTA")
                            .frame(width: 120, height: 25)
                    }
                    .buttonStyle(DCButtonStyle())
                }
                
                //            Spacer()
                
                Button {
                    alert = true
                } label: {
                    Text("TERMINAR PARTIDA")
                        .frame(width: 300, height: 25, alignment: .center)
                }
                .buttonStyle(DCButtonStyle())
                .padding(.vertical, 25)
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
                    let deleted_roll = game.rolls.removeLast()
                    if deleted_roll.act_value == 1 {
                        if boat_rolls > 0 {
                            boat_rolls -= 1
                        } else {
                            boat_rolls = 6
                        }
                    }
                } label: {
                    Image(systemName: "arrow.uturn.backward.circle.fill")
                }
                .disabled(game.rolls.isEmpty)
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
}
