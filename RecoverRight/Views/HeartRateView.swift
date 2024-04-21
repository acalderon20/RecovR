//
//  HeartRateView.swift
//  RecoverRight
//
//  Created by Adolfo Calderon on 4/20/24.
//

import SwiftUI
import Charts

struct HeartRateView: View {
    @ObservedObject var viewModel = HeartRateViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Heart Rate Monitor")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            Text("Keeping track of your heart rate is essential for detecting conditions such as tachycardia, especially important after surgical procedures. The line at 100 BPM acts as a guide to quickly identify any unusual increases in heart rate, helping you stay informed about your heart health.")
                .font(.subheadline)
                .padding([.leading, .trailing, .bottom])

            if !viewModel.weeklyHeartRates.isEmpty {
                Chart {
                    ForEach(Array(viewModel.weeklyHeartRates.enumerated()), id: \.offset) { index, rate in
                        LineMark(
                            x: .value("Day", index),
                            y: .value("Heart Rate", rate)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom))
                    }
                    RuleMark(y: .value("Threshold", 100))
                        .foregroundStyle(.red)
                        .annotation(position: .top, alignment: .trailing) {
                            Text("100 BPM Threshold")
                                .font(.caption)
                                .foregroundColor(.red)
                                .padding(.horizontal, 4)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(4)
                        }
                }
                .frame(height: 300)
                .padding(.horizontal)
            } else {
                Text("Fetching data...")
                    .frame(maxWidth: .infinity, alignment: .center)
            }

            let countOver100 = viewModel.weeklyHeartRates.filter { $0 > 100 }.count
            Text("This week, your heart rate went above 100 BPM \(countOver100) times.")
                .font(.callout)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .shadow(radius: 1)
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding()
        .onAppear {
            viewModel.fetchWeeklyHeartRates()
        }
    }
}



#Preview {
    HeartRateView()
}
