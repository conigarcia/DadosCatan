//
//  DiceSelectionView.swift
//  DadosCatan
//
//  Created by coni garcia on 17/03/2024.
//

import SwiftUI

struct DiceSelectionView: View {
    @Environment(\.dismiss) var dismiss

    var dice_color: String
    @Binding var dice: DiceRoll

    var body: some View {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 25) {
                ForEach(1 ... 6, id: \.self) { num in
                    Button {
                        if dice_color == "r" {
                            dice.red_value = num
                        } else if dice_color == "y" {
                            dice.yel_value = num
                        } else if dice_color == "a" {
                            if num < 5 {
                                dice.act_value = num
                            }
                        }
                        dismiss()
                    } label: {
                        if !(dice_color == "a" && num > 4) {
                            Image("\(dice_color)\(num)")
                                .resizable()
                                .frame(width: 130, height: 130)
                        }
                    }
                }
            }
            .padding(.horizontal, 45)
    }
}

#Preview("red dice") {
    @State var dice = DiceRoll(red_value: 1, yel_value: 1, act_value: 1)
    return DiceSelectionView(dice_color: "r", dice: $dice)
}

#Preview("yellow dice") {
    @State var dice = DiceRoll(red_value: 1, yel_value: 1, act_value: 1)
    return DiceSelectionView(dice_color: "y", dice: $dice)
}

#Preview("action dice") {
    @State var dice = DiceRoll(red_value: 1, yel_value: 1, act_value: 1)
    return DiceSelectionView(dice_color: "a", dice: $dice)
}
