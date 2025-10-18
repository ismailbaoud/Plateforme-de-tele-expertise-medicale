<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Person" %>

<%
    Person user = (Person) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dossier médical du patient</title>
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

<jsp:include page="/header.jsp" />

<main class="relative z-10 min-h-screen p-6 lg:p-8">
    <div class="max-w-6xl mx-auto space-y-6">
        <!-- Patient Header Card -->
        <div class="bg-gradient-to-r from-blue-600 to-cyan-600 rounded-3xl shadow-2xl p-8 text-white">
            <div class="flex items-center gap-4">
                <div class="w-16 h-16 bg-white/20 backdrop-blur-sm rounded-2xl flex items-center justify-center">
                    <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                    </svg>
                </div>
                <div>
                    <c:choose>
                        <c:when test="${not empty medicalFile.consultations}">
                            <h1 class="text-3xl font-bold mb-1">
                                ${medicalFile.consultations[0].patient.firstName} ${medicalFile.consultations[0].patient.lastName}
                            </h1>
                        </c:when>
                        <c:otherwise>
                            <h1 class="text-3xl font-bold mb-1">Patient inconnu</h1>
                        </c:otherwise>
                    </c:choose>
                    <p class="text-blue-100">Dossier médical complet</p>
                </div>
            </div>
        </div>

        <!-- Personal Info -->
        <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-2xl shadow-lg border border-gray-200/50 dark:border-slate-700/50 p-6">
            <div class="flex items-center gap-3 mb-4">
                <div class="w-10 h-10 bg-blue-100 dark:bg-blue-900/30 rounded-xl flex items-center justify-center">
                    <svg class="w-5 h-5 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                    </svg>
                </div>
                <h2 class="text-lg font-semibold text-gray-900 dark:text-white">Informations personnelles</h2>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="p-4 bg-gray-50 dark:bg-slate-900/50 rounded-xl">
                    <p class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Nom complet</p>
                    <c:choose>
                        <c:when test="${not empty medicalFile.consultations}">
                            <p class="text-sm font-semibold text-gray-900 dark:text-white">${medicalFile.consultations[0].patient.firstName} ${medicalFile.consultations[0].patient.lastName}</p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-sm font-semibold text-gray-900 dark:text-white">-</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="p-4 bg-gray-50 dark:bg-slate-900/50 rounded-xl">
                    <p class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Date de naissance</p>
                    <c:choose>
                        <c:when test="${not empty medicalFile.consultations}">
                            <p class="text-sm font-semibold text-gray-900 dark:text-white">${medicalFile.consultations[0].patient.dateOfBirth}</p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-sm font-semibold text-gray-900 dark:text-white">-</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="p-4 bg-gray-50 dark:bg-slate-900/50 rounded-xl">
                    <p class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Numéro de dossier</p>
                    <c:choose>
                        <c:when test="${not empty medicalFile.consultations}">
                            <p class="text-sm font-semibold text-gray-900 dark:text-white">${medicalFile.consultations[0].patient.dossierNumber}</p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-sm font-semibold text-gray-900 dark:text-white">-</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="p-4 bg-gray-50 dark:bg-slate-900/50 rounded-xl">
                    <p class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Téléphone</p>
                    <c:choose>
                        <c:when test="${not empty medicalFile.consultations}">
                            <p class="text-sm font-semibold text-gray-900 dark:text-white">${medicalFile.consultations[0].patient.phone}</p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-sm font-semibold text-gray-900 dark:text-white">-</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Vital Signs -->
        <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-2xl shadow-lg border border-gray-200/50 dark:border-slate-700/50 p-6">
            <div class="flex items-center gap-3 mb-4">
                <div class="w-10 h-10 bg-red-100 dark:bg-red-900/30 rounded-xl flex items-center justify-center">
                    <svg class="w-5 h-5 text-red-600 dark:text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
                    </svg>
                </div>
                <h2 class="text-lg font-semibold text-gray-900 dark:text-white">Signes vitaux</h2>
            </div>
            <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                <div class="p-4 bg-gradient-to-br from-red-50 to-pink-50 dark:from-red-900/20 dark:to-pink-900/20 rounded-xl border border-red-200 dark:border-red-800">
                    <p class="text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Tension artérielle</p>
                    <p class="text-lg font-bold text-red-600 dark:text-red-400">${medicalFile.bloodPresure}</p>
                </div>
                <div class="p-4 bg-gradient-to-br from-orange-50 to-amber-50 dark:from-orange-900/20 dark:to-amber-900/20 rounded-xl border border-orange-200 dark:border-orange-800">
                    <p class="text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Température</p>
                    <p class="text-lg font-bold text-orange-600 dark:text-orange-400">${medicalFile.temperature}°C</p>
                </div>
                <div class="p-4 bg-gradient-to-br from-blue-50 to-cyan-50 dark:from-blue-900/20 dark:to-cyan-900/20 rounded-xl border border-blue-200 dark:border-blue-800">
                    <p class="text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Poids</p>
                    <c:choose>
                        <c:when test="${not empty medicalFile.consultations}">
                            <p class="text-lg font-bold text-blue-600 dark:text-blue-400">${medicalFile.consultations[0].patient.weight} kg</p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-lg font-bold text-blue-600 dark:text-blue-400">-</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="p-4 bg-gradient-to-br from-green-50 to-emerald-50 dark:from-green-900/20 dark:to-emerald-900/20 rounded-xl border border-green-200 dark:border-green-800">
                    <p class="text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Taille</p>
                    <c:choose>
                        <c:when test="${not empty medicalFile.consultations}">
                            <p class="text-lg font-bold text-green-600 dark:text-green-400">${medicalFile.consultations[0].patient.height} cm</p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-lg font-bold text-green-600 dark:text-green-400">-</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Previous Consultations -->
        <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-2xl shadow-lg border border-gray-200/50 dark:border-slate-700/50 p-6">
            <div class="flex items-center gap-3 mb-4">
                <div class="w-10 h-10 bg-purple-100 dark:bg-purple-900/30 rounded-xl flex items-center justify-center">
                    <svg class="w-5 h-5 text-purple-600 dark:text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    </svg>
                </div>
                <h2 class="text-lg font-semibold text-gray-900 dark:text-white">Consultations précédentes</h2>
            </div>
            <div class="overflow-x-auto rounded-xl border border-gray-200 dark:border-slate-700">
                <table class="min-w-full divide-y divide-gray-200 dark:divide-slate-700">
                    <thead class="bg-gray-50 dark:bg-slate-900/50">
                    <tr>
                        <th class="px-4 py-3 text-left text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider">Date</th>
                        <th class="px-4 py-3 text-left text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider">Motif</th>
                        <th class="px-4 py-3 text-left text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider">Observations</th>
                        <th class="px-4 py-3 text-left text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider">Statut</th>
                    </tr>
                    </thead>
                    <tbody class="bg-white dark:bg-slate-800 divide-y divide-gray-200 dark:divide-slate-700">
                    <c:forEach var="consultation" items="${consultations}">
                        <tr class="hover:bg-gray-50 dark:hover:bg-slate-700/50 transition-colors">
                            <td class="px-4 py-3 text-sm text-gray-900 dark:text-white">${consultation.createdAt}</td>
                            <td class="px-4 py-3 text-sm text-gray-700 dark:text-gray-300">${consultation.reason}</td>
                            <td class="px-4 py-3 text-sm text-gray-700 dark:text-gray-300">${consultation.observations}</td>
                            <td class="px-4 py-3">
                                    <span class="inline-flex px-3 py-1 text-xs font-medium rounded-full bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-400">
                                            ${consultation.consultationStatus}
                                    </span>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty consultations}">
                        <tr>
                            <td colspan="4" class="px-4 py-8 text-sm text-gray-500 dark:text-gray-400 text-center">
                                Aucune consultation enregistrée.
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Create New Consultation Button -->
         <div class="flex justify-end">
            <form action="${pageContext.request.contextPath}/consultations" method="get">
                <c:if test="${not empty medicalFile.consultations}">
                    <input type="hidden" name="patientId" value="${medicalFile.consultations[0].patient.id}"/>
                </c:if>
                 <button type="submit" class="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 hover:from-blue-700 hover:to-cyan-700 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all">
                     <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                         <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                     </svg>
                     <span>Créer une nouvelle consultation</span>
                 </button>
             </form>
         </div>
     </div>
 </main>

<script>
    // Dark mode
    if (localStorage.getItem('darkMode') === 'enabled' || (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
    }
</script>
</body>
</html>
