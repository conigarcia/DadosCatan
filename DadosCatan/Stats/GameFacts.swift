//
//  GameFacts.swift
//  DadosCatan
//
//  Created by coni garcia on 17/03/2024.
//

import SwiftUI

struct GameFacts: View {
    let game: Game

    var body: some View {
        ScrollView {

            AttackRollsCard(game: game)

            if game.new_game {
                NoNumbersCards(game: game)
            }

            DiceChartsHScroll(game: game)

            PlayersNumbersHScroll(game: game)

            PlayersActionsHScroll(game: game)

            RedDiceActionsHScroll(game: game)
        }
        .background(Color(uiColor: .secondarySystemBackground))
    }
}

struct AttackRollsCard: View {
    let game: Game
    
    var body: some View {
        let attack_rolls = game.attack_rolls().count
        
        GroupBox {
            Fact(
                image: "a1",
                main_text: "Los bárbaros llegaron \(attack_rolls) \(attack_rolls == 1 ? "vez" : "veces")",
                sec_text: ""
            )
        }
        .groupBoxStyle(.gameFact)
        .padding(.horizontal, 25)
        .padding(.top)
    }
}

struct NoNumbersCards: View {
    let game: Game
    
    var body: some View {
        ForEach(5 ... 9, id: \.self) { num in
            let streak = game.no_num_streak(num: num)
            if streak >= 12 {
                GroupBox {
                    Fact(
                        image: "n\(num)",
                        main_text: "El \(num) no sale hace \(streak) turnos",
                        sec_text: ""
                    )
                }
                .groupBoxStyle(.gameFact)
                .padding(.horizontal, 25)
            }
        }
    }
}

struct Fact: View {
    let image: String
    let main_text: String
    let sec_text: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 35, height: 35)
            
            VStack(alignment: .leading) {
                Text(main_text)
                    .bold()
                
                if sec_text != "" {
                    Text(sec_text)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            
            Spacer()
        }
        .padding(.leading, 5)
    }
}

struct DiceChartsHScroll: View {
    let game: Game
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                GroupBox {
                    let values = game.num_values()
                    NumChart(values: values)
                        .frame(width: 310, height: 430)
                }
                .groupBoxStyle(.gameFact)
                
                GroupBox {
                    let red_values = game.red_values()
                    ColorChart(color: "r", values: red_values)
                        .frame(width: 310)
                } label: {
                    Text("Dado rojo")
                }
                .groupBoxStyle(.gameFact)

                GroupBox {
                    let yel_values = game.yel_values()
                    ColorChart(color: "y", values: yel_values)
                        .frame(width: 310)
                } label: {
                    Text("Dado amarillo")
                }
                .groupBoxStyle(.gameFact)
                
                GroupBox {
                    let act_values = game.act_values()
                    ActChart(values: act_values)
                        .frame(width: 310)
                } label: {
                    Text("Dado acontecimientos")
                }
                .groupBoxStyle(.gameFact)
            }
            .scrollTargetLayout()
            .padding(.horizontal, 25)
            .padding(.top, 20)
        }
        .defaultScrollAnchor(.leading)
        .scrollTargetBehavior(.viewAligned)
        .contentMargins(.bottom, 20, for: .scrollContent)
    }
}

struct PlayersNumbersHScroll: View {
    let game: Game
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(2...12, id: \.self) { num in
                    let values: [(String, Int)] = game.players.map { ply in (ply, game.player_values(player: ply)[num-2]) }
                    let colors: [Color] = game.colors.map { color in Color(color) }
                    
                    if values.reduce(0, { res, x in res + x.1 }) == 0 {
                        GroupBox {
                            MissingDiceCard(dice: "n\(num)")
                                .frame(width: 310, height: 445)
                        }
                        .groupBoxStyle(.gameFact)
                    } else {
                        GroupBox {
                            PlayerChart(values: values, colors: colors)
                                .frame(width: 310)
                        } label: {
                            HStack {
                                Text("Tiradas de")
                                Image("n\(num)")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                Text("por jugador")
                            }
                        }
                        .groupBoxStyle(.gameFact)
                    }
                }
            }
            .scrollTargetLayout()
            .padding(.horizontal, 25)
        }
        .defaultScrollAnchor(.center)
        .scrollTargetBehavior(.viewAligned)
        .contentMargins(.bottom, 20, for: .scrollContent)
    }
}

struct PlayersActionsHScroll: View {
    let game: Game
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(1...4, id: \.self) { act in
                    let values: [(String, Int)] = game.players.map { ply in (ply, game.player_act_values(player: ply)[act-1]) }
                    let colors: [Color] = game.colors.map { color in Color(color) }
                    
                    if values.reduce(0, { res, x in res + x.1 }) == 0 {
                        GroupBox {
                            MissingDiceCard(dice: "a\(act)")
                                .frame(width: 310, height: 445)
                        }
                        .groupBoxStyle(.gameFact)
                    } else {
                        GroupBox {
                            PlayerChart(values: values, colors: colors)
                                .frame(width: 310)
                        } label: {
                            HStack {
                                Text("Tiradas de")
                                Image("a\(act)")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                Text("por jugador")
                            }
                        }
                        .groupBoxStyle(.gameFact)
                    }
                }
            }
            .scrollTargetLayout()
            .padding(.horizontal, 25)
        }
        .defaultScrollAnchor(.leading)
        .scrollTargetBehavior(.viewAligned)
        .contentMargins(.bottom, 20, for: .scrollContent)
    }
}

struct RedDiceActionsHScroll: View {
    let game: Game
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(2...4, id: \.self) { act in
                    let values: [Int] = game.act_red_values(act: act)
                    
                    if values.reduce(0, +) == 0 {
                        GroupBox {
                            MissingDiceCard(dice: "a\(act)")
                                .frame(width: 310, height: 445)
                        }
                    } else {
                        GroupBox {
                            ColorChart(color: "r", values: values)
                                .frame(width: 310)
                        } label: {
                            HStack {
                                Text("Dado rojo en tiradas de")
                                Image("a\(act)")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                            }
                        }
                        .groupBoxStyle(.gameFact)
                    }
                }
            }
            .scrollTargetLayout()
            .padding(.horizontal, 25)
        }
        .defaultScrollAnchor(.leading)
        .scrollTargetBehavior(.viewAligned)
        .contentMargins(.bottom, 20, for: .scrollContent)
    }
}

struct MissingDiceCard: View {
    let dice: String
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("No salió el")
                Image(dice)
                    .resizable()
                    .frame(width: 35, height: 35)
            }
            Text("en toda la partida")
        }
        .bold()
    }
}
