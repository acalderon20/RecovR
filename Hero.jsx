import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { auth } from "../config/firebase";

function Hero() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  useEffect(() => {
    const unsubscribe = auth.onAuthStateChanged((user) => {
      if (user) {
        setIsLoggedIn(true);
      } else {
        setIsLoggedIn(false);
      }
    });

    return () => unsubscribe();
  }, []);

  return (
    <header className="hero">
      <h1>Welcome to RecovR!</h1>
      <p>Your personalized recovery guide.</p>
      {isLoggedIn ? (
        <Link to="../pages/DoctorPage" className="hero-btn">Get Started</Link>
      ) : (
        <Link to="../pages/AuthPage" className="hero-btn">Get Started</Link>
      )}
    </header>
  );
}

export default Hero;
