package com.medicale.consultation.consultationmedicale.controller;

import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.controller.ConsultationServlet;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

class ConsultationServletTest {
    private ConsultationServlet servlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher requestDispatcher;

    @BeforeEach
    void setUp() {
        servlet = new ConsultationServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        requestDispatcher = mock(RequestDispatcher.class);
    }

    @Test
    void testIndex() throws Exception {
        // Préparation
        when(request.getParameter("patientId")).thenReturn("1");
        when(request.getRequestDispatcher(anyString())).thenReturn(requestDispatcher);

        // Exécution
        servlet.index(request, response);

        // Vérification
        verify(request).getRequestDispatcher(contains("consultation.jsp"));
        verify(requestDispatcher).forward(request, response);
    }

    @Test
    void testCreate() throws Exception {
        // Préparation
        when(request.getParameter("patientId")).thenReturn("1");
        when(request.getParameter("reason")).thenReturn("Test reason");
        when(request.getParameter("status")).thenReturn("PENDING");

        // Exécution
        servlet.create(request, response);

        // Vérification
        verify(response).sendRedirect(contains("/medicalFiles"));
    }

    @Test
    void testServletInstantiation() {
        assertNotNull(servlet);
    }
}
