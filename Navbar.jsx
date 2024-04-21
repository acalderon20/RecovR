import React from 'react';
//import { login } from '../pages/Login.jsx'; // Import the login function

function Navbar() {
  return (
    <nav className="navbar">
      <div className="logo">RecovR</div>
      <div className="nav-items">
        <a href="#intro" className="nav-link">Intro</a>
        <a href="#about" className="nav-link">About</a>
        <a href="#features" className="nav-link">Features</a>
        <a href="#contact" className="nav-link">Contact</a>
        <button className="login-btn">Log In</button>
      </div>
    </nav>
  );
}

export default Navbar;