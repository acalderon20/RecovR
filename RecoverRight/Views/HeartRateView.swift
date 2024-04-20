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
                    ForEach(Array(viewModel.weeklyHeartRates.enumerated()), id: \.offset) { index, rate in
                        LineMark(
                            x: .value("Day", index),
                            y: .value("Heart Rate", rate)
                        )
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .automatic) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel("\(value.as(Double.self)!, specifier: "%.0f")") // Explicit string format
                    }
                }
                .chartYAxis {
                    AxisMarks(values: .automatic) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel("\(value.as(Double.self)!, specifier: "%.0f")") // Explicit string format
                    }
                }
                .frame(height: 300)
                .padding()
            } else {
                Text("Fetching data...")
            }
            
            if viewModel.showAlert {
                Text("Warning: Heart Rate has reached over 100bpm!")
                    .foregroundColor(.red)
                    .padding()
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
