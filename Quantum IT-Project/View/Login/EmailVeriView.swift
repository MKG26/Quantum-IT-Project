//
//  EmailVeriView.swift
//  Quantum IT-Project
//
//  Created by Mohit Kumar Gupta on 11/09/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct EmailVeriView: View {
    
    @StateObject private var networkManager = NetworkManager()
    @State private var showingAlert = false
    @State private var email: String = ""
    @State private var navigateToOtp = false // State to control navigation

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var emailVeriVM = MainViewModel.shared;
    @ObservedObject private var keyboardObserver = KeyboardObserver()
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                
                Image("grocery")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth, height: .screenHeight)
                
                Color.black.opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    VStack{
                        Spacer()
                        
                        Text("Verify your email")
                            .font(.customfont(.extraLight, fontSize: 13))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Email Verification")
                            .font(.customfont(.medium, fontSize: 38))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding(.horizontal, 20)
                    
                    
                    ZStack{
                        Color.white.cornerRadius(40)
                        
                        VStack{
                            
                            Text("Enter the Email to get verified")
                                .font(.customfont(.medium, fontSize: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.lightGray)
                                .padding(.horizontal)
                                .padding(.top, 30)
                            
                            RoundedTextField(txt: $email, title: "Email", placeHolder: "Enter Email id", keyboardType: .emailAddress)
                                .padding(.bottom)
                            
                            RoundedButton(title: "Verify Email id"){
                                
                                networkManager.requestOTP(for: email) {
                                    if networkManager.success {
                                        showingAlert = true // Show alert when OTP is sent
                                    }
                                }
                            }
                            .padding(.bottom, 4)
                            
                            if networkManager.success {
                                Text("Success: \(networkManager.message)")
                                    .foregroundColor(.green)
                            } else if !networkManager.message.isEmpty {
                                Text("Error: \(networkManager.message)")
                                    .foregroundColor(.red)
                            }
                            
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .screenWidth, maxHeight: .infinity)
                }
                
                VStack{
                    HStack{
                        
                        Button{
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
                
                // NavigationLink with isActive
                NavigationLink(
                    destination: OtpView(email: email),
                    isActive: $navigateToOtp,
                    label: {
                        EmptyView()
                    }
                )
                
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text("OTP has been sent to your email"),
                    dismissButton: .default(Text("OK")) {
                        // Trigger navigation after dismissing alert
                        navigateToOtp = true
                    }
                )
            }
        }
    }
}


#Preview {
    EmailVeriView()
}




