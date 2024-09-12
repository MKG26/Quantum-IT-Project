//
//  HomeView.swift
//  Quantum IT-Project
//
//  Created by Mohit Kumar Gupta on 12/09/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        Spacer()
            
        
            ScrollView {
                
                
                
                HStack{
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 40, height: 40)
                        
                        Image("scanner white")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 17)
                    }
                    
                    Text("Grocery Tracker")
                        .font(.customfont(.semibold, fontSize: 18))
                    
                    
                    
                    
                    ZStack {
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "crown.fill")
                                    
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                                
                                
                                Text("Subscribe")
                                    .font(.customfont(.medium, fontSize: 13))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .frame(minWidth: 120, maxWidth: .infinity, minHeight: 20, maxHeight: 90)
                        .background(Color.green)
                        .cornerRadius(20)
                        .padding(.leading)
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                
                VStack(spacing: 20) {
                    
                    
                    // Horizontal scrollable top offer section
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack{
                            
                        }
                        
                        
                        
                        HStack(spacing: 10) {
                            ForEach(0..<3) { _ in
                                VStack {
                                    
                                    HStack{
                                        Text("🔥")
                                            .font(.customfont(.medium, fontSize: 50))
                                            .frame(minWidth: 40, minHeight: 120)
                                            .padding(.horizontal, 25)
                                            .background(.yellow)
                                            
                                        
                                        VStack{
                                            Text("Just for you!")
                                                .font(.customfont(.medium, fontSize: 20))
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            Text("Claim your exclusive offer today!")
                                                .foregroundColor(.white)
                                                .font(.customfont(.regular, fontSize: 15))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                                .frame(width: 300, height: 120)
                                .background(Color.primaryApp)
                                .cornerRadius(20)
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Grocery Budget Section
                    VStack(alignment: .leading) {
                        Text("Grocery budget")
                            .font(.customfont(.medium, fontSize: 17))
                        HStack {
                            VStack(alignment: .leading) {
                                Text("€39")
                                    .font(.customfont(.medium, fontSize: 30))
                                    .foregroundColor(.white)
                                    .bold()
                                Text("Your monthly budget")
                                    .font(.customfont(.medium, fontSize: 17))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            
                            
                            Button{
                                
                            } label: {
                                ZStack{
                                    
                                    Circle()
                                        .fill(Color.white.opacity(0.2))
                                        
                                        .frame(width: 40, height: 40)
                                    
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.white)
                                }
                            }
                            
                            
                        }
                        .padding()
                        .background(Color.green)
                        .cornerRadius(20)
                    }
                    .padding(.horizontal)
                    
                    // Expiring Soon Section
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Expiring Soon")
                                .font(.customfont(.medium, fontSize: 17))
                            Spacer()
                            
                        }
                        
                        
                        VStack {
                            HStack{
                                Text("Total Products")
                                    .font(.customfont(.medium, fontSize: 17))
                                Text("0")
                                    .font(.customfont(.medium, fontSize: 17))
                                
                                Spacer()
                                
                                Button{
                                    
                                } label: {
                                    Text("View all")
                                        .font(.customfont(.medium, fontSize: 17))
                                        .foregroundColor(.green)
                                }
                                
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                            Text("Let's fill your cart with Grocery tracker and make your life easy! 🥬🛒")
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.bottom)
                            Button(action: {
                                // Add product action
                            }) {
                                Text("Add products")
                                    .font(.customfont(.medium, fontSize: 17))
                                    .foregroundColor(.primaryApp)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 80)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke(Color.lightGray, lineWidth: 1)
                                    )
                                    
                            }
                        }
                        .padding(20)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(20)
                    }
                    .padding(.horizontal)
                    
                    // Upcoming Expiry Products Section
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Upcoming Expiry products")
                                .font(.headline)
                            Spacer()
                            
                        }
                        
                        
                        VStack {
                            HStack{
                                Text("Total Products")
                                    .font(.customfont(.medium, fontSize: 17))
                                    
                                Text("0")
                                    .font(.customfont(.medium, fontSize: 17))
                                
                                Spacer()
                                
                                Button{
                                    
                                } label: {
                                    Text("View all")
                                        .font(.customfont(.medium, fontSize: 17))
                                        .foregroundColor(.white)
                                }
                                
                                
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(systemName: "cart")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding()
                                
                            
                            Text("Your cart is empty")
                                .font(.customfont(.medium, fontSize: 20))
                                .foregroundColor(.white)
                                .padding(.vertical, 2)
                            Text("Let's fill your cart with Grocery tracker and make your life easy! 🥬🛒")
                                .multilineTextAlignment(.center)
                                .font(.customfont(.medium, fontSize: 15))
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.green)
                        .cornerRadius(20)
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                    
                }
                
            }
            .background(.white)
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
}

#Preview {
    HomeView()
}
