-- إنشاء قاعدة البيانات
CREATE DATABASE IF NOT EXISTS SmartClinic;
USE SmartClinic;

-- 1. جدول Person
CREATE TABLE Person (
    PersonID INT AUTO_INCREMENT PRIMARY KEY,
    NationalID VARCHAR(20) NOT NULL UNIQUE,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(10),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(255)
);

-- 2. جدول Patient
CREATE TABLE Patient (
    PersonID INT PRIMARY KEY,
    DateOfBirth DATE NOT NULL,
    BloodType VARCHAR(5),
    EmergencyContact VARCHAR(20),
    InsuranceProvider VARCHAR(100),
    InsuranceNumber VARCHAR(50),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID) ON DELETE CASCADE
);

-- 3. جدول Branch
CREATE TABLE Branch (
    BranchID INT AUTO_INCREMENT PRIMARY KEY,
    BranchName VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255) NOT NULL,
    OpeningTime TIME,
    ClosingTime TIME
);

-- 4. جدول Doctor
CREATE TABLE Doctor (
    PersonID INT PRIMARY KEY,
    LicenseNumber VARCHAR(50) NOT NULL UNIQUE,
    Specialization VARCHAR(100) NOT NULL,
    HireDate DATE,
    YearsOfExperience INT,
    ConsultationFee DECIMAL(10,2),
    BranchID INT NOT NULL,
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID) ON DELETE CASCADE,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID) ON DELETE CASCADE
);

-- 5. جدول Appointment
CREATE TABLE Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentType VARCHAR(30) NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Reason VARCHAR(255),
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patient(PersonID) ON DELETE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctor(PersonID) ON DELETE CASCADE
);

-- 6. جدول Treatment
CREATE TABLE Treatment (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT NOT NULL,
    TreatmentName VARCHAR(100) NOT NULL,
    Description TEXT,
    Cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID) ON DELETE CASCADE
);

-- 7. جدول Prescription
CREATE TABLE Prescription (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT NOT NULL UNIQUE,
    PrescriptionDate DATE NOT NULL,
    Notes TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID) ON DELETE CASCADE
);

-- 8. جدول Medicine
CREATE TABLE Medicine (
    MedicineID INT AUTO_INCREMENT PRIMARY KEY,
    MedicineName VARCHAR(100) NOT NULL UNIQUE,
    Manufacturer VARCHAR(100),
    UnitPrice DECIMAL(10,2) NOT NULL
);

-- 9. جدول PrescriptionDetail
CREATE TABLE PrescriptionDetail (
    PrescriptionDetailID INT AUTO_INCREMENT PRIMARY KEY,
    PrescriptionID INT NOT NULL,
    MedicineID INT NOT NULL,
    Dosage VARCHAR(50) NOT NULL,
    Frequency VARCHAR(50) NOT NULL,
    Duration VARCHAR(50) NOT NULL,
    UNIQUE (PrescriptionID, MedicineID),
    FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID) ON DELETE CASCADE,
    FOREIGN KEY (MedicineID) REFERENCES Medicine(MedicineID) ON DELETE CASCADE
);

-- 10. جدول Payment
CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT NOT NULL UNIQUE,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL,
    PaymentDate DATE,
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID) ON DELETE CASCADE
);