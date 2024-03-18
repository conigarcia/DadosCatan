//
//  DiceRoll.swift
//  DadosCatan
//
//  Created by coni garcia on 14/03/2024.
//

import Foundation

struct DiceRoll: Codable, Hashable {
    var red_value: Int
    var yel_value: Int
    var act_value: Int
    var num_value: Int {
        red_value + yel_value
    }
    
    var alchemist: Bool = false
    
    mutating func reset() {
        self.red_value = 1
        self.yel_value = 1
        self.act_value = 1
        self.alchemist = false
    }
}
