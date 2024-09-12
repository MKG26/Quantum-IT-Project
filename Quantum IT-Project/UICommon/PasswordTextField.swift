import SwiftUI

struct PasswordTextField: View {
    @Binding var txtPassword: String
    @State var title: String = "Title"
    @State var placeHolder: String = "PlaceHolder"
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        VStack {
            Text(title)
                .font(.customfont(.medium, fontSize: 15))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.lightGray)
                .padding(.horizontal)
            
            ZStack {
                if txtPassword.isEmpty {
                    // Placeholder text
                    Text(placeHolder)
                        .font(.customfont(.medium, fontSize: 15))
                        .foregroundColor(.placeholder)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 37)
                }
                
                if isPasswordVisible {
                    TextField("", text: $txtPassword)
                        .padding(18)
                        .padding(.trailing, 40) // Leave space for eye button
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.lightGray, lineWidth: 1)
                        )
                        .overlay(
                            HStack {
                                Spacer()
                                Button(action: {
                                    isPasswordVisible.toggle()
                                }) {
                                    Image(systemName: "eye.circle")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 15)
                                }
                            }
                        )
                        .padding(.horizontal)
                } else {
                    SecureField("", text: $txtPassword)
                        .padding(18)
                        .padding(.trailing, 40) // Leave space for eye button
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.lightGray, lineWidth: 1)
                        )
                        .overlay(
                            HStack {
                                Spacer()
                                Button(action: {
                                    isPasswordVisible.toggle()
                                }) {
                                    Image(systemName: "eye.circle")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 15)
                                }
                            }
                        )
                        .padding(.horizontal)
                }
            }
        }
    }
}


struct PasswordTextField_Previews: PreviewProvider {
    @State static var txt: String = ""
    static var previews: some View{
        PasswordTextField(txtPassword: $txt)
    }
}
