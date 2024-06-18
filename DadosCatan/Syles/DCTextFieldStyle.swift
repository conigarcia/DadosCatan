//
//  DCTextFieldStyle.swift
//  TorneosCatan
//
//  Created by coni garcia on 18/05/2024.
//

import SwiftUI

struct DCTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.leading)
            .frame(height: 50)
            .background(Color(.appSecondaryBackground))
            .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    @State var input = ""
    
    return ZStack {
        Color(.appBackground)
            .ignoresSafeArea()
        
        TextField(text: $input, prompt: Text("Escriba algo")) {}
            .textFieldStyle(DCTextFieldStyle())
            .padding()
    }
}
