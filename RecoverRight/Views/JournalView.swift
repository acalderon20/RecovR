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
    
    @State private var isMenuExpanded = false
    @State private var showingHeartRate = false
    @State private var showingMedicineView = false

    let gradient = LinearGradient(
        gradient: Gradient(colors: [.gradientTop, .gradientBottom]),
        startPoint: .top,
        endPoint: .bottom
    )

    var body: some View {
        NavigationView {
            ZStack {
                gradient.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(entries.reversed(), id: \.id) { entry in
                            JournalCardView(entry: entry)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.5)))
                                .shadow(radius: 2)
                        }
                    }
                    .padding(.top)
                    .navigationTitle("Journal")
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        addButton
                        if isMenuExpanded {
                            menuButtonItem(icon: "heart.fill", action: {
                                showingHeartRate = true
                                isMenuExpanded = false
                            })
                            .transition(.move(edge: .top).combined(with: .opacity))

                            menuButtonItem(icon: "pills.fill", action: {
                                showingMedicineView = true
                                isMenuExpanded = false
                            })
                            .transition(.move(edge: .top).combined(with: .opacity))
                        }
                        
                        menuButton
                    }
                }
            }
        }
        .sheet(isPresented: $showNewEntryView) {
            NewJournalEntryView(showNewEntryView: $showNewEntryView, newJournalContent: $newJournalContent)
        }
        .sheet(isPresented: $showingHeartRate) {
            HeartRateView()  // Ensure you have defined this view somewhere in your code
        }
        .sheet(isPresented: $showingMedicineView) {
            MedicineView()  // Ensure you have defined this view somewhere in your code
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
                .frame(width: 70, height: 70)
                .foregroundColor(.white)
                .background(Circle().fill(Color.blue).shadow(radius: 10))
        }
        .padding()
    }

    private var menuButton: some View {
        Button(action: {
            withAnimation {
                isMenuExpanded.toggle()
            }
        }) {
            Image(systemName: isMenuExpanded ? "chevron.down.circle.fill" : "chevron.up.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .shadow(radius: 10)
        }
        .padding(.trailing, 20)
    }

    private func menuButtonItem(icon: String, action: @escaping () -> Void) -> some View {
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(10)
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius: 4)
        }
    }
}

struct NewJournalEntryView: View {
    @Binding var showNewEntryView: Bool
    @Binding var newJournalContent: String
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationView {
            VStack {
                TextField("What are you feeling...", text: $newJournalContent)
                    .textFieldStyle(.plain)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.clear)
                Spacer()
            }
            .background(Color.white.opacity(0.4))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        saveEntry()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        showNewEntryView = false
                    }
                }
            }
        }
    }

    private func saveEntry() {
        let newEntry = JournalEntry(date: Date.now, content: newJournalContent)
        context.insert(newEntry)
        showNewEntryView = false
        newJournalContent = ""
    }
}
    
    private func getFormattedDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            return dateFormatter.string(from: Date())
}

struct JournalCardView: View {
    var entry: JournalEntry
    @State private var expanded = false  // State to track if the card is expanded

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(entry.content)
                .font(.body)
                .foregroundColor(.black)  // Ensure the text color is black
                .lineLimit(expanded ? nil : 3)  // Expand to show all text if expanded, otherwise show 3 lines.
                .animation(.easeInOut, value: expanded)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    expanded.toggle()  // Toggle expanded state when text is tapped
                }
            Divider()
            Text(entry.date, format: .dateTime.day().month().year())
                .font(.caption)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
        .padding(.horizontal)
    }
}


#Preview {
    JournalView()
}
