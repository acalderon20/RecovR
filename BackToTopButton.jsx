import React from 'react';

const BackToTopButton = () => {
  const scrollToTop = () => {
    window.scrollTo({
      top: 0,
      behavior: 'smooth',
    });
  };

  return (
    <a href="#top" className="back-to-top" aria-label="Scroll to Top" onClick={scrollToTop}>
      ↑
    </a>
  );
};

export default BackToTopButton;
