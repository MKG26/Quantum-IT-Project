//
//  TextField.swift
//  Quantum IT-Project
//
//  Created by Mohit Kumar Gupta on 12/09/24.
//

import SwiftUI

struct RoundedTextField: View {
    @Binding var txt: String
    @State var title: String = "Title"
    @State var placeHolder: String = "PlaceHolder"
    @State var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack{
            Text(title)
                .font(.customfont(.medium, fontSize: 15))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.lightGray)
                .padding(.horizontal)
                .padding(.top, 10)
            
            ZStack(alignment: .leading) {
                if txt.isEmpty {
                    Text(placeHolder)
                        .font(.customfont(.medium, fontSize: 15))
                        .foregroundColor(.placeholder)
                        .padding(.leading, 37)
                        .padding(.bottom,11)
                }
                
                TextField("", text: $txt)
                    .padding(19)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.lightGray, lineWidth: 1)
                    )
                
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .keyboardType(keyboardType)
            }
        }
    }
}

struct RoundedTextField_Previews: PreviewProvider {
    @State static var txt: String = ""
    static var previews: some View{
        RoundedTextField(txt: $txt)
    }
}
