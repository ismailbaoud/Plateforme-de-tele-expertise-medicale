package com.medicale.consultation.consultationmedicale.models;

import com.medicale.consultation.consultationmedicale.enums.SlotStatus;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "schedule_slots")
public class ScheduleSlot {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private int day;

    @Column(nullable = false)
    private LocalTime time;

    @Column(name = "status")
    private SlotStatus status ;

    @ManyToOne
    @JoinColumn(name = "specialist_id", nullable = false)
    private Specialist specialist;

    @OneToOne
    @JoinColumn(name = "consultation_id")
    private Consultation consultation;


    // getters & setters
    public Long getId() { return id; }
    public int getDay() { return day; }
    public void setDay(int day) { this.day = day; }
    public LocalTime getTime() { return time; }
    public void setTime(LocalTime time) { this.time = time; }
    public Specialist getSpecialist() { return specialist; }
    public void setSpecialist(Specialist specialist) { this.specialist = specialist; }
    public SlotStatus getStatus() {
        return status;
    }
    public void setStatus(SlotStatus status) {
        this.status = status;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Consultation getConsultation() {
        return consultation;
    }

    public void setConsultation(Consultation consultation) {
        this.consultation = consultation;
    }
}
