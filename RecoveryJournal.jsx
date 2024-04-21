import React from 'react';

import PropTypes from 'prop-types';

const entriesExample = [
  {
    date: 'April 20, 2024',
    event: 'Started medication',
    description: 'Today, I started taking the prescribed medication. Feeling optimistic about the recovery process.',
  },
  {
    date: 'April 22, 2024',
    event: 'First Physical Therapy Session',
    description: 'Attended the first physical therapy session today. Feeling sore but hopeful that it will help speed up the recovery process.',
  },
  // Add more entries as needed
];

const RecoveryJournal = ({ entries }) => {
  // Check if entries are provided and not an empty array
  if (!entries || entries.length === 0) {
    return <div className="journal-entry">No journal entries available.</div>;
  }
  return (
    <div className="journal-entry">
      <h2>Journal Entry</h2>
      {entries.map((entry, index) => (
        <div className="entry" key={index}>
          <div className="entry-header">
            <div className="entry-date">{entry.date}</div>
            <div className="entry-event">{entry.event}</div>
          </div>
          <p>{entry.description}</p>
        </div>
      ))}
    </div>
  );
};


export default RecoveryJournal;
