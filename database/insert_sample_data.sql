USE SmartClinic;

-- إدخال 10 أشخاص (5 مرضى و 5 دكاترة)
INSERT INTO Person (NationalID, FirstName, LastName, Gender, Phone, Email, Address) VALUES
('1000000001', 'Ahmad', 'Al-Ghamdi', 'Male', '0501111111', 'ahmad@example.com', 'Riyadh, Olaya'),
('1000000002', 'Sara', 'Al-Qahtani', 'Female', '0502222222', 'sara@example.com', 'Jeddah, Al-Safa'),
('1000000003', 'Fahad', 'Al-Dosari', 'Male', '0503333333', 'fahad@example.com', 'Dammam, Al-Faisaliyah'),
('1000000004', 'Noura', 'Al-Otaibi', 'Female', '0504444444', 'noura@example.com', 'Mecca, Al-Awali'),
('1000000005', 'Omar', 'Al-Shehri', 'Male', '0505555555', 'omar@example.com', 'Khobar, Al-Aqrabiya'),
('2000000001', 'Khalid', 'Al-Saud', 'Male', '0551111111', 'dr.khalid@clinic.com', 'Riyadh, Malaz'),
('2000000002', 'Maha', 'Al-Harbi', 'Female', '0552222222', 'dr.maha@clinic.com', 'Jeddah, Rawdah'),
('2000000003', 'Yasser', 'Al-Mutairi', 'Male', '0553333333', 'dr.yasser@clinic.com', 'Dammam, Al-Rayan'),
('2000000004', 'Reem', 'Al-Juhani', 'Female', '0554444444', 'dr.reem@clinic.com', 'Riyadh, Narjis'),
('2000000005', 'Tariq', 'Al-Zahrani', 'Male', '0555555555', 'dr.tariq@clinic.com', 'Jeddah, Al-Zahra');

-- إدخال 5 فروع للعيادة
INSERT INTO Branch (BranchName, Phone, Address, OpeningTime, ClosingTime) VALUES
('Riyadh Main Branch', '011111111', 'Riyadh, King Fahd Rd', '08:00:00', '22:00:00'),
('Jeddah Branch', '012222222', 'Jeddah, King Abdulaziz Rd', '09:00:00', '21:00:00'),
('Dammam Branch', '013333333', 'Dammam, Prince Mohammad Rd', '08:00:00', '20:00:00'),
('Mecca Branch', '014444444', 'Mecca, Ibrahim Al-Khalil St', '10:00:00', '23:00:00'),
('Khobar Branch', '015555555', 'Khobar, Corniche Rd', '09:00:00', '21:00:00');

-- إدخال بيانات الـ 5 مرضى
INSERT INTO Patient (PersonID, DateOfBirth, BloodType, EmergencyContact, InsuranceProvider, InsuranceNumber) VALUES
(1, '1990-05-15', 'O+', '0509999991', 'Bupa', 'B-1001'),
(2, '1985-11-22', 'A-', '0509999992', 'Tawuniya', 'T-2002'),
(3, '1995-03-10', 'B+', '0509999993', 'Medgulf', 'M-3003'),
(4, '2000-07-25', 'AB+', '0509999994', 'Bupa', 'B-4004'),
(5, '1988-12-05', 'O-', '0509999995', 'Malath', 'ML-5005');

-- إدخال بيانات الـ 5 دكاترة
INSERT INTO Doctor (PersonID, LicenseNumber, Specialization, HireDate, YearsOfExperience, ConsultationFee, BranchID) VALUES
(6, 'LIC-001', 'General Practice', '2015-06-01', 11, 150.00, 1),
(7, 'LIC-002', 'Pediatrics', '2018-03-15', 8, 200.00, 2),
(8, 'LIC-003', 'Cardiology', '2010-11-20', 15, 350.00, 3),
(9, 'LIC-004', 'Dermatology', '2020-01-10', 6, 250.00, 1),
(10, 'LIC-005', 'Orthopedics', '2012-08-05', 13, 300.00, 5);

-- إدخال 5 مواعيد
INSERT INTO Appointment (PatientID, DoctorID, AppointmentType, AppointmentDate, AppointmentTime, Status, Reason, Notes) VALUES
(1, 6, 'Consultation', '2026-08-01', '10:00:00', 'Completed', 'Routine checkup', 'Patient is healthy'),
(2, 7, 'Follow-up', '2026-08-02', '11:30:00', 'Scheduled', 'Fever and cough', 'Needs blood test'),
(3, 8, 'Consultation', '2026-08-03', '14:00:00', 'Completed', 'Chest pain', 'ECG required'),
(4, 9, 'Consultation', '2026-08-04', '16:15:00', 'Cancelled', 'Skin allergy', 'Patient requested reschedule'),
(5, 10, 'Follow-up', '2026-08-05', '09:00:00', 'Scheduled', 'Knee pain', 'X-Ray recommended');

-- إدخال 5 علاجات
INSERT INTO Treatment (AppointmentID, TreatmentName, Description, Cost) VALUES
(1, 'General Checkup', 'Basic physical examination', 150.00),
(2, 'Fever Treatment', 'Prescribed antibiotics and rest', 100.00),
(3, 'ECG Test', 'Electrocardiogram to check heart rhythm', 250.00),
(4, 'Allergy Relief', 'Topical creams and antihistamines', 120.00),
(5, 'Joint Assessment', 'Physical evaluation of knee joint', 180.00);

-- إدخال 5 وصفات طبية
INSERT INTO Prescription (AppointmentID, PrescriptionDate, Notes) VALUES
(1, '2026-08-01', 'Take vitamins daily'),
(2, '2026-08-02', 'Complete the full course of antibiotics'),
(3, '2026-08-03', 'Take medication after meals'),
(4, '2026-08-04', 'Apply cream twice a day'),
(5, '2026-08-05', 'Use painkillers only when needed');

-- إدخال 5 أدوية
INSERT INTO Medicine (MedicineName, Manufacturer, UnitPrice) VALUES
('Paracetamol 500mg', 'Panadol', 15.50),
('Amoxicillin 250mg', 'PharmaCare', 45.00),
('Vitamin C', 'Jamieson', 30.00),
('Hydrocortisone Cream', 'DermaHealth', 55.00),
('Ibuprofen 400mg', 'Advil', 25.00);

-- إدخال 5 تفاصيل للوصفات الطبية
INSERT INTO PrescriptionDetail (PrescriptionID, MedicineID, Dosage, Frequency, Duration) VALUES
(1, 3, '1 Tablet', 'Once a day', '30 Days'),
(2, 2, '1 Capsule', 'Every 8 hours', '7 Days'),
(3, 1, '1 Tablet', 'Every 6 hours', '3 Days'),
(4, 4, 'Thin layer', 'Twice a day', '14 Days'),
(5, 5, '1 Tablet', 'When necessary', '5 Days');

-- إدخال 5 عمليات دفع
INSERT INTO Payment (AppointmentID, Amount, PaymentMethod, PaymentStatus, PaymentDate) VALUES
(1, 150.00, 'Card', 'Paid', '2026-08-01'),
(2, 200.00, 'Cash', 'Pending', NULL),
(3, 600.00, 'Insurance', 'Paid', '2026-08-03'),
(4, 0.00, 'Card', 'Refunded', '2026-08-04'),
(5, 300.00, 'Card', 'Paid', '2026-08-05');