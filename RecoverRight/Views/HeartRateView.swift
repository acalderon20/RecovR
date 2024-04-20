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
        VStack {
            if !viewModel.weeklyHeartRates.isEmpty {
                Chart {
                    RuleMark(y: .value("Threshhold", 100))
                        .foregroundStyle(.red)
                    ForEach(Array(viewModel.weeklyHeartRates.enumerated()), id: \.offset) { index, rate in
                        LineMark(
                            x: .value("Day", index),
                            y: .value("Heart Rate", rate)
                        )
                        .interpolationMethod(.catmullRom) // Smooths the line

                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom)) // prettify the data
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .automatic) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel("\(value.as(Double.self)!, specifier: "%.0f")")
                    }
                }
                .chartYAxis {
                    AxisMarks(values: .automatic) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel("\(value.as(Double.self)!, specifier: "%.0f")")
                    }
                }
                .frame(height: 300)
                .padding()
            } else {
                Text("Fetching data...")
            }
            
            if viewModel.showAlert {
                Text("Heart Rate has reached over 100bpm!")
                    .foregroundColor(.red)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
            }
        }
        .onAppear {
            viewModel.fetchWeeklyHeartRates()
        }
    }
}



#Preview {
    HeartRateView()
}
