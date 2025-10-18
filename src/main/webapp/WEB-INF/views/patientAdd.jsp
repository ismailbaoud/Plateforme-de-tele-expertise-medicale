<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.MedicaleFile" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Patient" %>
<%@ page import="com.medicale.consultation.consultationmedicale.enums.Gender" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Person" %>

<%
    Person user = (Person) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
    MedicaleFile medicalFile = (MedicaleFile) request.getAttribute("medicalFile");
    Patient patient = (medicalFile != null) ? medicalFile.getPatient() : null;
    boolean isUpdate = patient != null;
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isUpdate ? "Mise à jour du patient" : "Nouveau patient" %></title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
    </style>
</head>
<body class="bg-white dark:bg-slate-900 min-h-screen">
<!-- Diagonal Grid Background -->
<div class="fixed inset-0 diagonal-grid"></div>

<jsp:include page="../../header.jsp"/>

<main class="relative z-10 min-h-screen p-6 lg:p-8">
    <div class="max-w-4xl mx-auto">
        <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 overflow-hidden">
            <!-- Header -->
            <div class="bg-gradient-to-r from-teal-600 to-cyan-600 p-8 text-white">
                <div class="flex items-center gap-4">
                    <div class="w-14 h-14 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center">
                        <svg class="w-7 h-7" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                        </svg>
                    </div>
                    <div>
                        <h1 class="text-2xl font-bold mb-1">
                            <%= isUpdate ? "Mise à jour du patient" : "Nouveau dossier patient" %>
                        </h1>
                        <p class="text-teal-100">Étape <span id="step-indicator">1</span> sur 2</p>
                    </div>
                </div>
            </div>

            <!-- Form -->
            <div class="p-8">
                <form id="patientForm" method="post" action="<%= request.getContextPath() %>/savePatientOrVitals?action=<%= isUpdate ? "updatePatient" : "createPatient" %>">
                    <% if (isUpdate) { %>
                    <input type="hidden" name="id" value="<%= patient.getId() %>"/>
                    <% } %>

                    <!-- Step 1: Personal Information -->
                    <div id="form-step-1" class="space-y-6">
                        <div>
                            <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Informations Personnelles</h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label for="firstName" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Prénom</label>
                                    <input type="text" id="firstName" name="firstName" required value="<%= isUpdate ? patient.getFirstName() : "" %>"
                                           class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                </div>
                                <div>
                                    <label for="lastName" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Nom</label>
                                    <input type="text" id="lastName" name="lastName" required value="<%= isUpdate ? patient.getLastName() : "" %>"
                                           class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                </div>
                                <div>
                                    <label for="email" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Email</label>
                                    <input type="email" id="email" name="email" value="<%= isUpdate && patient.getEmail() != null ? patient.getEmail() : "" %>"
                                           class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                </div>
                                <div>
                                    <label for="phone" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Téléphone</label>
                                    <input type="text" id="phone" name="phone" value="<%= isUpdate && patient.getPhone() != null ? patient.getPhone() : "" %>"
                                           class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                </div>
                                <div>
                                    <label for="gender" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Genre</label>
                                    <select id="gender" name="gender"
                                            class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                        <option value="" disabled <%= !isUpdate ? "selected" : "" %>>-- Sélectionner --</option>
                                        <option value="MALE" <%= isUpdate && patient.getGender() == Gender.MALE ? "selected" : "" %>>Homme</option>
                                        <option value="FEMALE" <%= isUpdate && patient.getGender() == Gender.FEMALE ? "selected" : "" %>>Femme</option>
                                    </select>
                                </div>
                                <div>
                                    <label for="dateOfBirth" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Date de naissance</label>
                                    <input type="date" id="dateOfBirth" name="dateOfBirth" value="<%= isUpdate && patient.getDateOfBirth() != null ? patient.getDateOfBirth().toString() : "" %>"
                                           class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                </div>
                            </div>
                        </div>

                        <div>
                            <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Informations du Dossier</h3>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <div>
                                    <label for="dossierNumber" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Numéro de dossier</label>
                                    <input type="text" id="dossierNumber" name="dossierNumber" required value="<%= isUpdate ? patient.getDossierNumber() : "" %>"
                                           class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                </div>
                                <div>
                                    <label for="height" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Taille (cm)</label>
                                    <input type="number" step="0.1" id="height" name="height" required value="<%= isUpdate ? patient.getHeight() : "" %>"
                                           class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                </div>
                                <div>
                                    <label for="weight" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Poids (kg)</label>
                                    <input type="number" step="0.1" id="weight" name="weight" required value="<%= isUpdate ? patient.getWeight() : "" %>"
                                           class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                </div>
                            </div>
                        </div>

                        <div class="flex justify-end pt-4">
                            <button type="button" id="next-btn"
                                    class="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-teal-600 to-cyan-600 hover:from-teal-700 hover:to-cyan-700 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all">
                                <span>Suivant</span>
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                                </svg>
                            </button>
                        </div>
                    </div>

                    <!-- Step 2: Vital Signs -->
                    <div id="form-step-2" class="hidden space-y-6">
                        <div>
                            <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Signes Vitaux Initiaux</h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                <div>
                                    <label for="temperature" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Température (°C)</label>
                                    <input type="number" step="0.1" id="temperature" name="temperature" value="<%= isUpdate ? medicalFile.getTemperature() : "" %>"
                                           class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                </div>
                                <div>
                                    <label for="pulse" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Pouls (bpm)</label>
                                    <input type="number" id="pulse" name="pulse" value="<%= isUpdate ? medicalFile.getPulse() : "" %>"
                                           class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                </div>
                                <div>
                                    <label for="bloodPressure" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Tension artérielle</label>
                                    <input type="text" id="bloodPressure" name="bloodPressure" value="<%= isUpdate ? medicalFile.getBloodPresure() : "" %>"
                                           class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                </div>
                                <div>
                                    <label for="respiratoryRate" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Fréq. respiratoire</label>
                                    <input type="number" id="respiratoryRate" name="respiratoryRate" value="<%= isUpdate ? medicalFile.getRespiratoryRate() : "" %>"
                                           class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                </div>
                                <div>
                                    <label for="oxygenSaturation" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Saturation O₂ (%)</label>
                                    <input type="number" step="0.1" id="oxygenSaturation" name="oxygenSaturation" value="<%= isUpdate ? medicalFile.getOxygenSaturation() : "" %>"
                                           class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                </div>
                                <div>
                                    <label for="pain" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Douleur (0–10)</label>
                                    <input type="number" id="pain" name="pain" min="0" max="10" value="<%= isUpdate ? medicalFile.getPain() : "" %>"
                                           class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-teal-500 focus:ring-4 focus:ring-teal-500/10 transition-all outline-none">
                                </div>
                            </div>
                        </div>

                        <div class="flex justify-between items-center pt-4">
                            <button type="button" id="back-btn"
                                    class="flex items-center gap-2 px-6 py-3 bg-gray-200 dark:bg-slate-700 hover:bg-gray-300 dark:hover:bg-slate-600 text-gray-700 dark:text-gray-200 font-semibold rounded-xl transition-all">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
                                </svg>
                                <span>Précédent</span>
                            </button>
                            <button type="submit"
                                    class="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-teal-600 to-cyan-600 hover:from-teal-700 hover:to-cyan-700 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                                </svg>
                                <span><%= isUpdate ? "Mettre à jour" : "Enregistrer" %></span>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<script>
    const step1 = document.getElementById('form-step-1');
    const step2 = document.getElementById('form-step-2');
    const nextBtn = document.getElementById('next-btn');
    const backBtn = document.getElementById('back-btn');
    const stepIndicator = document.getElementById('step-indicator');

    nextBtn?.addEventListener('click', () => {
        step1.classList.add('hidden');
        step2.classList.remove('hidden');
        stepIndicator.textContent = '2';
    });
    backBtn?.addEventListener('click', () => {
        step2.classList.add('hidden');
        step1.classList.remove('hidden');
        stepIndicator.textContent = '1';
    });

    // Dark mode
    if (localStorage.getItem('darkMode') === 'enabled' || (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
    }
</script>
</body>
</html>
