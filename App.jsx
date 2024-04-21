import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import HomePage from './pages/HomePage';
import PatientPage from './pages/PatientPage.jsx';
import DoctorPage from './pages/DoctorPage.jsx';
import NotFoundPage from './pages/NotFoundPage.jsx';
import AuthPage from './pages/AuthPage.jsx';
// ... other component imports ...





function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/pages/AuthPage/" element={<AuthPage />} />
        <Route path="/pages/PatientPage/:id" element={<PatientPage />} />
        <Route path="/pages/DoctorPage" element={<DoctorPage />} />
        <Route path="*" element={<NotFoundPage />} /> {/* Handle 404 routes */}
        {/* Define other routes here */}
      </Routes>
    </Router>
  );
}

export default App;