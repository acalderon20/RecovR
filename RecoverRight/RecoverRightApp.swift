//
//  RecoverRightApp.swift
//  RecoverRight
//
//  Created by Adolfo Calderon on 4/20/24.
//

import SwiftUI
import SwiftData

@main
struct RecoverRightApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: JournalEntry.self)
        }
    }
}
