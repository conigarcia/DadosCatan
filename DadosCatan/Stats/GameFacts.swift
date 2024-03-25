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
                let attack_rolls = game.attack_rolls().count
                Fact(image: "a1", main_text: "Los bárbaros llegaron \(attack_rolls) \(attack_rolls == 1 ? "vez" : "veces")", sec_text: "")
            }

            Section {
                ScrollView(.horizontal) {
                    HStack {
                        let values = game.num_values()
                        NumChart(values: values)
                            .frame(width: 280, height: 400)
                            .padding(.horizontal)

                        ForEach(["r", "y"], id: \.self) { col in
                            let values: [Int] = (col == "r" ? game.red_values() : game.yel_values())
                            
                            VStack {
                                HStack {
                                    Text("Dado \(col == "r" ? "rojo" : "amarillo")")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                }
                                .padding(.top)
                                
                                ColorChart(color: col, values: values)
                                    .frame(width: 280, height: 400)
                                    .padding(.horizontal)
                            }
                        }
                        
                        let act_values = game.act_values()
                        VStack {
                            HStack {
                                Text("Dado acontecimientos")
                                    .font(.headline)
                                    .fontWeight(.bold)
                            }
                            .padding(.top)
                            
                            ActChart(values: act_values)
                                .frame(width: 280, height: 400)
                                .padding(.horizontal)
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
                            let colors: [Color] = game.colors.map { color in Color(color) }

                            if values.reduce(0, { res, x in res + x.1 }) == 0 {
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
                                    
                                    PlayerChart(values: values, colors: colors)
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
                        ForEach(1...4, id: \.self) { act in
                            let values: [(String, Int)] = game.players.map { ply in (ply, game.player_act_values(player: ply)[act-1]) }
                            let colors: [Color] = game.colors.map { color in Color(color) }
                            
                            if values.reduce(0, { res, x in res + x.1 }) == 0 {
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
                                    
                                    PlayerChart(values: values, colors: colors)
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
                        ForEach(2...4, id: \.self) { act in
                            let values: [Int] = game.act_red_values(act: act)
                            
                            if values.reduce(0, +) == 0 {
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
                                    
                                    ColorChart(color: "r", values: values)
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
