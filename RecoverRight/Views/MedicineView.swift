//
//  MedicineView.swift
//  RecoverRight
//
//  Created by Adolfo Calderon on 4/20/24.
//

import SwiftUI
import UserNotifications
import SwiftData

struct MedicineView: View {
    @State private var medicationName: String = ""
    @State private var timeToTakeMedicine = Date()
    @State private var medications: [Medication] = []

    var body: some View {
        NavigationView {
            VStack {
                Text("Medication Reminder")
                    .font(.largeTitle)
                    .padding()

                Text("Consistent and timely medication helps maintain an effective treatment regimen. Always follow your physician's prescriptions carefully.")
                    .padding()
                    .font(.callout)
                    .multilineTextAlignment(.center)

                Form {
                    Section(header: Text("Add New Medication")) {
                        TextField("Medication Name", text: $medicationName)
                        DatePicker("Time to Take", selection: $timeToTakeMedicine, displayedComponents: .hourAndMinute)
                        Button("Add Medication") {
                            addMedication()
                        }
                    }

                    Section(header: Text("Your Medications")) {
                        ForEach(medications, id: \.id) { medication in
                            HStack {
                                Text(medication.name)
                                Spacer()
                                Text(medication.time, style: .time)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Manage Medications", displayMode: .inline)
        }
        .onAppear(perform: setupNotifications)
    }

    func addMedication() {
        let newMedication = Medication(name: medicationName, time: timeToTakeMedicine)
        medications.append(newMedication)
        scheduleNotification(for: newMedication)
        medicationName = ""
        timeToTakeMedicine = Date()
    }

    private func scheduleNotification(for medication: Medication) {
        let content = UNMutableNotificationContent()
        content.title = "Medication Reminder"
        content.body = "Time to take your \(medication.name)"
        content.sound = UNNotificationSound.default

        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: medication.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    private func setupNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notifications are allowed")
            } else if let error = error {
                print("Notification Error: \(error.localizedDescription)")
            }
        }
    }
}

@Model
class Medication: Identifiable {
    var id = UUID()
    var name: String
    var time: Date
    
    init(name: String , time: Date) {
        self.name = name
        self.time = time
        
    }
}


#Preview {
    MedicineView()
}
