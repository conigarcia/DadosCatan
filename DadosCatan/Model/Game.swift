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
    var rolls: [DiceRoll]
    
    var new_game = true
    
    init(name: String, date: Date = Date(), players: [String], rolls: [DiceRoll], new_game: Bool = true) {
        self.name = name
        self.date = date
        self.players = players
        self.rolls = rolls
        self.new_game = new_game
    }

    func real_roll_count() -> Int {
        var count = 0
        for roll in self.rolls {
            if !roll.alchemist {
                count += 1
            }
        }
        return count
    }
    
    func num_values() -> [Int] {
        var values = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        for roll in self.rolls {
            if !roll.alchemist {
                values[roll.num_value-2] += 1
            }
        }
        return values
    }
    
    func red_values() -> [Int] {
        var values = [0, 0, 0, 0, 0, 0]
        for roll in self.rolls {
            if !roll.alchemist {
                values[roll.red_value-1] += 1
            }
        }
        return values
    }
    
    func yel_values() -> [Int] {
        var values = [0, 0, 0, 0, 0, 0]
        for roll in self.rolls {
            if !roll.alchemist {
                values[roll.yel_value-1] += 1
            }
        }
        return values
    }
    
    func act_values() -> [Int] {
        var values = [0, 0, 0, 0]
        for roll in self.rolls {
            values[roll.act_value-1] += 1
        }
        return values
    }
    
    func attack_rolls() -> [Int] {
        var attack_rolls: [Int] = []
        var boat_counter = 0
        for idx in 0..<self.rolls.count {
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
    
    func player_values(player: String) -> [Int] {
        var values = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        for (idx, roll) in self.rolls.enumerated() {
            if self.players[idx%self.players.count] == player && !roll.alchemist {
                values[roll.num_value-2] += 1
            }
        }
        return values
    }
    
    func player_act_values(player: String) -> [Int] {
        var values = [0, 0, 0, 0]
        for (idx, roll) in self.rolls.enumerated() {
            if self.players[idx%self.players.count] == player {
                values[roll.act_value-1] += 1
            }
        }
        return values
    }
    
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
    
    func player_alchemist_rolls(player: String) -> Int {
        var count = 0
        for (idx, roll) in self.rolls.enumerated() {
            if self.players[idx%self.players.count] == player && roll.alchemist {
                count += 1
            }
        }
        return count
    }
    
    func most_seven_player() -> (String, Int) {
        var max_player = ""
        var max_seven: Int = .min
        for player in self.players {
            let values = self.player_values(player: player)
            if values[7-2] > max_seven {
                max_seven = values[7-2]
                max_player = player
            }
        }
        return (max_player, max_seven)
    }
    
    func least_seven_player() -> (String, Int) {
        var min_player = ""
        var min_seven: Int = .max
        for player in self.players {
            let values = self.player_values(player: player)
            if values[7-2] < min_seven {
                min_seven = values[7-2]
                min_player = player
            }
        }
        return (min_player, min_seven)
    }
    
    func most_boat_player() -> (String, Int) {
        var max_player = ""
        var max_boat: Int = .min
        for player in self.players {
            let act_values = self.player_act_values(player: player)
            if act_values[1-1] > max_boat {
                max_boat = act_values[1-1]
                max_player = player
            }
        }
        return (max_player, max_boat)
    }
    
    func least_boat_player() -> (String, Int) {
        var min_player = ""
        var min_boat: Int = .max
        for player in self.players {
            let act_values = self.player_act_values(player: player)
            if act_values[1-1] < min_boat {
                min_boat = act_values[1-1]
                min_player = player
            }
        }
        return (min_player, min_boat)
    }
    
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
    
    func act_red_values(act: Int) -> [Int] {
        var values = [0, 0, 0, 0, 0, 0]
        for roll in self.rolls {
            if roll.act_value == act {
                values[roll.red_value-1] += 1
            }
        }
        return values
    }
}
