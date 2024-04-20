//
//  JournalEntry.swift
//  RecoverRight
//
//  Created by Adolfo Calderon on 4/20/24.
//

import Foundation
import SwiftData

@Model
class JournalEntry {
    let date: Date
    let content: String
    
    init(date: Date, content: String) {
        self.date = date
        self.content = content
    }
}

