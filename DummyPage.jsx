import React from 'react';
import { Link } from 'react-router-dom';

const DummyPage = () => {
  return (
    <div>
      <h1>Dummy Page</h1>
      <p>This is a dummy page for testing redirection.</p>
      {/* Link to navigate to another page */}
      <Link to="/redirected-page" className="btn">
        Go to Redirected Page
      </Link>
    </div>
  );
};

export default DummyPage;
