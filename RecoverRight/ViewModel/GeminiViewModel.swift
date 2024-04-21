//
//  GeminiViewModel.swift
//  RecoverRight
//
//  Created by Adolfo Calderon on 4/21/24.
//

import Foundation
import GoogleGenerativeAI

@MainActor
class GeminiViewModel: ObservableObject {
    @Published var responseText: String = ""
    @Published var isLoading = false
    
    private var apiKey: String {
        ProcessInfo.processInfo.environment["API_KEY"] ?? "Your_Default_API_Key"
    }
    
    lazy var model = GenerativeModel(name: "gemini-pro", apiKey: apiKey)

    func sendPrompt(prompt: String) {
        isLoading = true
        Task {
            do {
                let response = try await model.generateContent(prompt)
                if let text = response.text {
                    responseText = text
                } else {
                    responseText = "No response text received."
                }
            } catch {
                responseText = "Error: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
}
