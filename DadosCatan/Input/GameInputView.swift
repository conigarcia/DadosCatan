//
//  GameInputView.swift
//  DadosCatan
//
//  Created by coni garcia on 14/03/2024.
//

import SwiftUI
import SwiftData

struct GameInputView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @State var players_input = ["", "", "", "", "", ""]
    @State var colors_input: [PlayerColor] = [.orange, .red, .green, .white, .blue, .brown]
    
    var body: some View {
        ScrollView {
            TextField(text: $name, prompt: Text("Nombre de la partida")) {}
                .autocorrectionDisabled()
                .textFieldStyle(DCTextFieldStyle())
                .padding(.vertical)
            
            Text("ingrese los jugadores en orden de juego")
                .font(.body.smallCaps())
                .foregroundStyle(Color(.secondaryLabel))
            
            ForEach(1 ... 6, id: \.self) { num in
                HStack {
                    TextField(text: $players_input[num-1], prompt: Text("Jugador \(num)")) {}
                        .autocorrectionDisabled()
                        .textFieldStyle(DCTextFieldStyle())
                    
                    DCColorPicker(color: $colors_input[num-1])
                    
                }
            }
            
            Button {
                var players = [String]()
                var colors = [PlayerColor]()
                for idx in 0...5 {
                    if players_input[idx] != "" {
                        players.append(players_input[idx])
                        colors.append(colors_input[idx])
                    }
                }
                let game = Game(name: name, players: players, colors: colors, rolls: [])
                modelContext.insert(game)
                dismiss()
            } label: {
                Text("comenzar")
                    .frame(width: 130, height: 25)
            }
            .buttonStyle(DCButtonStyle())
            .disabled(name == "" || players_input.allSatisfy({ ply in ply == "" }))
            .padding(.top, 25)
            
            Spacer()
        }
        .padding()
        .background(.appBackground)
        .navigationTitle("Nueva partida")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancelar") {
                    dismiss()
                }
            }
        }
    }
}
