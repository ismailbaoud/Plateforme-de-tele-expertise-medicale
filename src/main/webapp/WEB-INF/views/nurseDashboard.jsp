<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Person" %>
<%@ page import="com.medicale.consultation.consultationmedicale.enums.Role" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    Person user = (Person) session.getAttribute("user");
    Role role = (Role) session.getAttribute("role");
    if (user == null || role != Role.NURSE) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Infirmière - <%= user.getFirstName() %> <%= user.getLastName() %></title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Inter', sans-serif; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        .fade-in { animation: fadeIn 0.5s ease-out; }
        .card-hover { transition: all 0.3s ease; }
        .card-hover:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.15); }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 via-white to-cyan-50 min-h-screen">

    <!-- Header -->
    <nav class="bg-white shadow-lg border-b-4 border-blue-600">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-20">
                <div class="flex items-center gap-4">
                    <div class="w-12 h-12 bg-gradient-to-br from-blue-600 to-cyan-600 rounded-xl flex items-center justify-center shadow-lg">
                        <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                        </svg>
                    </div>
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900">Plateforme Infirmière</h1>
                        <p class="text-sm text-gray-600">Gestion des Patients & Tickets</p>
                    </div>
                </div>
                <div class="flex items-center gap-4">
                    <div class="text-right">
                        <p class="text-sm font-semibold text-gray-900"><%= user.getFirstName() %> <%= user.getLastName() %></p>
                        <p class="text-xs text-gray-600">Infirmière</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/login?action=logout"
                       class="px-4 py-2 bg-red-600 hover:bg-red-700 text-white rounded-lg font-semibold transition-colors">
                        Déconnexion
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Messages -->
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-6">
        <c:if test="${not empty successMessage}">
            <div class="bg-green-50 border-l-4 border-green-500 p-4 rounded-lg shadow-lg fade-in mb-4">
                <div class="flex items-center">
                    <svg class="w-6 h-6 text-green-500 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    <p class="text-green-800 font-semibold">${successMessage}</p>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="bg-red-50 border-l-4 border-red-500 p-4 rounded-lg shadow-lg fade-in mb-4">
                <div class="flex items-center">
                    <svg class="w-6 h-6 text-red-500 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    <p class="text-red-800 font-semibold">${error}</p>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">

        <!-- Statistics Cards -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="card-hover bg-gradient-to-br from-blue-500 to-blue-600 rounded-2xl shadow-xl p-6 text-white">
                <div class="flex justify-between items-start mb-4">
                    <div class="w-14 h-14 bg-white/20 rounded-xl flex items-center justify-center">
                        <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                        </svg>
                    </div>
                </div>
                <p class="text-4xl font-black mb-2">${totalPatients}</p>
                <p class="text-blue-100 font-medium">Total Patients</p>
            </div>

            <div class="card-hover bg-gradient-to-br from-green-500 to-green-600 rounded-2xl shadow-xl p-6 text-white">
                <div class="flex justify-between items-start mb-4">
                    <div class="w-14 h-14 bg-white/20 rounded-xl flex items-center justify-center">
                        <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                </div>
                <p class="text-4xl font-black mb-2">${activeTicketsCount}</p>
                <p class="text-green-100 font-medium">Tickets Actifs</p>
            </div>

            <div class="card-hover bg-gradient-to-br from-yellow-500 to-orange-500 rounded-2xl shadow-xl p-6 text-white">
                <div class="flex justify-between items-start mb-4">
                    <div class="w-14 h-14 bg-white/20 rounded-xl flex items-center justify-center">
                        <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z" />
                        </svg>
                    </div>
                </div>
                <p class="text-4xl font-black mb-2">${totalTickets}</p>
                <p class="text-orange-100 font-medium">Total Tickets</p>
            </div>

            <div class="card-hover bg-gradient-to-br from-purple-500 to-purple-600 rounded-2xl shadow-xl p-6 text-white">
                <div class="flex justify-between items-start mb-4">
                    <div class="w-14 h-14 bg-white/20 rounded-xl flex items-center justify-center">
                        <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                </div>
                <p class="text-4xl font-black mb-2">${usedTicketsCount}</p>
                <p class="text-purple-100 font-medium">Tickets Utilisés</p>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
            <button onclick="openAddPatientModal()"
                    class="card-hover bg-white rounded-2xl shadow-xl p-8 text-left border-2 border-transparent hover:border-blue-500 transition-all">
                <div class="flex items-center gap-4">
                    <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-blue-600 rounded-2xl flex items-center justify-center shadow-lg">
                        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-xl font-bold text-gray-900 mb-1">Ajouter un Patient</h3>
                        <p class="text-gray-600">Enregistrer un nouveau patient dans le système</p>
                    </div>
                </div>
            </button>

            <button onclick="openAddTicketModal()"
                    class="card-hover bg-white rounded-2xl shadow-xl p-8 text-left border-2 border-transparent hover:border-green-500 transition-all">
                <div class="flex items-center gap-4">
                    <div class="w-16 h-16 bg-gradient-to-br from-green-500 to-green-600 rounded-2xl flex items-center justify-center shadow-lg">
                        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-xl font-bold text-gray-900 mb-1">Créer un Ticket</h3>
                        <p class="text-gray-600">Générer un ticket pour un patient</p>
                    </div>
                </div>
            </button>
        </div>

        <!-- Tickets Table -->
        <div class="bg-white rounded-2xl shadow-xl overflow-hidden mb-8">
            <div class="bg-gradient-to-r from-blue-600 to-cyan-600 px-6 py-4">
                <h2 class="text-2xl font-bold text-white">Tickets Actifs Aujourd'hui</h2>
            </div>
            <div class="p-6">
                <c:choose>
                    <c:when test="${empty activeTickets}">
                        <div class="text-center py-12">
                            <svg class="w-16 h-16 text-gray-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" />
                            </svg>
                            <p class="text-gray-600 text-lg">Aucun ticket actif pour le moment</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead class="bg-gray-50 border-b-2 border-gray-200">
                                    <tr>
                                        <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">N° Ticket</th>
                                        <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Patient</th>
                                        <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Email</th>
                                        <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Téléphone</th>
                                        <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Date Création</th>
                                        <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Statut</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-200">
                                    <c:forEach var="ticket" items="${activeTickets}">
                                        <tr class="hover:bg-gray-50 transition-colors">
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <span class="text-lg font-bold text-blue-600">${ticket.ticketNumber}</span>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="flex items-center">
                                                    <div class="w-10 h-10 bg-gradient-to-br from-blue-500 to-cyan-500 rounded-full flex items-center justify-center text-white font-bold mr-3">
                                                        ${ticket.patient.firstName.substring(0,1)}${ticket.patient.lastName.substring(0,1)}
                                                    </div>
                                                    <div>
                                                        <p class="font-semibold text-gray-900">${ticket.patient.firstName} ${ticket.patient.lastName}</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-gray-600">${ticket.patient.email}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-gray-600">${ticket.patient.phone != null ? ticket.patient.phone : 'N/A'}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-gray-600">
                                                <fmt:formatDate value="${ticket.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <span class="px-3 py-1 text-xs font-bold rounded-full bg-green-100 text-green-800">
                                                    ACTIF
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </main>

    <!-- Modal Add Patient -->
    <div id="addPatientModal" class="hidden fixed inset-0 z-50 overflow-y-auto bg-black bg-opacity-50">
        <div class="flex items-center justify-center min-h-screen px-4">
            <div class="bg-white rounded-3xl shadow-2xl max-w-2xl w-full">
                <div class="bg-gradient-to-r from-blue-600 to-cyan-600 px-6 py-5 rounded-t-3xl">
                    <div class="flex justify-between items-center">
                        <h3 class="text-2xl font-bold text-white">Ajouter un Nouveau Patient</h3>
                        <button onclick="closeAddPatientModal()" class="text-white hover:bg-white/20 rounded-lg p-2">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/nurse/dashboard" class="p-6">
                    <input type="hidden" name="action" value="addPatient">
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Prénom *</label>
                            <input type="text" name="firstName" required
                                   class="w-full px-4 py-3 border-2 border-gray-300 rounded-xl focus:border-blue-500 focus:outline-none">
                        </div>
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Nom *</label>
                            <input type="text" name="lastName" required
                                   class="w-full px-4 py-3 border-2 border-gray-300 rounded-xl focus:border-blue-500 focus:outline-none">
                        </div>
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Nom d'utilisateur *</label>
                            <input type="text" name="username" required
                                   class="w-full px-4 py-3 border-2 border-gray-300 rounded-xl focus:border-blue-500 focus:outline-none">
                        </div>
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Mot de passe</label>
                            <input type="password" name="password"
                                   class="w-full px-4 py-3 border-2 border-gray-300 rounded-xl focus:border-blue-500 focus:outline-none"
                                   placeholder="Laisser vide = password123">
                        </div>
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Email *</label>
                            <input type="email" name="email" required
                                   class="w-full px-4 py-3 border-2 border-gray-300 rounded-xl focus:border-blue-500 focus:outline-none">
                        </div>
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Téléphone</label>
                            <input type="tel" name="phone"
                                   class="w-full px-4 py-3 border-2 border-gray-300 rounded-xl focus:border-blue-500 focus:outline-none">
                        </div>
                        <div class="col-span-2">
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Genre *</label>
                            <div class="flex gap-4">
                                <label class="flex items-center gap-2 px-6 py-3 border-2 border-gray-300 rounded-xl cursor-pointer hover:bg-blue-50">
                                    <input type="radio" name="gender" value="MALE" required class="w-4 h-4">
                                    <span class="font-medium">Homme</span>
                                </label>
                                <label class="flex items-center gap-2 px-6 py-3 border-2 border-gray-300 rounded-xl cursor-pointer hover:bg-pink-50">
                                    <input type="radio" name="gender" value="FEMALE" required class="w-4 h-4">
                                    <span class="font-medium">Femme</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="flex gap-3 mt-6">
                        <button type="button" onclick="closeAddPatientModal()"
                                class="flex-1 px-6 py-3 bg-gray-200 hover:bg-gray-300 rounded-xl font-semibold">
                            Annuler
                        </button>
                        <button type="submit"
                                class="flex-1 px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 hover:from-blue-700 hover:to-cyan-700 text-white rounded-xl font-semibold">
                            Enregistrer
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal Add Ticket -->
    <div id="addTicketModal" class="hidden fixed inset-0 z-50 overflow-y-auto bg-black bg-opacity-50">
        <div class="flex items-center justify-center min-h-screen px-4">
            <div class="bg-white rounded-3xl shadow-2xl max-w-2xl w-full">
                <div class="bg-gradient-to-r from-green-600 to-emerald-600 px-6 py-5 rounded-t-3xl">
                    <div class="flex justify-between items-center">
                        <h3 class="text-2xl font-bold text-white">Créer un Ticket</h3>
                        <button onclick="closeAddTicketModal()" class="text-white hover:bg-white/20 rounded-lg p-2">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>
                </div>
                <div class="p-6">
                    <div class="mb-4">
                        <label class="block text-sm font-semibold text-gray-700 mb-2">Rechercher un patient</label>
                        <input type="text" id="patientSearch"
                               placeholder="Tapez le nom du patient..."
                               class="w-full px-4 py-3 border-2 border-gray-300 rounded-xl focus:border-green-500 focus:outline-none"
                               oninput="searchPatientForTicket(this.value)">
                        <div id="patientSearchResults" class="mt-3"></div>
                    </div>
                    <form method="post" action="${pageContext.request.contextPath}/nurse/dashboard" id="ticketForm">
                        <input type="hidden" name="action" value="addTicket">
                        <input type="hidden" name="patientId" id="selectedPatientId">
                        <div id="selectedPatientInfo" class="hidden mb-4 p-4 bg-green-50 border-2 border-green-200 rounded-xl"></div>
                        <div class="flex gap-3">
                            <button type="button" onclick="closeAddTicketModal()"
                                    class="flex-1 px-6 py-3 bg-gray-200 hover:bg-gray-300 rounded-xl font-semibold">
                                Annuler
                            </button>
                            <button type="submit" id="submitTicketBtn" disabled
                                    class="flex-1 px-6 py-3 bg-gradient-to-r from-green-600 to-emerald-600 text-white rounded-xl font-semibold disabled:opacity-50 disabled:cursor-not-allowed">
                                Créer le Ticket
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openAddPatientModal() {
            document.getElementById('addPatientModal').classList.remove('hidden');
        }

        function closeAddPatientModal() {
            document.getElementById('addPatientModal').classList.add('hidden');
        }

        function openAddTicketModal() {
            document.getElementById('addTicketModal').classList.remove('hidden');
        }

        function closeAddTicketModal() {
            document.getElementById('addTicketModal').classList.add('hidden');
            document.getElementById('patientSearch').value = '';
            document.getElementById('patientSearchResults').innerHTML = '';
            document.getElementById('selectedPatientId').value = '';
            document.getElementById('selectedPatientInfo').classList.add('hidden');
            document.getElementById('submitTicketBtn').disabled = true;
        }

        let searchTimeout;
        function searchPatientForTicket(query) {
            clearTimeout(searchTimeout);
            const resultsDiv = document.getElementById('patientSearchResults');

            if (query.trim().length < 2) {
                resultsDiv.innerHTML = '';
                return;
            }

            resultsDiv.innerHTML = '<div class="text-center py-2"><div class="inline-block animate-spin rounded-full h-6 w-6 border-4 border-green-600 border-t-transparent"></div></div>';

            searchTimeout = setTimeout(() => {
                fetch('${pageContext.request.contextPath}/nurse/dashboard?action=searchPatient&query=' + encodeURIComponent(query))
                    .then(response => response.json())
                    .then(data => {
                        if (data.length === 0) {
                            resultsDiv.innerHTML = '<p class="text-gray-600 text-center py-2">Aucun patient trouvé</p>';
                        } else {
                            let html = '<div class="space-y-2 max-h-60 overflow-y-auto">';
                            data.forEach(patient => {
                                html += `
                                    <div onclick="selectPatient(${patient.id}, '${patient.firstName}', '${patient.lastName}', '${patient.email}')"
                                         class="p-4 border-2 border-gray-200 rounded-xl hover:border-green-500 hover:bg-green-50 cursor-pointer transition-all">
                                        <p class="font-bold text-gray-900">${patient.firstName} ${patient.lastName}</p>
                                        <p class="text-sm text-gray-600">${patient.email}</p>
                                    </div>
                                `;
                            });
                            html += '</div>';
                            resultsDiv.innerHTML = html;
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        resultsDiv.innerHTML = '<p class="text-red-600 text-center py-2">Erreur lors de la recherche</p>';
                    });
            }, 300);
        }

        function selectPatient(id, firstName, lastName, email) {
            document.getElementById('selectedPatientId').value = id;
            document.getElementById('patientSearchResults').innerHTML = '';
            document.getElementById('patientSearch').value = firstName + ' ' + lastName;

            const infoDiv = document.getElementById('selectedPatientInfo');
            infoDiv.innerHTML = `
                <div class="flex items-center gap-3">
                    <div class="w-12 h-12 bg-green-600 rounded-full flex items-center justify-center text-white font-bold text-lg">
                        ${firstName.charAt(0)}${lastName.charAt(0)}
                    </div>
                    <div>
                        <p class="font-bold text-gray-900">${firstName} ${lastName}</p>
                        <p class="text-sm text-gray-600">${email}</p>
                    </div>
                    <svg class="w-6 h-6 text-green-600 ml-auto" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                    </svg>
                </div>
            `;
            infoDiv.classList.remove('hidden');
            document.getElementById('submitTicketBtn').disabled = false;
        }
    </script>
</body>
</html>

