//
//  HeartRateView.swift
//  RecoverRight
//
//  Created by Adolfo Calderon on 4/20/24.
//

import SwiftUI

struct HeartRateView: View {
    @ObservedObject var viewModel = HeartRateViewModel()

    var body: some View {
        VStack {
            Text("Heart Rate: \(viewModel.heartRate) BPM")
                .padding()
            Button("Fetch Heart Rate") {
                viewModel.fetchHeartRate()
            }
        }
    }
}


#Preview {
    HeartRateView()
}
