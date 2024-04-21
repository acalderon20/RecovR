import React, { useEffect, useRef } from 'react';
import Chart from 'chart.js/auto'; // Import Chart.js library

const HeartRate = ({ heartRateData }) => {
  const chartRef = useRef(null); // Ref for the chart canvas
  const chartInstance = useRef(null); // Ref for the chart instance

  useEffect(() => {
    const heartRateChart = chartRef.current.getContext('2d');

    // Destroy previous chart instance if it exists
    if (chartInstance.current) {
      chartInstance.current.destroy();
    }

    // Create new chart instance
    chartInstance.current = new Chart(heartRateChart, {
      type: 'line',
      data: {
        labels: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7', 'Day 8'],
        datasets: [{
          label: 'Heart Rate',
          data: heartRateData,
          backgroundColor: 'rgba(0, 98, 230, 0.2)',
          borderColor: 'rgba(0, 98, 230, 0.8)',
          borderWidth: 1,
          pointRadius: 3,
          pointBackgroundColor: 'rgba(0, 98, 230, 0.8)',
          pointHoverRadius: 5,
        }]
      },
      options: {
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true,
            }
          }]
        }
      }
    });
  }, [heartRateData]); // Re-render chart when heartRateData changes

  return (
    <div className="patient-graph">
      <h2>Heart Rate Graph</h2>
      <div className="chart-container">
        <canvas id="heartRateChart" ref={chartRef}></canvas>
      </div>
    </div>
  );
};

export default HeartRate;
