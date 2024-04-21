import React from 'react';

const NavbarPatient = () => {
  const handleLogout = () => {
    // Add logout logic here, e.g., redirect to the main page
    window.location.href = 'main.html'; // Assuming main.html is the logout page
  };

  return (
    <nav className="navbar">
      <div className="logo">RecovR</div>
      <div className="nav-items">
        <button className="login-btn" onClick={handleLogout}>Log Out</button>
      </div>
    </nav>
  );
};

export default NavbarPatient;
