import React from 'react';
import './PatientPage.css'; 

import NavbarPatient from '../components/PatientInfo/NavbarPatient';
import HeartRate from '../components/PatientInfo/HeartRate';
import RecoveryJournal from '../components/PatientInfo/RecoveryJournal';
import MedicationList from '../components/PatientInfo/Medication';
import Footer from '../components/FootNote';
import PatientProfile from '../components/PatientInfo/PatientProfile';
import PatientMessage from '../components/PatientInfo/PatientMessage';
const PatientPage = () => {
    return (
      <div>
        <NavbarPatient /> 
        <PatientProfile />
        <HeartRate />
        <RecoveryJournal />
        <MedicationList />
        <PatientMessage />
        <Footer />
        {/* Other content of the home page */}
      </div>
    );
  };


  export default PatientPage;
