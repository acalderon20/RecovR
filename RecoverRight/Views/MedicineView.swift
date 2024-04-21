//
//  MedicineView.swift
//  RecoverRight
//
//  Created by Adolfo Calderon on 4/20/24.
//

import SwiftUI
import UserNotifications

struct MedicineView: View {
    @State private var medicationName: String = ""
    @State private var timeToTakeMedicine = Date()
    @State private var medications: [Medication] = []

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("About Your Medication").font(.headline)) {
                    Text("Timely adherence to your medication schedule is crucial for effective treatment. Always follow the guidance provided by your healthcare professional.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Section(header: Text("Add Medication").font(.headline)) {
                    TextField("Enter Medication Name", text: $medicationName)
                    DatePicker("Select Time", selection: $timeToTakeMedicine, displayedComponents: .hourAndMinute)
                    
                    Button(action: addMedication) {
                        Text("Add Medication")
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(medicationName.isEmpty)
                }

                if !medications.isEmpty {
                    Section(header: Text("Current Medications").font(.headline)) {
                        ForEach(medications) { medication in
                            MedicationRow(medication: medication)
                        }
                        .onDelete(perform: removeMedications)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Medication Manager", displayMode: .inline)
        }
        .onAppear(perform: registerNotifications)
    }

    private func addMedication() {
        let newMedication = Medication(name: medicationName, time: timeToTakeMedicine)
        medications.append(newMedication)
        scheduleNotification(for: newMedication)
        medicationName = ""
        timeToTakeMedicine = Date()
    }

    private func removeMedications(at offsets: IndexSet) {
        medications.remove(atOffsets: offsets)
    }

    private func registerNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notifications granted")
            } else if let error = error {
                print("Notifications error: \(error.localizedDescription)")
            }
        }
    }
    
    private func scheduleNotification(for medication: Medication) {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Time to take your medication!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Please take your \(medication.name).", arguments: nil)
        content.sound = UNNotificationSound.default

        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: medication.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
             if let error = error {
                 print("Error scheduling notification: \(error.localizedDescription)")
             }
        }
    }
}

struct MedicationRow: View {
    var medication: Medication

    var body: some View {
        HStack {
            Text(medication.name)
            Spacer()
            Text(medication.time, style: .time)
        }
    }
}



#Preview {
    MedicineView()
}
