//
//  Game.swift
//  DadosCatan
//
//  Created by coni garcia on 14/03/2024.
//

import Foundation
import SwiftData

@Model
class Game {
    var name: String
    var date = Date()
    var players: [String]
    var colors: [PlayerColor]
    var rolls: [DiceRoll]
    var boat_position = 0
    
    var new_game = true
    
    init(name: String, date: Date = Date(), players: [String], colors: [PlayerColor], rolls: [DiceRoll], new_game: Bool = true) {
        self.name = name
        self.date = date
        self.players = players
        self.colors = colors
        self.rolls = rolls
        self.new_game = new_game
    }
    
    /* returns the amonunt of times each number was rolled */
    func num_values() -> [Int] {
        var values = Array(repeating: 0, count: 11)
        for roll in self.rolls {
            if !roll.alchemist {
                values[roll.num_value-2] += 1
            }
        }
        return values
    }
    
    /* returns the amount of times each red dice face was rolled */
    func red_values() -> [Int] {
        var values = Array(repeating: 0, count: 6)
        for roll in self.rolls {
            if !roll.alchemist {
                values[roll.red_value-1] += 1
            }
        }
        return values
    }
    
    /* returns the amount of times each yellow dice face was rolled */
    func yel_values() -> [Int] {
        var values = Array(repeating: 0, count: 6)
        for roll in self.rolls {
            if !roll.alchemist {
                values[roll.yel_value-1] += 1
            }
        }
        return values
    }
    
    /* returns the amount of times each action dice face was rolled */
    func act_values() -> [Int] {
        var values = Array(repeating: 0, count: 4)
        for roll in self.rolls {
            values[roll.act_value-1] += 1
        }
        return values
    }
    
    /* returns the indeces in which the barbarians arrived */
    func attack_rolls() -> [Int] {
        var attack_rolls = [Int]()
        var boat_counter = 0
        for idx in self.rolls.indices {
            if self.rolls[idx].act_value == 1 {
                boat_counter += 1
                if boat_counter == 7 {
                    attack_rolls.append(idx)
                    boat_counter = 0
                }
            }
        }
        return attack_rolls
    }
    
    /* returns the amonunt of times each number was rolled by a player */
    func player_values(player: String) -> [Int] {
        var values = Array(repeating: 0, count: 11)
        for (idx, roll) in self.rolls.enumerated() {
            if self.players[idx%self.players.count] == player && !roll.alchemist {
                values[roll.num_value-2] += 1
            }
        }
        return values
    }
    
    /* returns the amount of times each action dice face was rolled by a player */
    func player_act_values(player: String) -> [Int] {
        var values = Array(repeating: 0, count: 4)
        for (idx, roll) in self.rolls.enumerated() {
            if self.players[idx%self.players.count] == player {
                values[roll.act_value-1] += 1
            }
        }
        return values
    }
    
    /* returns the amount of times a player made the barbarians arrive */
    func player_attack_rolls(player: String) -> Int {
        var count = 0
        let attack_rolls = self.attack_rolls()
        for idx in attack_rolls {
            if self.players[idx%self.players.count] == player {
                count += 1
            }
        }
        return count
    }
    
    /* returns the amount of times a player used the alchemist */
    func player_alchemist_rolls(player: String) -> Int {
        var count = 0
        for (idx, roll) in self.rolls.enumerated() {
            if self.players[idx%self.players.count] == player && roll.alchemist {
                count += 1
            }
        }
        return count
    }

    /* returns the current streak a number has without being rolled */
    func no_num_streak(num: Int) -> Int {
        var count = 0
        for roll in self.rolls {
            if roll.num_value != num {
                count += 1
            } else {
                count = 0
            }
        }
        return count
    }
    
    /* returns the amount of times each red dice face was rolled when an action was rolled */
    func act_red_values(act: Int) -> [Int] {
        var values = Array(repeating: 0, count: 6)
        for roll in self.rolls {
            if roll.act_value == act {
                values[roll.red_value-1] += 1
            }
        }
        return values
    }
    
    func max_attack_players() -> [String: Int] {
        var ply_attacks: [String: Int] = [:]
        for ply in self.players {
            ply_attacks[ply] = 0
        }
        let attack_rolls = self.attack_rolls()
        for idx in attack_rolls {
            ply_attacks[self.players[idx%self.players.count]]! += 1
        }
        
        var max_players: [String: Int] = [:]
        var max = 0
        for player_attack_rolls in ply_attacks {
            if player_attack_rolls.value > max {
                max_players = [:]
                max_players[player_attack_rolls.key] = player_attack_rolls.value
                max = player_attack_rolls.value
            } else if player_attack_rolls.value == max {
                max_players[player_attack_rolls.key] = player_attack_rolls.value
            }
        }
        
        return max_players
    }
}
