-- =====================================================
-- Task 3: SQL Operations - Smart Clinic Database System
-- =====================================================

USE SmartClinic;


-- =====================================================
-- Query 1: JOIN
-- Purpose: Retrieve each patient's name, their assigned
-- doctor's name, and the date/time/status of the appointment.
-- =====================================================
SELECT 
    p.FirstName AS PatientFirstName,
    p.LastName AS PatientLastName,
    d_person.FirstName AS DoctorFirstName,
    d_person.LastName AS DoctorLastName,
    a.AppointmentDate,
    a.AppointmentTime,
    a.Status
FROM Appointment a
JOIN Patient pt ON a.PatientID = pt.PersonID
JOIN Person p ON pt.PersonID = p.PersonID
JOIN Doctor d ON a.DoctorID = d.PersonID
JOIN Person d_person ON d.PersonID = d_person.PersonID;


-- =====================================================
-- Query 2: Multi-table JOIN
-- Purpose: Retrieve full prescription details for each
-- patient, including the prescribed medicine, dosage,
-- frequency, and duration.
-- =====================================================
SELECT 
    p.FirstName AS PatientFirstName,
    p.LastName AS PatientLastName,
    pr.PrescriptionDate,
    m.MedicineName,
    pd.Dosage,
    pd.Frequency,
    pd.Duration
FROM Prescription pr
JOIN Appointment a ON pr.AppointmentID = a.AppointmentID
JOIN Patient pt ON a.PatientID = pt.PersonID
JOIN Person p ON pt.PersonID = p.PersonID
JOIN PrescriptionDetail pd ON pr.PrescriptionID = pd.PrescriptionID
JOIN Medicine m ON pd.MedicineID = m.MedicineID;


-- =====================================================
-- Query 3: GROUP BY with Aggregate Functions
-- Purpose: Calculate the total number of appointments and
-- total payments received per doctor, ordered from highest
-- to lowest total payments.
-- =====================================================
SELECT 
    d_person.FirstName AS DoctorFirstName,
    d_person.LastName AS DoctorLastName,
    COUNT(a.AppointmentID) AS TotalAppointments,
    SUM(pay.Amount) AS TotalPayments
FROM Doctor d
JOIN Person d_person ON d.PersonID = d_person.PersonID
JOIN Appointment a ON a.DoctorID = d.PersonID
JOIN Payment pay ON pay.AppointmentID = a.AppointmentID
GROUP BY d.PersonID, d_person.FirstName, d_person.LastName
ORDER BY TotalPayments DESC;


-- =====================================================
-- Query 4: Nested Query
-- Purpose: Identify doctors whose consultation fee is
-- higher than the average consultation fee across all doctors.
-- =====================================================
SELECT 
    d_person.FirstName,
    d_person.LastName,
    d.ConsultationFee
FROM Doctor d
JOIN Person d_person ON d.PersonID = d_person.PersonID
WHERE d.ConsultationFee > (
    SELECT AVG(ConsultationFee) FROM Doctor
);


-- =====================================================
-- Query 5: UPDATE
-- Purpose: Update the status of past appointments that are
-- still marked as "Scheduled" to "Completed".
-- Note: SQL_SAFE_UPDATES is disabled temporarily since the
-- WHERE clause does not filter by primary key.
-- =====================================================
SET SQL_SAFE_UPDATES = 0;

UPDATE Appointment
SET Status = 'Completed'
WHERE AppointmentDate < '2026-08-03' AND Status = 'Scheduled';

-- Verification query
SELECT AppointmentID, AppointmentDate, Status 
FROM Appointment 
WHERE AppointmentID = 2;


-- =====================================================
-- Query 6: VIEW
-- Purpose: Create a reusable view that shows all upcoming
-- (still "Scheduled") appointments with patient and doctor
-- details, so this data can be queried directly without
-- rewriting the full JOIN each time.
-- =====================================================
CREATE VIEW UpcomingAppointmentsView AS
SELECT 
    p.FirstName AS PatientName,
    p.LastName AS PatientLastName,
    d_person.FirstName AS DoctorName,
    d_person.LastName AS DoctorLastName,
    a.AppointmentDate,
    a.AppointmentTime,
    a.Status
FROM Appointment a
JOIN Patient pt ON a.PatientID = pt.PersonID
JOIN Person p ON pt.PersonID = p.PersonID
JOIN Doctor d ON a.DoctorID = d.PersonID
JOIN Person d_person ON d.PersonID = d_person.PersonID
WHERE a.Status = 'Scheduled';

-- Verification query
SELECT * FROM UpcomingAppointmentsView;


-- =====================================================
-- Query 7: TRIGGER
-- Purpose: Automatically update an appointment's status to
-- "Completed" whenever a payment for that appointment is
-- inserted with a "Paid" status, removing the need for
-- manual status updates after payment.
-- =====================================================
DELIMITER $$

CREATE TRIGGER UpdateAppointmentAfterPayment
AFTER INSERT ON Payment
FOR EACH ROW
BEGIN
    IF NEW.PaymentStatus = 'Paid' THEN
        UPDATE Appointment
        SET Status = 'Completed'
        WHERE AppointmentID = NEW.AppointmentID;
    END IF;
END$$

DELIMITER ;

-- Test: insert a new appointment, then a payment for it,
-- and verify the trigger updates its status automatically.
INSERT INTO Appointment (PatientID, DoctorID, AppointmentType, AppointmentDate, AppointmentTime, Status, Reason)
VALUES (1, 7, 'Follow-up', '2026-08-10', '10:00:00', 'Scheduled', 'Trigger test appointment');

INSERT INTO Payment (AppointmentID, Amount, PaymentMethod, PaymentStatus, PaymentDate)
VALUES (6, 300.00, 'Cash', 'Paid', '2026-08-10');

-- Verification query: Status should show 'Completed' automatically
SELECT AppointmentID, Status FROM Appointment WHERE AppointmentID = 6;
