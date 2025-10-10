<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.medicale.consultation.consultationmedicale.enums.Gender" %>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("patient") != null ? "Mettre à jour le patient" : "Nouveau patient" %></title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
        .floating-label .peer:focus ~ label,
        .floating-label .peer:not(:placeholder-shown) ~ label {
            transform: translateY(-1.75rem) scale(0.75);
            color: #3b82f6;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 to-cyan-100 flex items-center justify-center min-h-screen p-4">

<%
    Object patientObj = request.getAttribute("patient");
    boolean isUpdate = patientObj != null;
%>

<div class="bg-white rounded-2xl shadow-2xl w-full max-w-3xl overflow-hidden">
    <div class="p-8 md:p-12">
        <div class="flex items-center space-x-4 mb-8">
            <div class="bg-blue-100 text-blue-600 p-3 rounded-full">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M10 6H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V8a2 2 0 00-2-2h-5m-4 0V5a2 2 0 114 0v1m-4 0a2 2 0 104 0m-5 8h2.586a1 1 0 01.707.293l2.414 2.414a1 1 0 001.414 0l2.414-2.414a1 1 0 01.707-.293H19"></path>
                </svg>
            </div>
            <div>
                <h1 class="text-3xl font-bold text-gray-800">
                    <%= isUpdate ? "Mise à jour du Patient" : "Nouveau Dossier Patient" %>
                </h1>
                <p class="text-gray-500 mt-1">Étape <span id="step-indicator">1</span> sur 2</p>
            </div>
        </div>

        <form id="patientForm"
              method="post"
              action="${pageContext.request.contextPath}/savePatientOrVitals?action=<%= isUpdate ? "updatePatient" : "createPatient" %>">

            <% if (isUpdate) { %>
            <input type="hidden" name="id" value="${patient.id}" />
            <% } %>

            <!-- Step 1 -->
            <div id="form-step-1" class="space-y-8">
                <fieldset>
                    <legend class="text-lg font-semibold text-gray-700 px-2 mb-4">Informations Personnelles</legend>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="relative floating-label">
                            <input type="text" id="firstName" name="firstName"
                                   value="${patient != null ? patient.firstName : ''}"
                                   required placeholder=""
                                   class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50">
                            <label for="firstName" class="absolute left-4 top-3.5 text-gray-500 transition-all">Prénom</label>
                        </div>

                        <div class="relative floating-label">
                            <input type="text" id="lastName" name="lastName"
                                   value="${patient != null ? patient.lastName : ''}"
                                   required placeholder=""
                                   class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50">
                            <label for="lastName" class="absolute left-4 top-3.5 text-gray-500 transition-all">Nom</label>
                        </div>

                        <div class="relative floating-label">
                            <input type="email" id="email" name="email"
                                   value="${patient != null ? patient.email : ''}"
                                   placeholder=""
                                   class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50">
                            <label for="email" class="absolute left-4 top-3.5 text-gray-500 transition-all">Email</label>
                        </div>

                        <div class="relative floating-label">
                            <input type="text" id="phone" name="phone"
                                   value="${patient != null ? patient.phone : ''}"
                                   placeholder=""
                                   class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50">
                            <label for="phone" class="absolute left-4 top-3.5 text-gray-500 transition-all">Téléphone</label>
                        </div>

                        <div class="relative">
                            <label for="gender" class="text-gray-500 text-xs font-semibold absolute -top-2 left-2 bg-white px-1">Genre</label>
                            <select id="gender" name="gender"
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50">
                                <option value="" disabled <%= !isUpdate ? "selected" : "" %>>-- Sélectionner --</option>
                                <option value="MALE" <%= isUpdate && ((Gender)request.getAttribute("patientGender")) == Gender.MALE ? "selected" : "" %>>Homme</option>
                                <option value="FEMALE" <%= isUpdate && ((Gender)request.getAttribute("patientGender")) == Gender.FEMALE ? "selected" : "" %>>Femme</option>
                            </select>
                        </div>
                    </div>
                </fieldset>

                <fieldset>
                    <legend class="text-lg font-semibold text-gray-700 px-2 mb-4">Informations du Dossier</legend>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="relative floating-label">
                            <input type="text" id="dossierNumber" name="dossierNumber"
                                   value="${patient != null ? patient.dossierNumber : ''}"
                                   required placeholder=""
                                   class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50">
                            <label for="dossierNumber" class="absolute left-4 top-3.5 text-gray-500 transition-all">Numéro de dossier</label>
                        </div>

                        <div class="relative">
                            <label for="dateOfBirth" class="text-gray-500 text-xs font-semibold absolute -top-2 left-2 bg-white px-1">Date de naissance</label>
                            <input type="date" id="dateOfBirth" name="dateOfBirth"
                                   value="${patient != null ? patient.dateOfBirth : ''}"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50 text-gray-500">
                        </div>

                        <div class="relative floating-label">
                            <input type="number" step="0.1" id="height" name="height"
                                   value="${patient != null ? patient.height : ''}"
                                   required placeholder=""
                                   class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50">
                            <label for="height" class="absolute left-4 top-3.5 text-gray-500 transition-all">Taille (cm)</label>
                        </div>

                        <div class="relative floating-label">
                            <input type="number" step="0.1" id="weight" name="weight"
                                   value="${patient != null ? patient.weight : ''}"
                                   required placeholder=""
                                   class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50">
                            <label for="weight" class="absolute left-4 top-3.5 text-gray-500 transition-all">Poids (kg)</label>
                        </div>
                    </div>
                </fieldset>

                <div class="pt-6 flex justify-end">
                    <button type="button" id="next-btn"
                            class="w-1/2 bg-gradient-to-r from-blue-600 to-cyan-500 text-white font-bold py-3 rounded-lg hover:from-blue-700 hover:to-cyan-600 transition-all duration-300 transform hover:scale-105 shadow-lg">
                        Suivant
                    </button>
                </div>
            </div>

            <!-- Step 2 -->
            <div id="form-step-2" class="hidden space-y-8">
                <fieldset>
                    <legend class="text-lg font-semibold text-gray-700 px-2 mb-4">Signes Vitaux Initiaux</legend>
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        <div class="relative floating-label"><input type="number" step="0.1" id="temperature" name="temperature" value="${patient != null ? patient.medicalFile.temperature : ''}" placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50"><label for="temperature" class="absolute left-4 top-3.5 text-gray-500 transition-all">Température (°C)</label></div>
                        <div class="relative floating-label"><input type="number" id="pulse" name="pulse" value="${patient != null ? patient.medicalFile.pulse : ''}" placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50"><label for="pulse" class="absolute left-4 top-3.5 text-gray-500 transition-all">Pouls (bpm)</label></div>
                        <div class="relative floating-label"><input type="text" id="bloodPressure" name="bloodPressure" value="${patient != null ? patient.medicalFile.bloodPressure : ''}" placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50"><label for="bloodPressure" class="absolute left-4 top-3.5 text-gray-500 transition-all">Tension artérielle</label></div>
                        <div class="relative floating-label"><input type="number" id="respiratoryRate" name="respiratoryRate" value="${patient != null ? patient.medicalFile.respiratoryRate : ''}" placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50"><label for="respiratoryRate" class="absolute left-4 top-3.5 text-gray-500 transition-all">Fréq. respiratoire</label></div>
                        <div class="relative floating-label"><input type="number" step="0.1" id="oxygenSaturation" name="oxygenSaturation" value="${patient != null ? patient.medicalFile.oxygenSaturation : ''}" placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50"><label for="oxygenSaturation" class="absolute left-4 top-3.5 text-gray-500 transition-all">Saturation O₂ (%)</label></div>
                        <div class="relative floating-label"><input type="number" id="pain" name="pain" min="0" max="10" value="${patient != null ? patient.medicalFile.pain : ''}" placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-gray-50"><label for="pain" class="absolute left-4 top-3.5 text-gray-500 transition-all">Douleur (0-10)</label></div>
                    </div>
                </fieldset>

                <div class="pt-6 flex justify-between gap-4">
                    <button type="button" id="back-btn" class="w-1/2 bg-gray-200 text-gray-700 font-bold py-3 rounded-lg hover:bg-gray-300">Précédent</button>
                    <button type="submit" class="w-1/2 bg-gradient-to-r from-blue-600 to-cyan-500 text-white font-bold py-3 rounded-lg hover:from-blue-700 hover:to-cyan-600 shadow-lg">
                        <%= isUpdate ? "Mettre à jour" : "Enregistrer le Patient" %>
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

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
</script>

</body>
</html>
