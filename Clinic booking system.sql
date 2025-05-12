
-- Drop existing tables if needed
DROP TABLE IF EXISTS PrescriptionMedication, Prescriptions, Appointments, Medications, Specializations, DoctorSpecializations, Doctors, Patients;

-- Patients Table
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15)
);

-- Doctors Table
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    LicenseNumber VARCHAR(50) UNIQUE NOT NULL
);

-- Specializations Table
CREATE TABLE Specializations (
    SpecializationID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE
);

-- Doctor-Specialization M-M Relationship
CREATE TABLE DoctorSpecializations (
    DoctorID INT,
    SpecializationID INT,
    PRIMARY KEY (DoctorID, SpecializationID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (SpecializationID) REFERENCES Specializations(SpecializationID)
);

-- Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Reason TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Prescriptions Table (1:1 with Appointments)
CREATE TABLE Prescriptions (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT UNIQUE NOT NULL,
    Notes TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Medications Table
CREATE TABLE Medications (
    MedicationID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Dosage VARCHAR(50)
);

-- Prescription-Medication M-M Table
CREATE TABLE PrescriptionMedication (
    PrescriptionID INT,
    MedicationID INT,
    Quantity INT,
    Instructions TEXT,
    PRIMARY KEY (PrescriptionID, MedicationID),
    FOREIGN KEY (PrescriptionID) REFERENCES Prescriptions(PrescriptionID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);
