//
//  ContentView.swift
//  RecoverRight
//
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        TabView {
            HeartRateView()
                .tabItem {
                    Label("Heart", systemImage: "heart")
                }
            JournalView()
                .tabItem {
                    Label("Journal", systemImage: "book")
                }
        }
    }
}
    

#Preview {
    ContentView()
}
