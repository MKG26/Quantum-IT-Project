//
//  MainViewModel.swift
//  Quantum IT-Project
//
//  Created by Mohit Kumar Gupta on 12/09/24.
//

import SwiftUI

class MainViewModel: ObservableObject {
    static var shared: MainViewModel = MainViewModel()
    
    
    @Published var txtUsername: String = ""
    @Published var txtPassword: String = ""
    
    
    
    @Published var txtEmail: String = ""
    
}


