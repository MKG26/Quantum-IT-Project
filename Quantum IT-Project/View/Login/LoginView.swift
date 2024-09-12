//
//  WelcomeView.swift
//  Quantum IT-Project
//
//  Created by Mohit Kumar Gupta on 11/09/24.
//

import SwiftUI

struct LoginView: View {
    
    
    @State var txtUsername: String = ""
    @State var txtPassword: String = ""
    @State private var errorMessage: String = ""
    @State private var isLoading = false
    @State private var showSuccessMessage = false
    @State private var token: String = ""
    @State private var isHomeViewActive = false

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
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
                            .frame(height: 80)
                        
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 60, height: 60)
                            
                            Image("scanner")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        .padding(.bottom, 2)
                        
                        Text("Grocery tracker")
                            .font(.customfont(.regular, fontSize: 23))
                            .foregroundColor(.white)
                        
                        Spacer()
                            .frame(height: 70)
                        
                        Text("Welcome back")
                            .font(.customfont(.extraLight, fontSize: 13))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        Text("Sign in")
                            .font(.customfont(.medium, fontSize: 38))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                    }
                    
                    ZStack {
                        Color.white.cornerRadius(40)
                        
                        VStack {
                            RoundedTextField(txt: $txtUsername, title: "User name", placeHolder: "Enter your User name", keyboardType: .alphabet)
                            
                            PasswordTextField(txtPassword: $txtPassword, title: "Password", placeHolder: "Enter your password")
                            
                            Button {
                                // Action for Forgot Password
                            } label: {
                                Text("Forgot Password")
                                    .font(.customfont(.medium, fontSize: 15))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .foregroundColor(.red)
                                    .padding(.horizontal)
                                    .padding(.top, 3)
                                    .padding(.bottom)
                            }
                            
                            RoundedButton(title: "Login") {
                                login()
                            }
                            .padding(.bottom, 3)
                            
                            if #available(iOS 15.0, *) {
                                NavigationLink(destination: EmailVeriView()) {
                                    Text("Create account")
                                        .font(.customfont(.medium, fontSize: 20))
                                        .foregroundColor(.primaryApp)
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 40)
                                                .stroke(Color.lightGray, lineWidth: 1)
                                        )
                                        .padding(.horizontal)
                                }
                            } else {
                                
                            }
                            
                            
                            NavigationLink(destination: HomeView(), isActive: $isHomeViewActive) {
                                EmptyView()
                            }
                        }
                        .frame(maxWidth: .screenWidth, maxHeight: .infinity)
                        .padding(.vertical)
                    }
                    .frame(maxWidth: .screenWidth, maxHeight: .infinity)
                    
                    if isLoading {
                        ProgressView("Logging in...")
                    }
                    
                    if showSuccessMessage {
                        Text("Login successful!")
                            .foregroundColor(.green)
                            .padding()
                    } else if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }

    
    func login() {
        guard !txtUsername.isEmpty, !txtPassword.isEmpty else {
            errorMessage = "Please fill in all fields"
            print("Login error: Empty fields")
            return
        }
        
        isLoading = true
        errorMessage = ""
        
        let url = URL(string: "https://grocery-backend-t65p.onrender.com/user/sign-in")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "email": txtUsername,
            "password": txtPassword
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                
                if let error = error {
                    errorMessage = "Error: \(error.localizedDescription)"
                    print("Login error: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    errorMessage = "Login failed. Please check your credentials."
                    print("Login failed: Invalid response")
                    return
                }
                
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        if let responseDict = jsonResponse as? [String: Any], let success = responseDict["success"] as? Bool, success {
                            showSuccessMessage = true
                            token = responseDict["token"] as? String ?? ""
                            print("Login successful: Token received - \(token)")
                            // Navigate to HomeView
                            navigateToHomeView()
                        } else {
                            errorMessage = "Login failed. Please try again."
                            
                        }
                    } catch {
                        errorMessage = "Error parsing response"
                        print("Login error: \(error.localizedDescription)")
                    }
                }
            }
        }.resume()
    }
    
    func navigateToHomeView() {
        isHomeViewActive = true
    }
}


#Preview {
    LoginView()
}
