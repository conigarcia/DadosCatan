//
//  GameFacts.swift
//  DadosCatan
//
//  Created by coni garcia on 17/03/2024.
//

import SwiftUI

struct Fact: View {
    var image: String
    var text: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 35, height: 35)
                .padding(.trailing, 10)
            Text(text)
                .fontWeight(.medium)
        }
        .padding(.vertical, 5)
    }
}

struct GameFacts: View {
    let game: Game
    
    var most_seven: String {game.most_seven_player()}
    var least_seven: String {game.least_seven_player()}
    
    var most_boat: String {game.most_boat_player()}
    var least_boat: String {game.least_boat_player()}
    
    var body: some View {
        List {
            Section("siete") {
                /* TODO: empates */
                Fact(image: "n7", text: "\(most_seven) es el jugador que más sietes sacó")
                Fact(image: "n7", text: "\(least_seven) es el jugador que menos sietes sacó")
            }
            
            Section("barco") {
                /* TODO: empates */
                Fact(image: "a1", text: "\(most_boat) es el jugador que más barcos sacó")
                Fact(image: "a1", text: "\(least_boat) es el jugador que menos barcos sacó")
            }
        }
    }
}
