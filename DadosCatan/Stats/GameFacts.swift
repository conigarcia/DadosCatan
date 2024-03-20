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
            if game.new_game {
                Section {
                    ForEach(5 ... 9, id: \.self) { num in
                        let streak = game.no_num_streak(num: num)
                        if streak >= 12 {
                            Fact(image: "n\(num)", main_text: "El \(num) no sale hace \(streak) turnos", sec_text: "")
                        }
                    }
                }
            }
            
            Section {
                Fact(image: "a1", main_text: "Los bárbaros llegaron \(attack_rolls) \(attack_rolls == 1 ? "vez" : "veces")", sec_text: "")
            }
            
            Section {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(1...4, id: \.self) { act in
                            let values: [(String, Int)] = game.players.map { ply in (ply, game.player_act_values(player: ply)[act-1]) }
                            let roll_count = values.reduce(0, { res, x in res + x.1 })
                            let colors: [Color] = game.colors.map { color in Color(color) }
                            
                            if roll_count == 0 {
                                VStack(alignment: .center) {
                                    HStack {
                                        Text("No salió")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Image("a\(act)")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                    }
                                    Text("en toda la partida")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                }
                                .frame(width: 280)
                                .padding(.horizontal)
                            } else {
                                VStack {
                                    HStack {
                                        Text("Tiradas de")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Image("a\(act)")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                        Text("por jugador")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                    }
                                    .padding(.top)
                                    
                                    PlayerChart(values: values, roll_count: roll_count, colors: colors)
                                        .frame(width: 280, height: 400)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .defaultScrollAnchor(.leading)
                .scrollTargetBehavior(.viewAligned)
                .contentMargins(.bottom, 20, for: .scrollContent)
            }
            
            Section {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(2...12, id: \.self) { num in
                            let values: [(String, Int)] = game.players.map { ply in (ply, game.player_values(player: ply)[num-2]) }
                            let roll_count = values.reduce(0, { res, x in res + x.1 })
                            let colors: [Color] = game.colors.map { color in Color(color) }

                            if roll_count == 0 {
                                VStack(alignment: .center) {
                                    HStack {
                                        Text("No salió el")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Image("n\(num)")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                    }
                                    Text("en toda la partida")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                }
                                .frame(width: 280)
                                .padding(.horizontal)
                            } else {
                                VStack{
                                    HStack {
                                        Text("Tiradas de")
                                            .fontWeight(.bold)
                                            .font(.headline)
                                        Image("n\(num)")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                        Text("por jugador")
                                            .fontWeight(.bold)
                                            .font(.headline)
                                    }
                                    .padding(.top)
                                    
                                    PlayerChart(values: values, roll_count: roll_count, colors: colors)
                                        .frame(width: 280, height: 400)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .defaultScrollAnchor(.center)
                .scrollTargetBehavior(.viewAligned)
                .contentMargins(.bottom, 20, for: .scrollContent)
            }
            
            Section {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(2...4, id: \.self) { act in
                            let values: [Int] = game.act_red_values(act: act)
                            let roll_count = values.reduce(0, +)
                            
                            if roll_count == 0 {
                                VStack(alignment: .center) {
                                    HStack {
                                        Text("No salió")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Image("a\(act)")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                    }
                                    Text("en toda la partida")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                }
                                .frame(width: 280)
                                .padding(.horizontal)
                            } else {
                                VStack {
                                    HStack {
                                        Text("Dado rojo en tiradas de")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Image("a\(act)")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                    }
                                    .padding(.top)
                                    
                                    ColorChart(color: "r", values: values, roll_count: roll_count)
                                        .frame(width: 280, height: 400)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .defaultScrollAnchor(.leading)
                .scrollTargetBehavior(.viewAligned)
                .contentMargins(.bottom, 20, for: .scrollContent)
            }
        }
    }
}
