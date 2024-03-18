//
//  GameCharts.swift
//  DadosCatan
//
//  Created by coni garcia on 17/03/2024.
//

import SwiftUI
import Charts

struct GameChart: View {
    let game: Game
    
    var values: [Int] {game.num_values()}
    var red_values: [Int] {game.red_values()}
    var yel_values: [Int] {game.yel_values()}
    var act_values: [Int] {game.act_values()}
    
    var real_roll_count: Int {game.real_roll_count()}
    var total_roll_count: Int {game.rolls.count}

    var body: some View {
        List {
            Section {
                NumChart(values: values)
                    .padding(.vertical)
            }
            Section {
                ColorChart(color: "r", values: red_values, roll_count: real_roll_count)
            }
            Section {
                ColorChart(color: "y", values: yel_values, roll_count: real_roll_count)
            }
            Section {
                ActChart(values: act_values, roll_count: total_roll_count)
            }
        }
    }
}

struct NumChart: View {
    let values: [Int]
    
    var body: some View {
        Chart {
            ForEach(2...12, id: \.self) { num in
                BarMark(x: .value("valor", String(num)), y: .value("cantidad", values[num-2]))
                    .foregroundStyle(Color.alchemist)
                    .annotation(position: .top) {
                        Text(String(values[num-2]))
                            .font(.caption)
                            .fontWeight(.bold)
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.alchemist)
                            .background(Color.background)
                            .clipShape(.rect(cornerRadius: 5))
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 400)
    }
}

struct ColorChart: View {
    let color: String
    let values: [Int]
    let roll_count: Int
    
    let red_gradient: [Color] = [.redGradient1, .redGradient2, .redGradient3, .redGradient4, .redGradient5, .redGradient6]
    let yel_gradient: [Color] = [.yelGradient1, .yelGradient2, .yelGradient3, .yelGradient4, .yelGradient5, .yelGradient6]
    
    var gradient: [Color] {color == "r" ? red_gradient : yel_gradient}
    
    @State private var selectedCount: Int?
    @State private var selectedSector: Int?

    var body: some View {
        Chart {
            ForEach(1...6, id: \.self) { num in
                let avg = Int(Float(values[num-1])*100/Float(roll_count))
                SectorMark(
                    angle: .value("cantidad", values[num-1]),
                    innerRadius: .ratio(0.4),
                    angularInset: 2
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("valor", String(num)))
                .annotation(position: .overlay) {
                    if avg > 0 {
                        Text(String(avg) + "%")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                }
                .opacity(selectedSector == nil ? 1.0 : (selectedSector == num ? 1.0 : 0.5))
            }
        }
        .chartAngleSelection(value: $selectedCount)
        .onChange(of: selectedCount) { oldValue, newValue in
            if let newValue {
                selectedSector = findSelectedSector(value: newValue)
            } else {
                selectedSector = nil
            }
        }
        .chartBackground { proxy in
            if selectedSector != nil {
                Text(String(selectedSector!))
                    .font(.system(size: 60))
                    .fontWeight(.heavy)
                    .foregroundStyle(Color(color == "r" ? "Red Dice" : "Yellow Dice"))
                    .padding(.bottom)
            }
        }
        .chartForegroundStyleScale(domain: .automatic, range: gradient)
        .frame(maxWidth: .infinity)
        .frame(height: 400)
    }
    
    private func findSelectedSector(value: Int) -> Int? {
        var accumulatedCount = 0
        
        for num in 1...6 {
            accumulatedCount += values[num-1]
            if value <= accumulatedCount {
                return num
            }
        }
        
        return nil
    }
}

struct ActChart: View {
    let values: [Int]
    let roll_count: Int
    
    let act_gradient: [Color] = [.actGradient1, .actGradient2, .actGradient3, .actGradient4]

    var body: some View {
        Chart {
            ForEach(1...4, id: \.self) { num in
                let avg = Int(Float(values[num-1])*100/Float(roll_count))
                SectorMark(
                    angle: .value("cantidad", values[num-1]),
                    angularInset: 2
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("valor", String(num)))
                .annotation(position: .overlay) {
                    if avg > 0 {
                        Text(String(avg) + "%")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .chartForegroundStyleScale(domain: .automatic, range: act_gradient)
        .chartLegend(.hidden)
        .frame(maxWidth: .infinity)
        .frame(height: 400)
    }
}

/* --- PDF CHARTS --- */

struct PDFGameChart: View {
    let game: Game
    
    var values: [Int] {game.num_values()}
    var red_values: [Int] {game.red_values()}
    var yel_values: [Int] {game.yel_values()}
    var act_values: [Int] {game.act_values()}
    
    var real_roll_count: Int {game.real_roll_count()}
    var total_roll_count: Int {game.rolls.count}

    var body: some View {
        VStack {
            NumChart(values: values)
                .padding()
            PDFColorChart(color: "r", values: red_values, roll_count: real_roll_count)
                .padding()
            PDFColorChart(color: "y", values: yel_values, roll_count: real_roll_count)
                .padding()
            ActChart(values: act_values, roll_count: total_roll_count)
                .padding()
        }
    }
}

struct PDFColorChart: View {
    let color: String
    let values: [Int]
    let roll_count: Int
    
    let red_gradient: [Color] = [.redGradient1, .redGradient2, .redGradient3, .redGradient4, .redGradient5, .redGradient6]
    let yel_gradient: [Color] = [.yelGradient1, .yelGradient2, .yelGradient3, .yelGradient4, .yelGradient5, .yelGradient6]
    
    var gradient: [Color] {color == "r" ? red_gradient : yel_gradient}
    
    var body: some View {
        Chart {
            ForEach(1...6, id: \.self) { num in
                let avg = Int(Float(values[num-1])*100/Float(roll_count))
                SectorMark(
                    angle: .value("cantidad", values[num-1]),
                    innerRadius: .ratio(0.4),
                    angularInset: 2
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("valor", String(num)))
                .annotation(position: .overlay) {
                    if avg > 0 {
                        Text(String(avg) + "%")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .chartForegroundStyleScale(domain: .automatic, range: gradient)
        .frame(maxWidth: .infinity)
        .frame(height: 400)
        .padding()
    }
}
