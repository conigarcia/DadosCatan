//
//  PlayerColor.swift
//  TorneosCatan
//
//  Created by coni garcia on 18/05/2024.
//

import Foundation
import SwiftUI

enum PlayerColor: Codable, CaseIterable, Identifiable {
    case red, orange, blue, green, brown, white
    var id: Self { self }
    var color: Color {
        switch self {
        case .red:
            Color(.red)
        case .orange:
            Color(.orange)
        case .blue:
            Color(.blue)
        case .green:
            Color(.green)
        case .brown:
            Color(.brown)
        case .white:
            Color(.gray)
        }
    }
}
