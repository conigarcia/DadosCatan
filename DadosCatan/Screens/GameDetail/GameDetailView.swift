//
//  GameDetailView.swift
//  DadosCatan
//
//  Created by coni garcia on 17/03/2024.
//

import SwiftUI

struct GameDetailView: View {
    let game: Game
    
    var body: some View {
        List {
            Section("Generales") {
                NavigationLink {
                    GameTable(game: game)
                        .navigationTitle("Tabla")
                } label: {
                    HStack {
                        Image(systemName: "tablecells")
                        Text("Tabla")
                    }
                }
                .listRowBackground(Color(.appSecondaryBackground))

                NavigationLink {
                    GameFacts(game: game)
                        .navigationTitle("Gráficos y Datos")
//                        .toolbar {
//                            ToolbarItem(placement: .topBarTrailing) {
//                                ShareLink(item: chartPDF(game: game, path: "gráficos \(game.date.formatted(.dateTime.day().month().year())).pdf"))
//                            }
//                        }
                } label: {
                    HStack {
                        Image(systemName: "chart.bar.xaxis")
                        Text("Gráficos y Datos")
                    }
                }
                .listRowBackground(Color(.appSecondaryBackground))
            }

            if game.rolls.count >= game.players.count {
                Section("Por jugador") {
                    ForEach(Array(game.players.enumerated()), id: \.offset) { (idx, player) in
                        NavigationLink {
                            PlayerFacts(game: game, player: player)
                                .navigationTitle("Estadísticas de \(player)")
                        } label: {
                            HStack {
                                Image(systemName: "person.fill")
                                Text(player)
                            }
                            .foregroundStyle(game.colors[idx].color)
                        }
                        .listRowBackground(Color(.appSecondaryBackground))
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(.appBackground)
    }
}
