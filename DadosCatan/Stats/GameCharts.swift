//
//  GameCharts.swift
//  DadosCatan
//
//  Created by coni garcia on 17/03/2024.
//

import SwiftUI
import Charts

struct NumChart: View {
    let values: [Int]
    
    var body: some View {
        Chart {
            ForEach(2...12, id: \.self) { num in
                BarMark(x: .value("valor", String(num)), y: .value("cantidad", values[num-2]))
                    .annotation(position: .top) {
                        Text(String(values[num-2]))
                            .foregroundStyle(Color(.accent))
                            .font(.caption2)
                            .fontWeight(.bold)
                            .scaledToFit()
                            .minimumScaleFactor(0.5)
                            .frame(width: 20, height: 20)
                            .background(Color(.tertiarySystemGroupedBackground))
                            .clipShape(.rect(cornerRadius: 5))
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 400)
    }
}

#Preview("values") {
    NumChart(values: [3, 2, 6, 4, 130, 999, 250, 3, 5, 5, 3])
}

struct ColorChart: View {
    let color: String
    let values: [Int]
    
    let red_gradient: [Color] = [.redGradient1, .redGradient2, .redGradient3, .redGradient4, .redGradient5, .redGradient6]
    let yel_gradient: [Color] = [.yelGradient1, .yelGradient2, .yelGradient3, .yelGradient4, .yelGradient5, .yelGradient6]
    
    var gradient: [Color] {color == "r" ? red_gradient : yel_gradient}
    
    @State private var selectedCount: Float?
    @State private var selectedSector: Int?
    
    var body: some View {
        Chart {
            ForEach(1...6, id: \.self) { num in
                let avg = Int(Float(values[num-1])*100/Float(values.reduce(0, +)))
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
                VStack {
                    Image("\(color)\(selectedSector!)")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("\(values[selectedSector!-1]) \(values[selectedSector!-1] == 1 ? "vez" : "veces")")
                        .font(.caption)
                }
            }
        }
        .chartForegroundStyleScale(domain: .automatic, range: gradient)
        .frame(maxWidth: .infinity)
        .frame(height: 400)
    }
    
    private func findSelectedSector(value: Float) -> Int? {
        var accumulatedCount: Float = 0
        
        for num in 1...6 {
            accumulatedCount += Float(values[num-1])
            if value <= accumulatedCount && accumulatedCount != 0 {
                return num
            }
        }
        
        return nil
    }
}

#Preview("red") {
    ColorChart(color: "r", values: [8, 8, 14, 13, 6, 14])
}
#Preview("yellow") {
    ColorChart(color: "y", values: [0, 0, 0, 0, 5, 5])
}

struct ActChart: View {
    let values: [Int]
    
    let act_gradient: [Color] = [.actGradient1, .actGradient2, .actGradient3, .actGradient4]
    
    @State private var selectedCount: Float?
    @State private var selectedSector: Int?
    
    var body: some View {
        Chart {
            ForEach(1...4, id: \.self) { num in
                let avg = Int(Float(values[num-1])*100/Float(values.reduce(0, +)))
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
                VStack {
                    Image("a\(selectedSector!)")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("\(values[selectedSector!-1]) \(values[selectedSector!-1] == 1 ? "vez" : "veces")")
                        .font(.caption)
                }
            }
        }
        .chartForegroundStyleScale(domain: .automatic, range: act_gradient)
        .chartLegend(.hidden)
        .frame(maxWidth: .infinity)
        .frame(height: 400)
    }
    
    private func findSelectedSector(value: Float) -> Int? {
        var accumulatedCount: Float = 0
        
        for num in 1...4 {
            accumulatedCount += Float(values[num-1])
            if value <= accumulatedCount && accumulatedCount != 0 {
                return num
            }
        }
        
        return nil
    }
}

#Preview("action") {
    ActChart(values: [30, 9, 12, 13])
}

struct PlayerChart: View {
    let values: [(String, Int)]
    let colors: [Color]
    
    @State private var selectedCount: Float?
    @State private var selectedSector: Int?
    
    var body: some View {
        Chart {
            ForEach(values.indices, id: \.self) { idx in
                let avg = Int(Float(values[idx].1)*100/Float(values.reduce(0, { res, x in res + x.1 })))
                SectorMark(
                    angle: .value("cantidad", values[idx].1),
                    innerRadius: .ratio(0.4),
                    angularInset: 2
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("jugador", values[idx].0))
                .annotation(position: .overlay) {
                    if avg > 0 {
                        Text(String(avg) + "%")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                }
                .opacity(selectedSector == nil ? 1.0 : (selectedSector == idx ? 1.0 : 0.5))
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
                VStack {
                    Text("\(values[selectedSector!].0)")
                        .font(.system(size: 20, weight: .bold))
                    Text("\(values[selectedSector!].1) \(values[selectedSector!].1 == 1 ? "vez" : "veces")")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .padding(.bottom)
            }
        }
        .chartForegroundStyleScale(domain: .automatic, range: colors)
        .frame(maxWidth: .infinity)
        .frame(height: 400)
    }
    
    private func findSelectedSector(value: Float) -> Int? {
        var accumulatedCount: Float = 0
        
        if value != 0 {
            for idx in 0..<values.count {
                accumulatedCount += Float(values[idx].1)
                if value <= accumulatedCount && accumulatedCount != 0 {
                    return idx
                }
            }
        }
        
        return nil
    }
}

#Preview("player") {
    PlayerChart(values: [("coni", 3), ("cris", 2), ("toti", 1), ("fran", 3), ("moger", 2), ("juampe", 2)], colors: [.orangePlayer, .redPlayer, .brownPlayer, .whitePlayer, .bluePlayer, .greenPlayer])
}

/* --- PDF CHARTS --- */

//struct PDFGameChart: View {
//    let game: Game
//    
//    var values: [Int] {game.num_values()}
//    var red_values: [Int] {game.red_values()}
//    var yel_values: [Int] {game.yel_values()}
//    var act_values: [Int] {game.act_values()}
//    
//    var body: some View {
//        GroupBox {
//            HStack {
//                Spacer()
//                NumChart(values: values)
//                    .padding()
//                    .frame(width: 395)
//                Spacer()
//            }
//        }
//        
//        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
//            GroupBox {
//                Text("Dado rojo")
//                    .font(.headline)
//                    .fontWeight(.bold)
//                    .frame(height: 35)
//                    .padding(.top)
//                PDFColorChart(color: "r", values: red_values)
//                    .frame(width: 260, height: 400)
//            }
//            
//            GroupBox {
//                Text("Dado amarillo")
//                    .font(.headline)
//                    .fontWeight(.bold)
//                    .frame(height: 35)
//                    .padding(.top)
//                PDFColorChart(color: "y", values: yel_values)
//                    .frame(width: 260, height: 400)
//            }
//            
//            GroupBox {
//                Text("Dado acontecimientos")
//                    .font(.headline)
//                    .fontWeight(.bold)
//                    .frame(height: 35)
//                    .padding(.top)
//                PDFActChart(values: act_values)
//                    .frame(width: 260, height: 400)
//            }
//            
//            ForEach(1...4, id: \.self) { act in
//                GroupBox {
//                    let values: [(String, Int)] = game.players.map { ply in (ply, game.player_act_values(player: ply)[act-1]) }
//                    let colors: [Color] = game.colors.map { color in Color(color) }
//                    
//                    if values.reduce(0, { res, x in res + x.1 }) == 0 {
//                        VStack(alignment: .center) {
//                            HStack {
//                                Text("No salió")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                Image("a\(act)")
//                                    .resizable()
//                                    .frame(width: 35, height: 35)
//                            }
//                            Text("en toda la partida")
//                                .font(.headline)
//                                .fontWeight(.bold)
//                        }
//                        .frame(width: 260, height: 400)
//                    } else {
//                        VStack {
//                            HStack {
//                                Text("Tiradas de")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                Image("a\(act)")
//                                    .resizable()
//                                    .frame(width: 35, height: 35)
//                                Text("por jugador")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                            }
//                            .padding(.top)
//                            
//                            PDFPlayerChart(values: values, colors: colors)
//                                .frame(width: 260, height: 400)
//                        }
//                    }
//                }
//            }
//            
//            ForEach(5...15, id: \.self) { num in
//                GroupBox {
//                    let values: [(String, Int)] = game.players.map { ply in (ply, game.player_values(player: ply)[num-5]) }
//                    let colors: [Color] = game.colors.map { color in Color(color) }
//                    
//                    if values.reduce(0, { res, x in res + x.1 }) == 0 {
//                        VStack(alignment: .center) {
//                            HStack {
//                                Text("No salió el")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                Image("n\(num-3)")
//                                    .resizable()
//                                    .frame(width: 35, height: 35)
//                            }
//                            Text("en toda la partida")
//                                .font(.headline)
//                                .fontWeight(.bold)
//                        }
//                        .frame(width: 260, height: 400)
//                    } else {
//                        VStack{
//                            HStack {
//                                Text("Tiradas de")
//                                    .fontWeight(.bold)
//                                    .font(.headline)
//                                Image("n\(num-3)")
//                                    .resizable()
//                                    .frame(width: 35, height: 35)
//                                Text("por jugador")
//                                    .fontWeight(.bold)
//                                    .font(.headline)
//                            }
//                            .padding(.top)
//                            
//                            PDFPlayerChart(values: values, colors: colors)
//                                .frame(width: 260, height: 400)
//                        }
//                    }
//                    
//                }
//            }
//        }
//    }
//}
//
//struct PDFColorChart: View {
//    let color: String
//    let values: [Int]
//    
//    let red_gradient: [Color] = [.redGradient1, .redGradient2, .redGradient3, .redGradient4, .redGradient5, .redGradient6]
//    let yel_gradient: [Color] = [.yelGradient1, .yelGradient2, .yelGradient3, .yelGradient4, .yelGradient5, .yelGradient6]
//    
//    var gradient: [Color] {color == "r" ? red_gradient : yel_gradient}
//    
//    var body: some View {
//        Chart {
//            ForEach(1...6, id: \.self) { num in
//                let avg = Int(Float(values[num-1])*100/Float(values.reduce(0, +)))
//                SectorMark(
//                    angle: .value("cantidad", values[num-1]),
//                    innerRadius: .ratio(0.4),
//                    angularInset: 2
//                )
//                .cornerRadius(5)
//                .foregroundStyle(by: .value("valor", String(num)))
//                .annotation(position: .overlay) {
//                    if avg > 0 {
//                        Text(String(avg) + "%")
//                            .font(.headline)
//                            .fontWeight(.bold)
//                            .foregroundStyle(.white)
//                    }
//                }
//            }
//        }
//        .chartForegroundStyleScale(domain: .automatic, range: gradient)
//        .frame(maxWidth: .infinity)
//        .frame(height: 400)
//        .padding()
//    }
//}
//
//struct PDFActChart: View {
//    let values: [Int]
//    
//    let act_gradient: [Color] = [.actGradient1, .actGradient2, .actGradient3, .actGradient4]
//    
//    var body: some View {
//        Chart {
//            ForEach(1...4, id: \.self) { num in
//                let avg = Int(Float(values[num-1])*100/Float(values.reduce(0, +)))
//                SectorMark(
//                    angle: .value("cantidad", values[num-1]),
//                    innerRadius: .ratio(0.4),
//                    angularInset: 2
//                )
//                .cornerRadius(5)
//                .foregroundStyle(by: .value("valor", String(num)))
//                .annotation(position: .overlay) {
//                    if avg > 0 {
//                        Text(String(avg) + "%")
//                            .font(.headline)
//                            .fontWeight(.bold)
//                            .foregroundStyle(.white)
//                    }
//                }
//            }
//        }
//        .chartForegroundStyleScale(domain: .automatic, range: act_gradient)
//        .chartLegend(.hidden)
//        .frame(maxWidth: .infinity)
//        .frame(height: 400)
//    }
//}
//
//struct PDFPlayerChart: View {
//    let values: [(String, Int)]
//    let colors: [Color]
//    
//    var body: some View {
//        Chart {
//            ForEach(values.indices, id: \.self) { idx in
//                let avg = Int(Float(values[idx].1)*100/Float(values.reduce(0, { res, x in res + x.1 })))
//                SectorMark(
//                    angle: .value("cantidad", values[idx].1),
//                    innerRadius: .ratio(0.4),
//                    angularInset: 2
//                )
//                .cornerRadius(5)
//                .foregroundStyle(by: .value("jugador", values[idx].0))
//                .annotation(position: .overlay) {
//                    if avg > 0 {
//                        Text(String(avg) + "%")
//                            .font(.headline)
//                            .fontWeight(.bold)
//                            .foregroundStyle(.white)
//                    }
//                }
//            }
//        }
//        .chartForegroundStyleScale(domain: .automatic, range: colors)
//        .frame(maxWidth: .infinity)
//        .frame(height: 400)
//    }
//}
