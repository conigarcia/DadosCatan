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
    
    @State var name_input = ""
    @State var players_input = ["", "", "", "", "", ""]
    @State var colors_input = ["orange player", "red player", "brown player", "white player", "blue player", "green player"]
    
    let colors_options = ["orange player", "red player", "brown player", "white player", "blue player", "green player"]
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField(text: $name_input, prompt: Text("nombre de partida")) {}
                        .autocorrectionDisabled()
                }
                
                Section("ingresar los jugadores en orden de juego") {
                    ForEach(1 ... 6, id: \.self) { num in
                        HStack {
                            TextField(text: $players_input[num-1], prompt: Text("jugador \(num)")) {}
                                .autocorrectionDisabled()
//                                .textFieldStyle(DCTextFieldStyle())
                            
                            Menu {
                                Picker("", selection: $colors_input[num-1]) {
                                    ForEach(colors_options, id: \.self) { color in
                                        Image(systemName: "square.fill")
                                            .tint(Color(color))
                                    }
                                }
                                .pickerStyle(.palette)
                            } label: {
                                Image(systemName: "square.fill")
                                    .tint(Color(colors_input[num-1]))
                            }
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, maxHeight: 450)

            Button {
                var players = [String]()
                var colors = [String]()
                for idx in 0...5 {
                    if players_input[idx] != "" {
                        players.append(players_input[idx])
                        colors.append(colors_input[idx])
                    }
                }
                let game = Game(name: name_input, players: players, colors: colors, rolls: [])
                modelContext.insert(game)
                dismiss()
            } label: {
                Text("COMENZAR")
                    .frame(width: 130, height: 25)
            }
            .buttonStyle(DCButtonStyle())
            .disabled(name_input == "" || players_input.allSatisfy({ ply in ply == "" }))
            
            Spacer()
        }
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
