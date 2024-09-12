//
//  RoundedButton.swift
//  Quantum IT-Project
//
//  Created by Mohit Kumar Gupta on 11/09/24.
//

import SwiftUI

struct RoundedButton: View {
    
    @State var title: String = "Title"
    var didTap: (()->())?
    
    var body: some View {
        Button{
            didTap?()
        } label: {
            Text(title)
                .font(.customfont(.medium, fontSize: 20))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
        .background(Color.primaryApp)
        .cornerRadius(30)
        .padding(.horizontal)
        
    }
}

#Preview {
    RoundedButton()
}
