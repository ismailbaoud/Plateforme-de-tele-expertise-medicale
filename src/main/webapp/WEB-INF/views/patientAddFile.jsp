<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Patient" %>
<%@ page import="java.util.List" %>

<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signes Vitaux Patient</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Fonts: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        /* Custom styles for floating labels */
        .floating-label .peer:focus ~ label,
        .floating-label .peer:not(:placeholder-shown) ~ label {
            transform: translateY(-1.75rem) scale(0.75);
            color: #3b82f6; /* blue-500 */
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 to-cyan-100 flex items-center justify-center min-h-screen p-4">

<div class="bg-white rounded-2xl shadow-2xl w-full max-w-3xl overflow-hidden">
    <div class="p-8 md:p-12">
        <div class="flex items-center space-x-4 mb-8">
            <div class="bg-blue-100 text-blue-600 p-3 rounded-full">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" viewBox="0 0 20 20" fill="currentColor">
                    <path d="M10 3.5a1.5 1.5 0 011.493 1.355l.595 4.167a.5.5 0 00.986 0l.595-4.167A1.5 1.5 0 0115 3.5h.5a1.5 1.5 0 010 3h-.5a1.5 1.5 0 01-1.493-1.355L13 10.5l.507 3.645A1.5 1.5 0 0112 15.5h-.5a1.5 1.5 0 010-3h.5a1.5 1.5 0 011.493 1.355L13 10.5l-.507-3.645A1.5 1.5 0 0111 5.5h-2a1.5 1.5 0 01-1.493 1.355L7 10.5l-.507 3.645A1.5 1.5 0 015 15.5h-.5a1.5 1.5 0 010-3h.5a1.5 1.5 0 011.493 1.355L7 10.5l.507-3.645A1.5 1.5 0 019 5.5h1z" />
                </svg>
            </div>
            <div>
                <h1 class="text-3xl font-bold text-gray-800">Enregistrer les Signes Vitaux</h1>
                <p class="text-gray-500 mt-1">Sélectionnez un patient et saisissez ses informations.</p>
            </div>
        </div>

        <form action="saveMedicaleFile" method="post" class="space-y-8">

            <fieldset class="border-t border-gray-200 pt-6">
                <legend class="text-lg font-semibold text-gray-700 px-2 mb-4">Sélection du Patient</legend>
                <!-- Select Patient -->
                <div class="relative">
                    <label for="patientId" class="text-gray-500 text-xs font-semibold absolute -top-2 left-2 bg-white px-1">Patient</label>
                    <select id="patientId" name="patientId" required
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-300 bg-gray-50 appearance-none">
                        <option value="" disabled selected>-- Sélectionner un patient --</option>
                        <%
                            List<Patient> patients = (List<Patient>) request.getAttribute("patients");
                            if (patients != null) {
                                for (Patient p : patients) {
                        %>
                        <option value="<%= p.getId() %>"><%= p.getFirstName() + " " + p.getLastName() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                        <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                    </div>
                </div>
            </fieldset>

            <!-- Vital Signs -->
            <fieldset class="border-t border-gray-200 pt-6">
                <legend class="text-lg font-semibold text-gray-700 px-2 mb-4">Mesures des Signes Vitaux</legend>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <!-- Temperature -->
                    <div class="relative floating-label">
                        <input type="number" step="0.1" id="temperature" name="temperature" required placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-300 bg-gray-50">
                        <label for="temperature" class="absolute left-4 top-3.5 text-gray-500 transition-all duration-300 origin-top-left">Température (°C)</label>
                    </div>

                    <!-- Pulse -->
                    <div class="relative floating-label">
                        <input type="number" id="pulse" name="pulse" required placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-300 bg-gray-50">
                        <label for="pulse" class="absolute left-4 top-3.5 text-gray-500 transition-all duration-300 origin-top-left">Pouls (bpm)</label>
                    </div>

                    <!-- Blood Pressure -->
                    <div class="relative floating-label">
                        <input type="text" id="bloodPressure" name="bloodPressure" required placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-300 bg-gray-50">
                        <label for="bloodPressure" class="absolute left-4 top-3.5 text-gray-500 transition-all duration-300 origin-top-left">Tension artérielle</label>
                    </div>

                    <!-- Respiratory Rate -->
                    <div class="relative floating-label">
                        <input type="number" id="respiratoryRate" name="respiratoryRate" required placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-300 bg-gray-50">
                        <label for="respiratoryRate" class="absolute left-4 top-3.5 text-gray-500 transition-all duration-300 origin-top-left">Fréquence respiratoire</label>
                    </div>

                    <!-- Oxygen Saturation -->
                    <div class="relative floating-label">
                        <input type="number" step="0.1" id="oxygenSaturation" name="oxygenSaturation" required placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-300 bg-gray-50">
                        <label for="oxygenSaturation" class="absolute left-4 top-3.5 text-gray-500 transition-all duration-300 origin-top-left">Saturation en oxygène (%)</label>
                    </div>

                    <!-- Pain Level -->
                    <div class="relative floating-label">
                        <input type="number" id="pain" name="pain" min="0" max="10" required placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-300 bg-gray-50">
                        <label for="pain" class="absolute left-4 top-3.5 text-gray-500 transition-all duration-300 origin-top-left">Niveau de douleur (0-10)</label>
                    </div>
                </div>
            </fieldset>

            <!-- Submit Button -->
            <div class="pt-6">
                <button type="submit" class="w-full bg-gradient-to-r from-blue-600 to-cyan-500 text-white font-bold py-4 rounded-lg hover:from-blue-700 hover:to-cyan-600 focus:outline-none focus:ring-4 focus:ring-blue-300 mt-6 transition-all duration-300 transform hover:scale-105 shadow-lg">
                    Enregistrer les Signes Vitaux
                </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
