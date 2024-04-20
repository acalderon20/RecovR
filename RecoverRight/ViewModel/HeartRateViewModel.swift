//
//  HeartRateViewModel.swift
//  RecoverRight
//
//

import Foundation

class HeartRateViewModel: ObservableObject {
    @Published var heartRate: String = "Unknown"
    private var healthKitManager = HealthKitManager.shared

    func fetchHeartRate() {
        healthKitManager.authorizeHealthKit { [weak self] authorized, error in
            if authorized {
                self?.healthKitManager.getMostRecentHeartRate { rate, error in
                    if let rate = rate {
                        DispatchQueue.main.async {
                            self?.heartRate = String(format: "%.0f", rate)
                        }
                    } else {
                        print("Error fetching heart rate: \(String(describing: error))")
                    }
                }
            } else {
                print("HealthKit authorization failed: \(String(describing: error))")
            }
        }
    }
}
