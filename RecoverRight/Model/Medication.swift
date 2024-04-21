//
//  Medication.swift
//  RecoverRight
//
//  Created by Adolfo Calderon on 4/20/24.
//

import Foundation
import SwiftData

struct Medication: Identifiable {
    let id = UUID()
    var name: String
    var time: Date
}
