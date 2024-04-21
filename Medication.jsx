import React from 'react';

const MedicationList = ({ medications }) => {
  // Check if medications object is provided and not empty
  if (!medications || Object.keys(medications).length === 0) {
    return <div className="medication">No medications available.</div>;
  }

  return (
    <div className="medication">
      <h2>Medication</h2>
      <ul>
        {Object.entries(medications).map(([date, medication], index) => (
          <li key={index}>
            <strong>{date}:</strong> {medication}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default MedicationList;
