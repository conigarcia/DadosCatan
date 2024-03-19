//
//  GameFacts.swift
//  DadosCatan
//
//  Created by coni garcia on 17/03/2024.
//

import SwiftUI

struct Fact: View {
    var image: String
    var main_text: String
    var sec_text: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 35, height: 35)
                .padding(.trailing, 10)
            VStack(alignment: .leading) {
                Text(main_text)
                    .fontWeight(.medium)
                
                if sec_text != "" {
                    Text(sec_text)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding(.vertical, 5)
    }
}

struct GameFacts: View {
    let game: Game
    
    var most_seven: (String, Int) {game.most_seven_player()}
    var least_seven: (String, Int) {game.least_seven_player()}
    
    var most_boat: (String, Int) {game.most_boat_player()}
    var least_boat: (String, Int) {game.least_boat_player()}
    
    var attack_rolls: Int {game.attack_rolls().count}
    
    var body: some View {
        List {
            Section("") {
                /* TODO: empates */
                Fact(image: "n7", main_text: "\(most_seven.0) es el jugador que más sietes sacó", sec_text: "(\(most_seven.1) \(most_seven.1 == 1 ? "vez" : "veces"))")
                Fact(image: "n7", main_text: "\(least_seven.0) es el jugador que menos sietes sacó", sec_text: "(\(least_seven.1) \(least_seven.1 == 1 ? "vez" : "veces"))")
            }
            
            Section {
                /* TODO: empates */
                Fact(image: "a1", main_text: "\(most_boat.0) es el jugador que más barcos sacó", sec_text: "(\(most_boat.1) \(most_boat.1 == 1 ? "vez" : "veces"))")
                Fact(image: "a1", main_text: "\(least_boat.0) es el jugador que menos barcos sacó", sec_text: "(\(least_boat.1) \(least_boat.1 == 1 ? "vez" : "veces"))")
            }
            
            Section {
                Fact(image: "a1", main_text: "Los bárbaros llegaron \(attack_rolls) \(attack_rolls == 1 ? "vez" : "veces")", sec_text: "")
            }
        }
    }
}
