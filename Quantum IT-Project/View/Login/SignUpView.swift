//
//  SignUpView.swift
//  Quantum IT-Project
//
//  Created by Mohit Kumar Gupta on 12/09/24.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject private var keyboardObserver = KeyboardObserver()
    
    var email: String
    
    @State private var name: String = ""
    @State private var phoneNo: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var address: String = ""
    
    @State private var showSuccessMessage = false
    @State private var isLoading = false
    @State private var errorMessage = ""
    
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                
                Image("grocery")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth, height: .screenHeight)
                
                Color.black.opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        Spacer()
                            .frame(height: keyboardObserver.keyboardHeight == 0 ? 160 : 310)
                        
                        Text("Create your account")
                            .font(.customfont(.extraLight, fontSize: 13))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Sign up")
                            .font(.customfont(.medium, fontSize: 38))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    
                    ZStack {
                        Color.white.cornerRadius(40)
                        
                        ScrollView {
                            VStack {
                                Spacer()
                                    .frame(height: 20)
                                
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 80, height: 80)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.green, lineWidth: 1)
                                        )
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                    
                                    Image(systemName: "person")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 46)
                                }
                                .padding(.bottom, 2)
                                
                                RoundedTextField(txt: $name, title: "Name", placeHolder: "Enter your User name", keyboardType: .alphabet )
                                RoundedTextField(txt: $phoneNo, title: "Phone No", placeHolder: "Enter your phone No", keyboardType: .alphabet )
                                
                                Text("Address")
                                    .font(.customfont(.medium, fontSize: 15))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.lightGray)
                                    .padding(.horizontal)
                                    .padding(.top, 10)
                                
                                ZStack(alignment: .leading) {
                                    if address.isEmpty {
                                        Text("Enter your Address")
                                            .font(.customfont(.medium, fontSize: 15))
                                            .foregroundColor(.placeholder)
                                            .padding(.leading, 37)
                                            .padding(.bottom, 70)
                                    }
                                    
                                    TextField("", text: $address)
                                        .padding(19)
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 130)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 40)
                                                .stroke(Color.lightGray, lineWidth: 1)
                                        )
                                        .padding(.horizontal)
                                        .padding(.bottom, 10)
                                        .keyboardType(.alphabet)
                                }

                                VStack {
                                    PasswordTextField(txtPassword: $password, title: "Password", placeHolder: "Enter your password")
                                    PasswordTextField(txtPassword: $confirmPassword, title: "Confirm password", placeHolder: "Enter your Confirm Password")
                                        .padding(.bottom,20)
                                    
                                    RoundedButton(title: "Create account") {
                                        signUp()
                                    }
                                }
                                .padding(.bottom, 80)
                                
                                if isLoading {
                                    ProgressView("Signing Up...")
                                }
                                
                                if showSuccessMessage {
                                    Text("Account successfully created!")
                                        .foregroundColor(.green)
                                        .padding()
                                    
                                    // Navigation to HomeView after success
                                    NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                                        EmptyView()
                                    }
                                } else if !errorMessage.isEmpty {
                                    Text(errorMessage)
                                        .foregroundColor(.red)
                                        .padding()
                                }
                                
                                Spacer()
                            }
                        }
                    }
                    .frame(maxWidth: .screenWidth, maxHeight: .infinity)
                }
                
                VStack {
                    HStack {
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .padding(18)
                                .foregroundColor(.white)
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .background(Color.gray)
                                .clipShape(Circle())
                                .opacity(0.8)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.top, keyboardObserver.keyboardHeight == 0 ? 80 : 210)
                .padding(.horizontal, 20)
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
    }
    
    func signUp() {
        guard !name.isEmpty, !phoneNo.isEmpty, !password.isEmpty, !confirmPassword.isEmpty, !address.isEmpty else {
            errorMessage = "All fields are required"
            print(errorMessage)
            return
        }

        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            print(errorMessage)
            return
        }

        isLoading = true
        errorMessage = ""

        let url = URL(string: "https://grocery-backend-t65p.onrender.com/user/sign-up")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "name": name,
            "email": email,
            "address": address,
            "phone": phoneNo,
            "password": password,
            "profile_image": "" // Add image data if needed
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
        } catch {
            errorMessage = "Failed to serialize request data"
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    errorMessage = "Error: \(error.localizedDescription)"
                    print("Network Error: \(error.localizedDescription)")
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    print("Response status code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 200 {
                        showSuccessMessage = true
                        navigateToHome = true
                    } else {
                        errorMessage = "Sign up failed with status code: \(httpResponse.statusCode)"
                        if let data = data, let responseString = String(data: data, encoding: .utf8) {
                            print("Response data: \(responseString)")
                            errorMessage = "Error: \(responseString)"
                        }
                    }
                }
            }
        }.resume()
    }

}



#Preview {
    SignUpView(email: "")
}
