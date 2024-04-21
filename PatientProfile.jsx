import React from 'react';
import PropTypes from 'prop-types';

const PatientProfile = ({ patientName }) => {
    return (
        <header className="hero">
            <h1>{patientName}</h1>
            <p>Patient Profile</p>
        </header>
    );
};

PatientProfile.propTypes = {
    patientName: PropTypes.string.isRequired,
};

export default PatientProfile;
