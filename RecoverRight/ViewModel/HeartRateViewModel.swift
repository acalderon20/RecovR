//
//  HeartRateViewModel.swift
//  RecoverRight
//
//

import Foundation

class HeartRateViewModel: ObservableObject {
    @Published var weeklyHeartRates: [Double] = []
    @Published var showAlert = false

    func fetchWeeklyHeartRates() {
        HealthKitManager.shared.getWeeklyHeartRate { [weak self] rates, error in
            if let rates = rates {
                DispatchQueue.main.async {
                    self?.weeklyHeartRates = rates
                    self?.checkForHighRates(rates)
                }
            }
        }
    }

    private func checkForHighRates(_ rates: [Double]) {
        if rates.contains(where: { $0 > 100 }) {
            self.showAlert = true
        }
    }
}
