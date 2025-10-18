package com.medicale.consultation.consultationmedicale.models.consultation;

import com.medicale.consultation.consultationmedicale.enums.ConsultationStatus;
import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.ScheduleSlot;
import com.medicale.consultation.consultationmedicale.models.person.Generalist;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "consultations")
public class Consultation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, name = "created_at")
    private LocalDateTime createdAt;

    @Column(nullable = false)
    private String reason;

    @Column(columnDefinition = "TEXT")
    private String symptoms;

    @Column(columnDefinition = "TEXT")
    private String clinicalExam;

    @Column(columnDefinition = "TEXT")
    private String observations;

    @Column(columnDefinition = "TEXT")
    private String diagnosis;

    @Column(columnDefinition = "TEXT")
    private String treatmentPlan;

    @Column(columnDefinition = "TEXT")
    private String expertOpinion;

    @Column(columnDefinition = "TEXT")
    private String recommendations;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, name = "consultation_status")
    private ConsultationStatus consultationStatus;

    @ManyToOne
    @JoinColumn(name = "medical_file_id", nullable = false)
    private MedicaleFile medicalFile;

    @OneToMany(mappedBy = "consultation", cascade = CascadeType.ALL)
    private List<MedicaleAct> medicaleActs = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "generalist_id")
    private Generalist generalist;

    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;

    @OneToOne(mappedBy = "consultation", fetch = FetchType.LAZY)
    private ScheduleSlot scheduleSlot;

    public Consultation(Long id, LocalDateTime createdAt, ConsultationStatus consultationStatus, String reason, Patient patient, MedicaleFile medicalFile) {
        this.id = id;
        this.createdAt = createdAt;
        this.consultationStatus = consultationStatus;
        this.reason = reason;
        this.patient = patient;
        this.medicalFile = medicalFile;
    }

    public Consultation() {
        this.createdAt = LocalDateTime.now();
        this.consultationStatus = ConsultationStatus.PENDING;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public ConsultationStatus getConsultationStatus() {
        return consultationStatus;
    }

    public ConsultationStatus getStatus() {
        return consultationStatus;
    }

    public void setConsultationStatus(ConsultationStatus consultationStatus) {
        this.consultationStatus = consultationStatus;
    }

    public MedicaleFile getMedicalFile() {
        return medicalFile;
    }

    public void setMedicalFile(MedicaleFile medicalFile) {
        this.medicalFile = medicalFile;
    }

    public List<MedicaleAct> getMedicaleActs() {
        return medicaleActs;
    }

    public void setMedicaleActs(List<MedicaleAct> medicaleActs) {
        this.medicaleActs = medicaleActs;
    }

    public Generalist getGeneralist() {
        return generalist;
    }

    public void setGeneralist(Generalist generalist) {
        this.generalist = generalist;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(String symptoms) {
        this.symptoms = symptoms;
    }

    public String getClinicalExam() {
        return clinicalExam;
    }

    public void setClinicalExam(String clinicalExam) {
        this.clinicalExam = clinicalExam;
    }

    public String getObservations() {
        return observations;
    }

    public void setObservations(String observations) {
        this.observations = observations;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getTreatmentPlan() {
        return treatmentPlan;
    }

    public void setTreatmentPlan(String treatmentPlan) {
        this.treatmentPlan = treatmentPlan;
    }

    public String getExpertOpinion() {
        return expertOpinion;
    }

    public void setExpertOpinion(String expertOpinion) {
        this.expertOpinion = expertOpinion;
    }

    public String getRecommendations() {
        return recommendations;
    }

    public void setRecommendations(String recommendations) {
        this.recommendations = recommendations;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public ScheduleSlot getScheduleSlot() {
        return scheduleSlot;
    }

    public void setScheduleSlot(ScheduleSlot scheduleSlot) {
        this.scheduleSlot = scheduleSlot;
    }
}