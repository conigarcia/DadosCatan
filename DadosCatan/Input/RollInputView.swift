//
//  AddRollView.swift
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
    
    let game: Game

    @State var dice = DiceRoll(red_value: 1, yel_value: 1, act_value: 1)
    
    var body: some View {
        VStack {
            DiceRollView(dice: $dice)
                .padding()
                .padding(.bottom, 25)
                .padding(.top, 25)
            
            Button {
                game.rolls.append(dice)
                dice.reset()
            } label: {
                Text("CARGAR")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .frame(width: 250, height: 50, alignment: .center)
                    .background(Color.background)
                    .clipShape(.rect(cornerRadius: 15))
                    .shadow(radius: 2, x: 2, y: 2)
            }
            .padding(.bottom, 8)
            
            Button {
                dice.alchemist = true
                game.rolls.append(dice)
                dice.reset()
            } label: {
                Text("ALQUIMISTA")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width: 250, height: 50, alignment: .center)
                    .background(Color.alchemist)
                    .clipShape(.rect(cornerRadius: 15))
                    .shadow(radius: 2, x: 2, y: 2)
            }
            .padding(.top, 8)
            
            Spacer()
            
            Button {
                alert = true
            } label: {
                Text("TERMINAR PARTIDA")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .frame(width: 300, height: 60, alignment: .center)
                    .background(Color.background)
                    .clipShape(.rect(cornerRadius: 15))
                    .shadow(radius: 2, x: 2, y: 2)
            }
            .padding(.bottom, 25)
            .disabled(game.rolls.isEmpty)
            .alert("Seguro querés terminar la partida?", isPresented: $alert) {
                Button("Si") {
                    game.new_game = false
                    dismiss()
                }
                Button("No") {}
            }
        }
        .navigationTitle("Turno de \(game.players[(game.rolls.count)%game.players.count])")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    game.rolls.removeLast()
                } label: {
                    Text("Deshacer")
                }
                .disabled(game.rolls.isEmpty)
                
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    stats = true
                } label: {
                    Text("Estadísticas")
                        .fontWeight(.bold)
                }
                .disabled(game.rolls.isEmpty)                
            }
        }
        .navigationDestination(isPresented: $stats) {
            GameDetailView(game: game)
                .navigationTitle("Estadísticas")
        }
    }
}
