//
//  GeminiView.swift
//  RecoverRight
//
//  Created by Adolfo Calderon on 4/21/24.
//

import SwiftUI
import GoogleGenerativeAI


struct GeminiView: View {
    @StateObject private var viewModel = GeminiViewModel()
    @State private var prompt: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter your prompt:")
                .font(.headline)
            
            TextField("Write a story about a magic backpack...", text: $prompt)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Generate") {
                viewModel.sendPrompt(prompt: prompt)
            }
            .padding()
            .disabled(prompt.isEmpty)
            .buttonStyle(.borderedProminent)
            
            if viewModel.isLoading {
                ProgressView("Generating...")
            } else {
                ScrollView {
                    Text(viewModel.responseText)
                        .padding()
                }
            }
        }
        .padding()
        .navigationTitle("Gemini Generator")
    }
}


#Preview {
    GeminiView()
}
