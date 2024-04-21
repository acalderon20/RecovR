//
//  ContentView.swift
//  RecoverRight
//
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isMenuExpanded = false
    @State private var showingHeartRate = false
    @State private var showingMedicineView = false
    
    var body: some View {
        NavigationView {
            JournalView() // Main content view
                .sheet(isPresented: $showingHeartRate) {
                    HeartRateView()  // Ensure you have defined this view somewhere in your code
                }
                .onAppear {
                    showingHeartRate = true  // Automatically show HeartRateView when ContentView appears
                }
        }
    }
}

#Preview {
    ContentView()
}
