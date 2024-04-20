//
//  HealthKitManager.swift
//  RecoverRight
//
//

import Foundation
import HealthKit

enum HealthError: Error {
    case notAvailableOnDevice
    case dataTypeNotAvailable
    case unauthorized
}

class HealthKitManager {
    static let shared = HealthKitManager()
    private var healthStore: HKHealthStore?

    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        } else {
            print("HealthKit is not available on this device.")
        }
    }

    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            completion(false, HealthError.dataTypeNotAvailable)
            return
        }

        healthStore?.requestAuthorization(toShare: nil, read: Set([heartRateType])) { success, error in
            completion(success, error)
        }
    }

    func getMostRecentHeartRate(completion: @escaping (Double?, Error?) -> Void) {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            completion(nil, HealthError.dataTypeNotAvailable)
            return
        }

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { _, samples, error in
            guard let samples = samples, let mostRecentSample = samples.first as? HKQuantitySample else {
                completion(nil, error)
                return
            }

            let heartRate = mostRecentSample.quantity.doubleValue(for: HKUnit(from: "count/min"))
            completion(heartRate, nil)
        }

        healthStore?.execute(query)
    }
}
