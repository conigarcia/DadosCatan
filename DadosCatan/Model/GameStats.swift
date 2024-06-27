//
//  GameStats.swift
//  DadosCatan
//
//  Created by coni garcia on 27/06/2024.
//

import Foundation
import SwiftData

@Model
class GameStats {
    let game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    var num_values = Array(repeating: 0, count: 11)
    var red_values = Array(repeating: 0, count: 6)
    var yel_values = Array(repeating: 0, count: 6)
    var act_values = Array(repeating: 0, count: 4)
    
    /* returns the indeces in which the barbarians arrived */
    var attack_rolls = [Int]()
    
    /* returns the current (last if the game is finished) streak a number has without being rolled */
    var no_num_streak = Array(repeating: 0, count: 11)
    
    /* amount of times each red dice face was rolled when a color action was rolled */
    var yellow_red_values = Array(repeating: 0, count: 6)
    var green_red_values = Array(repeating: 0, count: 6)
    var blue_red_values = Array(repeating: 0, count: 6)
    
    func calculate_no_num_streak() {
        no_num_streak = Array(repeating: 0, count: 11)
        for roll in self.game.rolls {
            for num in 2...12 {
                if num == roll.num_value {
                    self.no_num_streak[num-2] = 0
                } else {
                    self.no_num_streak[num-2] += 1
                }
            }
        }
    }
}
