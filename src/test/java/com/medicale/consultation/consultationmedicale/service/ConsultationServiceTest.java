package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.repositories.ConsultationRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class ConsultationServiceTest {
    private ConsultationRepository consultationRepository;
    private ConsultationService consultationService;
    private Consultation testConsultation;

    @BeforeEach
    void setUp() {
        consultationRepository = mock(ConsultationRepository.class);
        consultationService = new ConsultationService(consultationRepository);
        testConsultation = new Consultation();
        testConsultation.setId(1L);
    }

    @Test
    void testSave() {
        // Préparation
        when(consultationRepository.save(any(Consultation.class))).thenReturn(testConsultation);

        // Exécution
        Consultation result = consultationService.save(new Consultation());

        // Vérification
        assertNotNull(result);
        assertEquals(1L, result.getId());
        verify(consultationRepository).save(any(Consultation.class));
    }

    @Test
    void testFindById() {
        // Préparation
        when(consultationRepository.findById(1L)).thenReturn(testConsultation);

        // Exécution
        Consultation result = consultationService.findById(1L);

        // Vérification
        assertNotNull(result);
        assertEquals(1L, result.getId());
        verify(consultationRepository).findById(1L);
    }

    @Test
    void testFindById_NotFound() {
        // Préparation
        when(consultationRepository.findById(2L)).thenReturn(null);

        // Exécution
        Consultation result = consultationService.findById(2L);

        // Vérification
        assertNull(result);
        verify(consultationRepository).findById(2L);
    }
}
