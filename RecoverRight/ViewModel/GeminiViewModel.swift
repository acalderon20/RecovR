//
//  GeminiViewModel.swift
//  RecoverRight
//
//  Created by Adolfo Calderon on 4/21/24.
//

import Foundation
import GoogleGenerativeAI

import Foundation
import Combine

class GeminiViewModel: ObservableObject {
    @Published var responseText: String = ""
    @Published var isLoading = false

//    private var apiKey: String {
//        ProcessInfo.processInfo.environment["API_KEY"] ?? "Your_Default_API_Key"
//    }
    private var apiKey = "AIzaSyDjJIcOn07xPEhDk8-5yamEcMUzkcCls34"

    lazy var model = GenerativeModel(name: "gemini-pro", apiKey: apiKey)

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    func sendPrompt(entries: [JournalEntry]) {
        isLoading = true  // Start loading state
        let entriesText = entries.map { entry -> String in
            let formattedDate = dateFormatter.string(from: entry.date)
            return "\(formattedDate): \(entry.content)"
        }.joined(separator: "\n")

        let fullPrompt = """
        Analyze the following patient journal entries and provide a concise summary that highlights key information relevant to patient safety. Entries:
        \(entriesText)
        
        Analyze the following patient journal entry and provide a concise summary that highlights key information relevant to patient safety. Specifically, identify any keywords or sentiments related to potential safety concerns, such as:
        Medication side effects or adherence issues: Look for mentions of specific medications, dosages, missed doses, or experienced side effects.
        Changes in physical health: Identify descriptions of new or worsening symptoms, falls, injuries, or changes in mobility.
        Mental health and cognitive changes: Detect expressions of anxiety, depression, confusion, memory problems, or changes in mood or sleep patterns.
        Environmental hazards: Look for mentions of potential safety hazards in the patient's environment, such as fall risks at home or difficulties accessing necessary resources.
        Additionally, categorize the overall sentiment of the journal entry as positive, negative, or neutral. In your response, Give exactly one coherent response in one paragraph, and in the response, use a few sentences to tell the patient what they can do in a friendly way. ONLY provide this one friendly response and nothing else.
        """

        Task {
            do {
                let response = try await model.generateContent(fullPrompt)
                DispatchQueue.main.async {  // Ensure UI updates are on the main thread
                    if let text = response.text {
                        self.responseText = text
                    } else {
                        self.responseText = "No response text received."
                    }
                    self.isLoading = false  // End loading state
                }
            } catch {
                DispatchQueue.main.async {
                    self.responseText = "Error: \(error.localizedDescription)"
                    self.isLoading = false  // End loading state
                }
            }
        }
    }
}
