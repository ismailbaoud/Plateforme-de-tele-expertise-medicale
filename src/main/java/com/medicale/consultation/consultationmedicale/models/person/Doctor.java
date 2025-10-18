package com.medicale.consultation.consultationmedicale.models.person;

import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.enums.Speciality;
import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "doctors")
@DiscriminatorValue("DOCTOR")
public class Doctor extends Person {

    @Enumerated(EnumType.STRING)
    @Column(name = "speciality")
    private Speciality speciality;

    @Column(name = "license_number", unique = true)
    private String licenseNumber;

    @Column(name = "office_number")
    private String officeNumber;

    public Doctor() {
        super();
    }

    public Doctor(Long id, String firstName, String lastName, String username, String password, String phone, Gender gender, LocalDate createdAt, Role role) {
        super(id, firstName, lastName, username, password, phone, gender, createdAt, role);
    }

    public Speciality getSpeciality() {
        return speciality;
    }

    public void setSpeciality(Speciality speciality) {
        this.speciality = speciality;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public String getOfficeNumber() {
        return officeNumber;
    }

    public void setOfficeNumber(String officeNumber) {
        this.officeNumber = officeNumber;
    }
}
