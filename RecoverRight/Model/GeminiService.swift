//
//  GeminiService.swift
//  RecoverRight
//
//  Created by Adolfo Calderon on 4/21/24.
//

import Foundation

struct GeminiResponse: Decodable {
    var result: String // Customize according to the actual response structure
}

class GeminiAPI {
    static let shared = GeminiAPI()
    private var apiKey: String {
        ProcessInfo.processInfo.environment["API_KEY"] ?? "DEFAULT_API_KEY"
    }
    private let session = URLSession(configuration: .default)

    func fetchResponse(prompt: String, completion: @escaping (Result<GeminiResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.example.com/gemini") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        let body: [String: Any] = ["prompt": prompt]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "Network error"])))
                return
            }

            do {
                let response = try JSONDecoder().decode(GeminiResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
