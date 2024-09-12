//
//  NetworkManager.swift
//  Quantum IT-Project
//
//  Created by Mohit Kumar Gupta on 12/09/24.
//

import Foundation

class NetworkManager: ObservableObject {
    @Published var message: String = ""
    @Published var success: Bool = false
    
    func requestOTP(for email: String, reason: String = "sign-up", completion: @escaping () -> Void) {
        guard let url = URL(string: "https://grocery-backend-t65p.onrender.com/user/request-otp") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "email": email,
            "reason": reason
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error encoding JSON: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making request: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self.message = responseObject.message
                    self.success = responseObject.success
                    completion() // Call the completion handler when done
                }
            } catch {
                print("Error decoding response: \(error)")
            }
        }.resume()
    }
}

struct APIResponse: Codable {
    let message: String
    let success: Bool
}
