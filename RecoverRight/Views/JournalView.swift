//
//  JournalView.swift
//  RecoverRight
//
//  Created by Adolfo Calderon on 4/20/24.
//

import SwiftUI
import SwiftData

struct JournalView: View {
    @Query var entries: [JournalEntry]
    @Environment(\.modelContext) private var context
    
    @State private var newJournalContent = ""
    @State private var showNewEntryView = false

    var body: some View {
        VStack{
            NavigationStack {
                List(entries, id: \.id) { entry in
                    Button(action: {
                        // Action to view detailed journal entry
                    }) {
                        HStack {
                            Text(entry.content)
                                .lineLimit(1)
                            Spacer()
                            Text(entry.date, format: .dateTime.month(.abbreviated).day().year())
                        }
                    }
                }
                .navigationTitle("Journal")
                .sheet(isPresented: $showNewEntryView) {
                    NewJournalEntryView(showNewEntryView: $showNewEntryView, newJournalContent: $newJournalContent)
                }
            }
            addButton
        }
    }
    
    private var addButton: some View {
        Button(action: {
            withAnimation {
                showNewEntryView = true
            }
        }) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70) // Set the size of the button
                .background(Circle() // Circle shape
                                .fill(Color.blue) // Fill color
                                .shadow(radius: 10)) // Add shadow for depth
                .foregroundColor(.white) // Icon color
                .overlay(Circle() // Add a pulse animation
                            .stroke(Color.blue, lineWidth: 2)
                            .scaleEffect(animate ? 1.3 : 1.0) // Scale effect based on animation state
                            .opacity(animate ? 0.0 : 1.0) // Fade out animation
                            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false), value: animate)
                )
        }
        .onAppear {
            animate.toggle() // Trigger animation when view appears
        }
        .padding()
    }
    @State private var animate = false
}

struct NewJournalEntryView: View {
    @Binding var showNewEntryView: Bool
    @Binding var newJournalContent: String
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationView {
            VStack {
                Text("New Journal Entry")
                    .font(.headline)
                    .padding()
                TextEditor(text: $newJournalContent)
                    .frame(minHeight: 200)
                    .border(Color.gray, width: 1)
                    .padding()
                Button("Save") {
                    let newEntry = JournalEntry(date: Date.now, content: newJournalContent)
                    context.insert(newEntry)
                    showNewEntryView = false
                    newJournalContent = ""
                }
                .bold()
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .navigationTitle("Add Entry")
            .navigationBarItems(leading: Button("Cancel") {
                showNewEntryView = false
            })
        }
    }
}


#Preview {
    JournalView()
}
