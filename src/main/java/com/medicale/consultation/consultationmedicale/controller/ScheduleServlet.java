package com.medicale.consultation.consultationmedicale.controller;

import com.medicale.consultation.consultationmedicale.enums.SlotStatus;
import com.medicale.consultation.consultationmedicale.models.ScheduleSlot;
import com.medicale.consultation.consultationmedicale.models.person.Person;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import com.medicale.consultation.consultationmedicale.service.ScheduleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;

import java.io.IOException;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@WebServlet("/specialist/schedule")
public class ScheduleServlet extends BaseServlet {

    private final ScheduleService scheduleService = new ScheduleService();

    public void index(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Person user = (Person) req.getSession().getAttribute("user");
            if (user == null || !(user instanceof Specialist)) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
                return;
            }

            Specialist specialist = (Specialist) user;
            List<ScheduleSlot> scheduleSlots = scheduleService.findAll().stream()
                    .filter(s -> s.getSpecialist().getId().equals(specialist.getId()))
                    .toList();

            System.out.println("Loading schedule for specialist ID: " + specialist.getId());
            System.out.println("Found " + scheduleSlots.size() + " slots");

            req.setAttribute("scheduleSlots", scheduleSlots);
            view(req, resp, "schedule.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error in index: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors du chargement du planning");
        }
    }

    public void save(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Person user = (Person) req.getSession().getAttribute("user");
            if (user == null || !(user instanceof Specialist)) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
                return;
            }

            Specialist specialist = (Specialist) user;
            String slotsJson = req.getParameter("selectedSlots");

            System.out.println("=== SCHEDULE SAVE DEBUG ===");
            System.out.println("Specialist ID: " + specialist.getId());
            System.out.println("Selected Slots JSON: " + slotsJson);

            ObjectMapper mapper = new ObjectMapper();
            List<Map<String, String>> selectedSlots = slotsJson != null && !slotsJson.isEmpty()
                    ? mapper.readValue(slotsJson, new TypeReference<List<Map<String, String>>>() {})
                    : List.of();

            System.out.println("Parsed " + selectedSlots.size() + " selected slots");

            // Fetch all existing slots for this specialist
            List<ScheduleSlot> existingSlots = scheduleService.findAll().stream()
                    .filter(s -> s.getSpecialist().getId().equals(specialist.getId()))
                    .toList();

            System.out.println("Found " + existingSlots.size() + " existing slots for this specialist");

            // Build key sets for comparison
            Set<String> selectedKeys = selectedSlots.stream()
                    .map(s -> s.get("day") + "_" + s.get("time"))
                    .collect(Collectors.toSet());

            Set<String> existingKeys = existingSlots.stream()
                    .filter(s -> s.getStatus() != SlotStatus.RESERVED)
                    .map(s -> s.getDay() + "_" + s.getTime().toString())
                    .collect(Collectors.toSet());

            // Add new slots
            int addedCount = 0;
            for (Map<String, String> slotMap : selectedSlots) {
                String key = slotMap.get("day") + "_" + slotMap.get("time");
                if (!existingKeys.contains(key)) {
                    ScheduleSlot newSlot = new ScheduleSlot();
                    newSlot.setDay(Integer.parseInt(slotMap.get("day")));
                    newSlot.setTime(LocalTime.parse(slotMap.get("time")));
                    newSlot.setSpecialist(specialist);
                    newSlot.setStatus(SlotStatus.BLOCKED);
                    scheduleService.save(newSlot);
                    addedCount++;
                    System.out.println("Added slot: " + key);
                }
            }

            // Remove unchecked slots (BLOCKED only, never RESERVED)
            int removedCount = 0;
            for (ScheduleSlot existing : existingSlots) {
                String key = existing.getDay() + "_" + existing.getTime().toString();
                if (!selectedKeys.contains(key) && existing.getStatus() != SlotStatus.RESERVED) {
                    scheduleService.delete(existing);
                    removedCount++;
                    System.out.println("Removed slot: " + key);
                }
            }

            System.out.println("Added: " + addedCount + ", Removed: " + removedCount);
            System.out.println("=== END DEBUG ===");

            resp.sendRedirect(req.getContextPath() + "/specialist/schedule");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error saving schedule: " + e.getMessage(), e);
        }
    }
}
