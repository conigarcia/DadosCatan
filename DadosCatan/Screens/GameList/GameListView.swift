//
//  GameListView.swift
//  DadosCatan
//
//  Created by coni garcia on 14/03/2024.
//

import SwiftUI
import SwiftData

struct GameListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Game.date, order: .reverse) private var games: [Game]
    
    @State var add_new_game = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(games) { game in
                    NavigationLink {
                        if game.new_game {
                            ActiveGameView(game: game)
                        } else {
                            GameDetailView(game: game)
                                .navigationTitle("Estadísticas")
                        }
                    } label: {
                        HStack {
                            Text(game.name)
                            Spacer()
                            if game.new_game {
                                Text("EN CURSO")
                                    .font(.system(.body).smallCaps())
                                    .foregroundColor(Color(.accent))
                            } else {
                                Text(game.date.formatted(.dateTime.day().month().year()))
                                    .foregroundStyle(Color(.secondaryLabel))
                            }
                        }
                    }
                    .listRowBackground(Color(.appSecondaryBackground))
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let game = games[index]
                        modelContext.delete(game)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(.appBackground)
            .navigationTitle("Partidas")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        add_new_game = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $add_new_game) {
                NavigationStack {
                    NewGameView()
                }
            }
        }
    }
}

#Preview {
    GameListView()
        .modelContainer(for: Game.self, inMemory: true)
}
