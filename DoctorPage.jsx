import React from 'react';
import './DoctorPage.css'; 

import NavbarDoctor from '../components/DoctorInfo/NavbarDoctor';
import DoctorProfile from '../components/DoctorInfo/DoctorProfile';
import PatientsAssisted from '../components/DoctorInfo/PatientsAssisted';
import PatientsList from '../components/DoctorInfo/PatientList';
import FootNote from '../components/FootNote';
import BackToTopButton from '../components/BackToTopButton';

const DoctorPage = () => {
    return (
      <div>
        <NavbarDoctor />
        <DoctorProfile />
        <PatientsAssisted />
        <PatientsList />
        <FootNote />
        <BackToTopButton />
        {/* Other content of the home page */}
      </div>
    );
  };


  export default DoctorPage;
