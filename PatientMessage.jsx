import React, { useState } from 'react';

const PatientMessage = () => {
  const [message, setMessage] = useState('');

  const handleMessageChange = (e) => {
    setMessage(e.target.value);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // You can send the message to Firebase here
    console.log('Message sent to Firebase:', message);
    // Reset the message input after sending
    setMessage('');
  };

  return (
    <div className="text-to-patient">
      <h2>Message to Patient</h2>
      <form onSubmit={handleSubmit}>
        <textarea
          rows="4"
          cols="50"
          placeholder="Write your message here..."
          value={message}
          onChange={handleMessageChange}
        ></textarea>
        <button type="submit" className="send-btn">
          Send
        </button>
      </form>
    </div>
  );
};

export default PatientMessage;
