//
//  RollView.swift
//  DadosCatan
//
//  Created by coni garcia on 17/03/2024.
//

import SwiftUI

struct RollView: View {
    @Binding var dice: DiceRoll
    
    var body: some View {
        Grid {
            GridRow {
                NavigationLink {
                    DiceSelectionView(dice_color: "r", dice: $dice)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Image("r\(dice.red_value)")
                        .resizable()
                        .frame(width: 130, height: 130)
                        .shadow(radius: 2, x: 2, y: 2)
                        .contentTransition(.identity)
                }
                .padding(.bottom, 5)
                .padding(.trailing, 5)
                
                NavigationLink {
                    DiceSelectionView(dice_color: "y", dice: $dice)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Image("y\(dice.yel_value)")
                        .resizable()
                        .frame(width: 130, height: 130)
                        .shadow(radius: 2, x: 2, y: 2)
                        .contentTransition(.identity)
                }
                .padding(.bottom, 5)
                .padding(.leading, 5)
            }
            
            NavigationLink {
                DiceSelectionView(dice_color: "a", dice: $dice)
                    .navigationBarBackButtonHidden(true)
            } label: {
                Image("a\(dice.act_value)")
                    .resizable()
                    .frame(width: 130, height: 130)
                    .shadow(radius: 2, x: 2, y: 2)
                    .contentTransition(.identity)
            }
            .padding(.top, 2)
        }
    }
}

#Preview {
    @State var dice = DiceRoll(red_value: 1, yel_value: 1, act_value: 1)
    return NavigationStack {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea()
            RollView(dice: $dice)
        }
    }
}
