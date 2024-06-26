//
//  MainTabView.swift
//  DadosCatan
//
//  Created by coni garcia on 18/03/2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            GameListView()
                .tabItem { Label("Partidas", systemImage: "dice.fill") }

            NavigationStack {
                TotalCharts()
                    .navigationTitle("Gráficos totales")
//                    .toolbar {
//                        ToolbarItem(placement: .topBarTrailing) {
//                            ShareLink(item: totalPDF(path: "gráficos totales.pdf"))
//                        }
//                    }
            }
            .tabItem { Label("General", systemImage: "chart.pie.fill") }
        }
    }
}
