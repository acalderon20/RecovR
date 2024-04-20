//
//  JournalView.swift
//  RecoverRight
//
//  Created by Adolfo Calderon on 4/20/24.
//

import SwiftUI
import SwiftData

struct JournalView: View {
    
    @Query private var entries: [JournalEntry]
    @Environment(\.modelContext) private var context

    @State private var newJournalContent = ""
    @State private var newDate = Date.now
    
    var body: some View {
        NavigationStack {
            List(entries, id: \.date) { entry in
                HStack {
                    Text(entry.content)
                    Spacer()
                    Text(entry.date, format: .dateTime.month(.wide).day().year())
                    
                }
            }
            .navigationTitle("Journals")
            .safeAreaInset(edge:.bottom) {
                VStack(alignment: .center, spacing: 10) {
                    Text("New Journal Entry")
                        .font(.headline)
                    TextField("How are you feeling...", text: $newJournalContent)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    Button("Save") {
                        let newEntry = JournalEntry(date: .now, content: newJournalContent)
                        context.insert(newEntry)
                        
                        newJournalContent = ""
                        newDate = .now
                    }
                    .bold()
                }
                .padding()
                .background(.bar)
            }

        }
    }
}


#Preview {
    JournalView()
}
