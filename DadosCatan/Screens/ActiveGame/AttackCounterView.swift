//
//  AttackCounterView.swift
//  DadosCatan
//
//  Created by coni garcia on 24/06/2024.
//

import SwiftUI

struct AttackCounterView: View {
    @Binding var is_shown: Bool
    
    let boat_position: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 50, height: 50))
                .foregroundStyle(.blue)
                .ignoresSafeArea()
                .shadow(radius: 5)
            
            VStack {
                Button {
                    withAnimation(Animation.bouncy) {
                        is_shown.toggle()
                    }
                } label: {
                    Image(systemName: is_shown ? "chevron.compact.down" : "chevron.compact.up")
                        .font(.title)
                        .foregroundStyle(.accent)
                        .contentTransition(.symbolEffect(.replace))
                }
                .padding(.vertical, 25)
                
                if is_shown {
                    AttackBoard(boat_position: boat_position)
                        .padding(.bottom)
                        .transition(.asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top)))
                }
            }
        }
        .frame(height: is_shown ? 460 : 30)
    }
}

#Preview("attack counter") {
    return NavigationStack {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea()
            VStack { 
                Spacer()
                AttackCounterView(is_shown: .constant(true), boat_position: 7)
            }
        }
        .toolbar {
            Image(systemName: "chart.bar.xaxis")
                .foregroundStyle(.accent)
            Image(systemName: "arrow.uturn.backward.circle.fill")
                .foregroundStyle(.accent)
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.accent)
        }
    }
}

struct AttackBoard: View {
    let boat_position: Int

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    AttackBoardPlace(is_active: boat_position == 2, color: .white)
                        .opacity(boat_position == 7 ? 0.3 : 1)
                    AttackBoardPlace(is_active: boat_position == 1, color: .white)
                        .opacity(boat_position == 7 ? 0.3 : 1)
                    AttackBoardPlace(is_active: boat_position == 0, color: .white)
                        .opacity(boat_position == 7 ? 0.3 : 1)
                }
                
                HStack {
                    VStack {
                        AttackBoardPlace(is_active: boat_position == 3, color: .white)
                            .opacity(boat_position == 7 ? 0.3 : 1)
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        AttackBoardPlace(is_active: boat_position == 4, color: .white)
                            .opacity(boat_position == 7 ? 0.3 : 1)
                    }
                }
                .frame(height: 150)
                
                HStack {
                    AttackBoardPlace(is_active: boat_position == 7, color: .red)
                    AttackBoardPlace(is_active: boat_position == 6, color: .white)
                        .opacity(boat_position == 7 ? 0.3 : 1)
                    AttackBoardPlace(is_active: boat_position == 5, color: .white)
                        .opacity(boat_position == 7 ? 0.3 : 1)
                }
            }
            
            if boat_position == 7 {
                VStack {
                    Text("Llegaron los bárbaros")
                        .font(.title.smallCaps())
                        .fontWeight(.semibold)
                        .frame(width: 350, height: 100)
                        .background(.accent)
                        .clipShape(.rect(cornerRadius: 15))
                    Spacer()
                        .frame(height: 100)
                }
            }
        }
    }
}

#Preview("attack board") {
    return ZStack {
        Color(.blue)
            .ignoresSafeArea()
        AttackBoard(boat_position: 2)
    }
}

struct AttackBoardPlace: View {
    let is_active: Bool
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 3)
                .foregroundStyle(color)
                .frame(width: 70)

            if is_active {
                Image("barbarians")
                    .resizable()
            }
        }
        .frame(width: 100, height: 100)
    }
}

#Preview("attack board place") {
    return ZStack {
        Color(.blue)
            .ignoresSafeArea()
        AttackBoardPlace(is_active: true, color: .white)
    }
}
