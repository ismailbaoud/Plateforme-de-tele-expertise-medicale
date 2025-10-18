<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Patient" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Person" %>
<%@ page import="com.medicale.consultation.consultationmedicale.enums.Role" %>

<%
    Person user = (Person) session.getAttribute("user");
    if (user == null || user.getRole() != Role.NURSE) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    List<Patient> patients = (List<Patient>) request.getAttribute("patients");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tous les Patients | Infirmière</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Inter', sans-serif; }
        .diagonal-grid::before {
            content: '';
            position: absolute;
            inset: 0;
            background-image:
                    linear-gradient(45deg, transparent 49%, #e5e7eb 49%, #e5e7eb 51%, transparent 51%),
                    linear-gradient(-45deg, transparent 49%, #e5e7eb 49%, #e5e7eb 51%, transparent 51%);
            background-size: 40px 40px;
            mask-image: radial-gradient(ellipse 70% 60% at 50% 0%, #000 60%, transparent 100%);
        }
        .dark .diagonal-grid::before {
            background-image:
                    linear-gradient(45deg, transparent 49%, #334155 49%, #334155 51%, transparent 51%),
                    linear-gradient(-45deg, transparent 49%, #334155 49%, #334155 51%, transparent 51%);
        }
        @keyframes slideIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .patient-card {
            animation: slideIn 0.4s ease-out forwards;
        }
    </style>
</head>
<body class="bg-white dark:bg-slate-900 min-h-screen">
<!-- Diagonal Grid Background -->
<div class="fixed inset-0 diagonal-grid"></div>

<%@include file="../../header.jsp"%>

<main class="relative z-10 min-h-screen p-6 lg:p-8">
    <div class="max-w-7xl mx-auto">
        <!-- Header Card -->
        <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 overflow-hidden mb-6">
            <div class="bg-gradient-to-r from-blue-500 via-cyan-500 to-teal-500 p-8 text-white">
                <div class="flex items-center justify-between">
                    <div class="flex items-center gap-4">
                        <div class="w-16 h-16 bg-white/20 backdrop-blur-sm rounded-2xl flex items-center justify-center">
                            <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                            </svg>
                        </div>
                        <div>
                            <h1 class="text-3xl font-bold mb-1">Tous les Patients</h1>
                            <p class="text-blue-100">Gestion et consultation des dossiers médicaux</p>
                        </div>
                    </div>
                    <div class="hidden md:block">
                        <div class="text-right bg-white/20 backdrop-blur-sm rounded-2xl px-6 py-4">
                            <div class="text-4xl font-black"><%= patients != null ? patients.size() : 0 %></div>
                            <div class="text-sm text-blue-100 font-medium">Patients</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Search and Filter Bar -->
            <div class="p-6 bg-gradient-to-r from-blue-50 to-cyan-50 dark:from-blue-900/20 dark:to-cyan-900/20 border-b border-gray-200 dark:border-slate-700">
                <div class="flex flex-col md:flex-row gap-4">
                    <div class="flex-1 relative">
                        <input type="text" id="searchInput" placeholder="Rechercher un patient (nom, prénom, dossier)..."
                               class="w-full pl-12 pr-4 py-3 bg-white dark:bg-slate-800 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-500/10 transition-all outline-none">
                        <svg class="w-5 h-5 text-gray-400 absolute left-4 top-1/2 -translate-y-1/2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                    </div>
                    <select id="genderFilter" class="px-4 py-3 bg-white dark:bg-slate-800 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-blue-500 focus:ring-4 focus:ring-blue-500/10 transition-all outline-none">
                        <option value="">Tous les genres</option>
                        <option value="MALE">Hommes</option>
                        <option value="FEMALE">Femmes</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- Patients Grid -->
        <div id="patientsContainer" class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <%
                if (patients != null && !patients.isEmpty()) {
                    int index = 0;
                    for (Patient patient : patients) {
                        index++;
                        String avatarColor = (index % 6 == 0) ? "from-purple-500 to-pink-500" :
                                           (index % 5 == 0) ? "from-orange-500 to-red-500" :
                                           (index % 4 == 0) ? "from-green-500 to-emerald-500" :
                                           (index % 3 == 0) ? "from-blue-500 to-cyan-500" :
                                           (index % 2 == 0) ? "from-indigo-500 to-purple-500" :
                                           "from-pink-500 to-rose-500";
            %>
            <div class="patient-card bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 overflow-hidden hover:shadow-2xl transition-all"
                 style="animation-delay: <%= index * 0.05 %>s;"
                 data-patient-name="<%= patient.getFirstName().toLowerCase() %> <%= patient.getLastName().toLowerCase() %>"
                 data-patient-dossier="<%= patient.getDossierNumber() %>"
                 data-patient-gender="<%= patient.getGender() != null ? patient.getGender().toString() : "" %>">

                <div class="p-6">
                    <!-- Patient Header -->
                    <div class="flex items-start gap-4 mb-6">
                        <div class="w-16 h-16 bg-gradient-to-br <%= avatarColor %> rounded-2xl flex items-center justify-center text-white font-bold text-xl shadow-lg">
                            <%= patient.getFirstName().substring(0, 1).toUpperCase() %><%= patient.getLastName().substring(0, 1).toUpperCase() %>
                        </div>
                        <div class="flex-1">
                            <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-1">
                                <%= patient.getFirstName() %> <%= patient.getLastName() %>
                            </h3>
                            <div class="flex items-center gap-2 text-sm text-gray-600 dark:text-gray-400">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                </svg>
                                <span class="font-medium">Dossier: <%= patient.getDossierNumber() %></span>
                            </div>
                        </div>
                        <% if (patient.getGender() != null) { %>
                        <div class="px-3 py-1.5 bg-blue-100 dark:bg-blue-900/30 text-blue-700 dark:text-blue-300 rounded-lg text-xs font-semibold">
                            <%= patient.getGender().toString().equals("MALE") ? "👨 Homme" : "👩 Femme" %>
                        </div>
                        <% } %>
                    </div>

                    <!-- Patient Details Grid -->
                    <div class="grid grid-cols-2 gap-4 mb-6">
                        <div class="p-3 bg-gradient-to-br from-blue-50 to-cyan-50 dark:from-blue-900/20 dark:to-cyan-900/20 rounded-xl border border-blue-200 dark:border-blue-800">
                            <div class="flex items-center gap-2 mb-1">
                                <svg class="w-4 h-4 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                </svg>
                                <span class="text-xs font-semibold text-gray-700 dark:text-gray-300">Date de naissance</span>
                            </div>
                            <p class="text-sm font-bold text-gray-900 dark:text-white">
                                <%= patient.getDateOfBirth() != null ? patient.getDateOfBirth().toString() : "Non renseigné" %>
                            </p>
                        </div>

                        <div class="p-3 bg-gradient-to-br from-purple-50 to-pink-50 dark:from-purple-900/20 dark:to-pink-900/20 rounded-xl border border-purple-200 dark:border-purple-800">
                            <div class="flex items-center gap-2 mb-1">
                                <svg class="w-4 h-4 text-purple-600 dark:text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                                </svg>
                                <span class="text-xs font-semibold text-gray-700 dark:text-gray-300">Téléphone</span>
                            </div>
                            <p class="text-sm font-bold text-gray-900 dark:text-white">
                                <%= patient.getPhone() != null ? patient.getPhone() : "Non renseigné" %>
                            </p>
                        </div>

                        <div class="p-3 bg-gradient-to-br from-green-50 to-emerald-50 dark:from-green-900/20 dark:to-emerald-900/20 rounded-xl border border-green-200 dark:border-green-800">
                            <div class="flex items-center gap-2 mb-1">
                                <svg class="w-4 h-4 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                </svg>
                                <span class="text-xs font-semibold text-gray-700 dark:text-gray-300">Email</span>
                            </div>
                            <p class="text-sm font-bold text-gray-900 dark:text-white truncate">
                                <%= patient.getEmail() != null ? patient.getEmail() : "Non renseigné" %>
                            </p>
                        </div>

                        <div class="p-3 bg-gradient-to-br from-orange-50 to-amber-50 dark:from-orange-900/20 dark:to-amber-900/20 rounded-xl border border-orange-200 dark:border-orange-800">
                            <div class="flex items-center gap-2 mb-1">
                                <svg class="w-4 h-4 text-orange-600 dark:text-orange-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
                                </svg>
                                <span class="text-xs font-semibold text-gray-700 dark:text-gray-300">Poids / Taille</span>
                            </div>
                            <p class="text-sm font-bold text-gray-900 dark:text-white">
                                <%= patient.getWeight() != null ? patient.getWeight() + " kg" : "-" %> /
                                <%= patient.getHeight() != null ? patient.getHeight() + " cm" : "-" %>
                            </p>
                        </div>
                    </div>

                    <!-- Action Button -->
                    <div class="flex gap-3">
                        <a href="${pageContext.request.contextPath}/medicalFiles?id=<%= patient.getId() %>"
                           class="flex-1 flex items-center justify-center gap-2 px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 hover:from-blue-700 hover:to-cyan-700 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                            </svg>
                            <span>Voir le Dossier Médical</span>
                        </a>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="col-span-2 bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 p-16">
                <div class="flex flex-col items-center gap-4">
                    <div class="w-24 h-24 bg-gradient-to-br from-gray-100 to-gray-200 dark:from-gray-800 dark:to-gray-900 rounded-full flex items-center justify-center">
                        <svg class="w-12 h-12 text-gray-400 dark:text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                        </svg>
                    </div>
                    <div class="text-center">
                        <p class="text-xl font-semibold text-gray-700 dark:text-gray-300">Aucun patient</p>
                        <p class="text-sm text-gray-500 dark:text-gray-500 mt-2">Il n'y a aucun patient enregistré dans le système.</p>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</main>

<!-- Footer -->
<jsp:include page="../../footer.jsp" />

<script>
    // Dark mode
    if (localStorage.getItem('darkMode') === 'enabled' || (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
    }

    // Search and Filter functionality
    const searchInput = document.getElementById('searchInput');
    const genderFilter = document.getElementById('genderFilter');
    const patientCards = document.querySelectorAll('.patient-card');

    function filterPatients() {
        const searchTerm = searchInput.value.toLowerCase();
        const selectedGender = genderFilter.value;

        patientCards.forEach(card => {
            const patientName = card.getAttribute('data-patient-name');
            const patientDossier = card.getAttribute('data-patient-dossier').toLowerCase();
            const patientGender = card.getAttribute('data-patient-gender');

            const matchesSearch = patientName.includes(searchTerm) || patientDossier.includes(searchTerm);
            const matchesGender = selectedGender === '' || patientGender === selectedGender;

            if (matchesSearch && matchesGender) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    }

    searchInput.addEventListener('input', filterPatients);
    genderFilter.addEventListener('change', filterPatients);
</script>
</body>
</html>

