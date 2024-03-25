//
//  TotalCharts.swift
//  DadosCatan
//
//  Created by coni garcia on 18/03/2024.
//

import SwiftUI
import SwiftData

func get_num_values(games: [Game]) -> [Int] {
    var values = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    for game in games {
        values = zip(values, game.num_values()).map(+)
    }
    return values
}

func get_red_values(games: [Game]) -> [Int] {
    var values = [0, 0, 0, 0, 0, 0]
    for game in games {
        values = zip(values, game.red_values()).map(+)
    }
    return values
}

func get_yel_values(games: [Game]) -> [Int] {
    var values = [0, 0, 0, 0, 0, 0]
    for game in games {
        values = zip(values, game.yel_values()).map(+)
    }
    return values
}

func get_act_values(games: [Game]) -> [Int] {
    var values = [0, 0, 0, 0]
    for game in games {
        values = zip(values, game.act_values()).map(+)
    }
    return values
}

struct TotalCharts: View {
    @Query(sort: \Game.date, order: .reverse) private var games: [Game]
    
    var values: [Int] {get_num_values(games: games)}
    var red_values: [Int] {get_red_values(games: games)}
    var yel_values: [Int] {get_yel_values(games: games)}
    var act_values: [Int] {get_act_values(games: games)}

    var body: some View {
        List {
            Section {
                NumChart(values: values)
                    .padding(.vertical)
            }
            Section {
                ColorChart(color: "r", values: red_values)
            }
            Section {
                ColorChart(color: "y", values: yel_values)
            }
            Section {
                ActChart(values: act_values)
            }
        }
    }
}

struct PDFTotalCharts: View {
    @Query(sort: \Game.date, order: .reverse) private var games: [Game]
    
    var values: [Int] {get_num_values(games: games)}
    var red_values: [Int] {get_red_values(games: games)}
    var yel_values: [Int] {get_yel_values(games: games)}
    var act_values: [Int] {get_act_values(games: games)}

    var body: some View {
        VStack {
            NumChart(values: values)
                .padding()
            PDFColorChart(color: "r", values: red_values)
                .padding()
            PDFColorChart(color: "y", values: yel_values)
                .padding()
            PDFActChart(values: act_values)
                .padding()
        }
    }
}
