//
//  AddGameView.swift
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
    
    var body: some View {
        Form {
            Section {
                TextField(text: $name_input, prompt: Text("nombre de partida")) {}
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
            }
            
            Section("ingresar los jugadores en orden de juego") {
                ForEach(1 ... 6, id: \.self) { num in
                    TextField(text: $players_input[num-1], prompt: Text("jugador \(num)")) {}
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                }
            }
            
            Button {
                var players = [String]()
                for ply in players_input {
                    if ply != "" { players.append(ply)}
                }
                let game = Game(name: name_input, players: players, rolls: [])
                modelContext.insert(game)
                dismiss()
            } label: {
                Text("COMENZAR")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 10)
            }
            .disabled(name_input == "" || players_input.allSatisfy({ ply in ply == "" }))
        }
        .navigationTitle("Nueva partida")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancelar") {
                    dismiss()
                }
            }
        }
    }
}
