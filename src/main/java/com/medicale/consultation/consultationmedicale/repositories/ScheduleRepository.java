package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.ScheduleSlot;
import jakarta.persistence.EntityManager;

import java.util.List;

public class ScheduleRepository extends BaseRepository<ScheduleSlot> {

    public ScheduleRepository() {
        super(ScheduleSlot.class);
    }

    @Override
    public List<ScheduleSlot> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT s FROM ScheduleSlot s", ScheduleSlot.class).getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(ScheduleSlot scheduleSlot) {
        if (scheduleSlot != null && scheduleSlot.getId() != null) {
            super.delete(scheduleSlot.getId());
        }
    }
}
