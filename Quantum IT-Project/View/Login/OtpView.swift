//
//  OtpView.swift
//  Quantum IT-Project
//
//  Created by Mohit Kumar Gupta on 12/09/24.
//

import SwiftUI



@available(iOS 15.0, *)
struct OtpView: View {

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject private var keyboardObserver = KeyboardObserver()

    @State private var otp1 = ""
    @State private var otp2 = ""
    @State private var otp3 = ""
    @State private var otp4 = ""
    @State private var isLoading = false
    var email: String

    @FocusState private var focusedField: OtpField?
    
    @State private var remainingTime = 60
    @State private var timerActive = true
    @State private var resendEnabled = false
    @State private var navigateToSignUp = false // New state for navigation
    
    @available(iOS 15.0, *)
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
                    
                    
                        
                    ZStack {
                        Color.white.cornerRadius(40)
                        Spacer()
                            
                        VStack {
                            Text("Enter the Verification Code we just sent to your email address")
                                .font(.customfont(.medium, fontSize: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.lightGray)
                                .padding(.horizontal)
                                .padding(.top, 30)
                            
                            Text(email)
                                .font(.customfont(.medium, fontSize: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.lightGray)
                                .padding(.horizontal)
                                .padding(.top, 8)

                            HStack(spacing: 15) {
                                otpTextField($otp1)
                                    .focused($focusedField, equals: .otp1)
                                    .onChange(of: otp1) { newValue in
                                        if newValue.count == 1 {
                                            focusedField = .otp2
                                        }
                                    }
                                    
                                otpTextField($otp2)
                                    .focused($focusedField, equals: .otp2)
                                    .onChange(of: otp2) { newValue in
                                        if newValue.count == 1 {
                                            focusedField = .otp3
                                        }
                                    }
                                otpTextField($otp3)
                                    .focused($focusedField, equals: .otp3)
                                    .onChange(of: otp3) { newValue in
                                        if newValue.count == 1 {
                                            focusedField = .otp4
                                        }
                                    }
                                otpTextField($otp4)
                                    .focused($focusedField, equals: .otp4)
                                    .onChange(of: otp4) { newValue in
                                        if newValue.count == 1 {
                                            focusedField = nil
                                        }
                                    }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 15)
                            
                            HStack {
                                Text(timeString(from: remainingTime))
                                    .font(.customfont(.regular, fontSize: 17))

                                Button(action: {
                                    resendOTP()
                                }) {
                                    Text("Resend OTP")
                                        .font(.customfont(.semibold, fontSize: 17))
                                        .foregroundColor(resendEnabled ? .blue : .gray)
                                }
                                .disabled(!resendEnabled)
                            }
                            .padding(.bottom, 15)

                            // NavigationLink to SignUpView
                            NavigationLink(destination: SignUpView(email: email), isActive: $navigateToSignUp) {
                                EmptyView()
                            }

                            RoundedButton(title: "Create Account") {
                                verifyOTP()
                            }
                            .padding(.bottom, 4)

                            Spacer()
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
                        .frame(height: keyboardObserver.keyboardHeight == 0 ? 410 : 410)
                        
                }
                
                .padding(.horizontal, 20)
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
        .onAppear(perform: startTimer)
        .onAppear {
            focusedField = .otp1
        }
    }
    
    
    private func otpTextField(_ binding: Binding<String>) -> some View {
           TextField("", text: binding)
               .frame(width: 60, height: 60)
               .multilineTextAlignment(.center)
               .keyboardType(.numberPad)
               .font(.title)
               .background(Color.gray.opacity(0.1))
               .cornerRadius(30)
               .onChange(of: binding.wrappedValue) { newValue in
                   if newValue.count > 1 {
                       binding.wrappedValue = String(newValue.prefix(1))
                   }
               }
       }
    
    private func startTimer() {
           Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
               if remainingTime > 0 {
                   remainingTime -= 1
               } else {
                   timer.invalidate()
                   resendEnabled = true // Enable the resend button
               }
           }
       }

       // Format the time string
       private func timeString(from seconds: Int) -> String {
           let minutes = seconds / 60
           let seconds = seconds % 60
           return String(format: "%02d:%02d", minutes, seconds)
       }

       // Resend OTP action
       private func resendOTP() {
           remainingTime = 60 // Reset the timer
           resendEnabled = false // Disable the resend button
           startTimer() // Restart the timer
       }
    

    private func verifyOTP() {
        let otp = otp1 + otp2 + otp3 + otp4
        guard otp.count == 4 else {
            print("Enter complete OTP")
            return
        }

        let params = ["email": email, "otp": otp]
        let url = URL(string: "https://grocery-backend-t65p.onrender.com/user/verifyOtp")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)

        isLoading = true

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false

                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let success = jsonResponse["success"] as? Bool, success {
                            print("OTP Verified Successfully")
                            navigateToSignUp = true // Trigger navigation
                        } else {
                            print("OTP Verification Failed")
                        }
                    }
                } catch {
                    print("Failed to parse response: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}


// Enum to track which field is focused
enum OtpField {
    case otp1, otp2, otp3, otp4
}

#Preview{
    OtpView(email: "")
}


