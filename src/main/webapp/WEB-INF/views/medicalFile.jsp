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
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                    },
                },
            },
        }
    </script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="bg-gray-50 dark:bg-gray-900 min-h-screen text-gray-800 dark:text-gray-200 transition-colors duration-300 flex flex-col">

<jsp:include page="../../header.jsp"/>

<main class="flex-grow p-6 lg:p-8">
    <div class="max-w-6xl mx-auto">
        <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700 p-6">
            <h1 class="text-xl font-semibold text-gray-900 dark:text-white mb-6">
                Dossier médical du patient: ${medicalFile.patient.firstName} ${medicalFile.patient.lastName}
            </h1>

            <!-- Personal Info -->
            <section class="mb-6 p-5 bg-white dark:bg-gray-700 rounded-lg border border-gray-200 dark:border-gray-600">
                <h2 class="text-base font-medium text-gray-700 dark:text-gray-300 mb-3">Informations personnelles</h2>
                <ul class="space-y-2 text-sm text-gray-600 dark:text-gray-400">
                    <li><strong
                            class="text-gray-700 dark:text-gray-300">Nom:</strong> ${medicalFile.patient.firstName} ${medicalFile.patient.lastName}
                    </li>
                    <li><strong class="text-gray-700 dark:text-gray-300">Date de
                        naissance:</strong> ${medicalFile.patient.dateOfBirth}</li>
                    <li><strong class="text-gray-700 dark:text-gray-300">Numéro de
                        dossier:</strong> ${medicalFile.patient.dossierNumber}</li>
                    <li><strong
                            class="text-gray-700 dark:text-gray-300">Téléphone:</strong> ${medicalFile.patient.phone}
                    </li>
                </ul>
            </section>

            <!-- Vital Signs -->
            <section class="mb-6 p-5 bg-white dark:bg-gray-700 rounded-lg border border-gray-200 dark:border-gray-600">
                <h2 class="text-base font-medium text-gray-700 dark:text-gray-300 mb-3">Signes vitaux</h2>
                <ul class="grid grid-cols-1 md:grid-cols-2 gap-3 text-sm text-gray-600 dark:text-gray-400">
                    <li><strong class="text-gray-700 dark:text-gray-300">Tension
                        artérielle:</strong> ${medicalFile.bloodPresure}</li>
                    <li><strong
                            class="text-gray-700 dark:text-gray-300">Température:</strong> ${medicalFile.temperature}
                    </li>
                    <li><strong class="text-gray-700 dark:text-gray-300">Fréquence
                        respiratoire:</strong> ${medicalFile.respiratoryRate}</li>
                    <li><strong
                            class="text-gray-700 dark:text-gray-300">Poids/Taille:</strong> ${medicalFile.patient.weight}
                        kg / ${medicalFile.patient.height} cm
                    </li>
                </ul>
            </section>

            <!-- Previous Consultations -->
            <section class="mb-6 p-5 bg-white dark:bg-gray-700 rounded-lg border border-gray-200 dark:border-gray-600">
                <h2 class="text-base font-medium text-gray-700 dark:text-gray-300 mb-3">Consultations précédentes</h2>
                <div class="overflow-x-auto">
                    <table class="min-w-full border border-gray-200 dark:border-gray-600 rounded-lg">
                        <thead class="bg-gray-100 dark:bg-gray-700">
                        <tr>
                            <th class="px-4 py-2 text-left text-xs font-medium text-gray-700 dark:text-gray-300 uppercase tracking-wider">
                                Date
                            </th>
                            <th class="px-4 py-2 text-left text-xs font-medium text-gray-700 dark:text-gray-300 uppercase tracking-wider">
                                Motif
                            </th>
                            <th class="px-4 py-2 text-left text-xs font-medium text-gray-700 dark:text-gray-300 uppercase tracking-wider">
                                Observations
                            </th>
                            <th class="px-4 py-2 text-left text-xs font-medium text-gray-700 dark:text-gray-300 uppercase tracking-wider">
                                Statut
                            </th>
                        </tr>
                        </thead>
                        <tbody class="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
                        <c:forEach var="consultation" items="${consultations}">
                            <tr class="hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                                <td class="px-4 py-2 text-sm">${consultation.createdAt}</td>
                                <td class="px-4 py-2 text-sm">${consultation.reason}</td>
                                <td class="px-4 py-2 text-sm">${consultation.observations}</td>
                                <td class="px-4 py-2 text-sm">${consultation.consultationStatus}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty consultations}">
                            <tr>
                                <td colspan="4" class="px-4 py-4 text-sm text-gray-500 dark:text-gray-400 text-center">
                                    Aucune consultation enregistrée.
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Create New Consultation -->
            <section class="text-right">
                <form action="${pageContext.request.contextPath}/consultation" method="get" class="inline-block">
                    <input type="hidden" name="patientId" value="${medicalFile.patient.id}"/>
                    <button type="submit"
                            class="px-5 py-2 bg-blue-600 text-white text-sm font-medium rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 transition-colors">
                        Créer une nouvelle consultation
                    </button>
                </form>
            </section>
        </div>
    </div>
</main>

<%--<jsp:include page="footer.jsp" />--%>

<script>
    // Dark mode persistence
    if (localStorage.getItem('darkMode') === 'enabled' || (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
    }
</script>

</body>
</html>