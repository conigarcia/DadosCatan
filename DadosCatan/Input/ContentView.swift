//
//  ContentView.swift
//  DadosCatan
//
//  Created by coni garcia on 18/03/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GamesListView()
                .tabItem { Label("Partidas", systemImage: "list.bullet") }

            NavigationStack {
                TotalCharts()
                    .navigationTitle("Gráficos totales")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            ShareLink(item: totalPDF(path: "gráficos totales.pdf"))
                        }
                    }
            }
            .tabItem { Label("General", systemImage: "chart.pie.fill") }
        }
    }
}

#Preview {
    ContentView()
}
