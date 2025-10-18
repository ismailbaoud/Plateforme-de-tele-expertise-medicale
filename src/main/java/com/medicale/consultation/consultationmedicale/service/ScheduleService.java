package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.ScheduleSlot;
import com.medicale.consultation.consultationmedicale.repositories.ScheduleRepository;

import java.util.List;

public class ScheduleService {
    private final ScheduleRepository scheduleRepository;

    public ScheduleService() {
        this.scheduleRepository = new ScheduleRepository();
    }

    public List<ScheduleSlot> findAll() {
        return scheduleRepository.findAll();
    }

    public ScheduleSlot save(ScheduleSlot scheduleSlot) {
        return scheduleRepository.save(scheduleSlot);
    }

    public void delete(ScheduleSlot scheduleSlot) {
        scheduleRepository.delete(scheduleSlot);
    }
}
