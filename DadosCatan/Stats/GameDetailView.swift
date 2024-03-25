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
                    .font(.headline)
                }

                NavigationLink {
                    GameFacts(game: game)
                        .navigationTitle("Gráficos y Datos")
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                ShareLink(item: chartPDF(game: game, path: "gráficos \(game.date.formatted(.dateTime.day().month().year())).pdf"))
                            }
                        }
                } label: {
                    HStack {
                        Image(systemName: "chart.bar.xaxis")
                        Text("Gráficos y Datos")
                    }
                    .font(.headline)
                }
            }

            if game.rolls.count >= game.players.count {
                Section("Por jugador") {
                    ForEach(game.players, id: \.self) { player in
                        NavigationLink {
                            PlayerFacts(game: game, player: player)
                                .navigationTitle("Estadísticas de \(player)")
                        } label: {
                            HStack {
                                Image(systemName: "person.fill")
                                Text(player)
                            }
                        }
                    }
                }
            }
        }
    }
}
