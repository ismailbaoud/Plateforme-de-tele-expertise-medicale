<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Créer une Consultation</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<div class="max-w-3xl mx-auto mt-10 bg-white rounded-2xl shadow-lg p-8">
    <h1 class="text-3xl font-bold text-cyan-700 mb-6 text-center">
        Créer une Nouvelle Consultation
    </h1>

    <form action="createConsultation" method="post" class="space-y-6">

        <!-- Date -->
<%--        <div>--%>
<%--            <label for="createdAt" class="block text-gray-700 font-medium mb-2">Date de Consultation</label>--%>
<%--            <input type="date" id="createdAt" name="createdAt" required--%>
<%--                   class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-cyan-500">--%>
<%--        </div>--%>

        <!-- Status -->
<%--        <div>--%>
<%--            <label for="consultationStatus" class="block text-gray-700 font-medium mb-2">Statut de la Consultation</label>--%>
<%--            <select id="consultationStatus" name="consultationStatus" required--%>
<%--                    class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-cyan-500">--%>
<%--                <option value="">-- Sélectionner un statut --</option>--%>
<%--                <option value="SCHEDULED">Planifiée</option>--%>
<%--                <option value="ONGOING">En cours</option>--%>
<%--                <option value="COMPLETED">Terminée</option>--%>
<%--                <option value="CANCELLED">Annulée</option>--%>
<%--            </select>--%>
<%--        </div>--%>

        <!-- Medical File -->
<%--        <div>--%>
<%--            <label for="medicalFileId" class="block text-gray-700 font-medium mb-2">Fichier Médical</label>--%>
<%--            <select id="medicalFileId" name="medicalFileId" --%>
<%--                    class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-cyan-500">--%>
<%--                <option value="">-- Sélectionner un fichier médical --</option>--%>
<%--&lt;%&ndash;                <c:forEach var="file" items="${medicalFiles}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <option value="${file.id}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            ${file.patient.name} (ID: ${file.id})&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </option>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </c:forEach>&ndash;%&gt;--%>
<%--            </select>--%>
<%--        </div>--%>

        <!-- Generalist -->
<%--        <div>--%>
<%--            <label for="generalistId" class="block text-gray-700 font-medium mb-2">Médecin Généraliste</label>--%>
<%--            <select id="generalistId" name="generalistId"--%>
<%--                    class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-cyan-500">--%>
<%--                <option value="">-- Sélectionner un généraliste --</option>--%>
<%--&lt;%&ndash;                <c:forEach var="generalist" items="${generalists}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <option value="${generalist.id}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        Dr. ${generalist.name}&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </option>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </c:forEach>&ndash;%&gt;--%>
<%--            </select>--%>
<%--        </div>--%>

        <!-- Submit -->
        <div class="text-center">
            <button type="submit"
                    class="bg-cyan-600 hover:bg-cyan-700 text-white font-semibold py-2 px-6 rounded-xl shadow-md transition duration-200">
                <a href="consultation?action=create"> ✅ Créer la Consultation </a>
            </button>
        </div>

    </form>

    <div class="mt-6 text-center">
        <a href="consultations"
           class="text-gray-500 hover:text-gray-700 font-medium transition duration-200">
            ⬅️ Retour à la liste des consultations
        </a>
    </div>
</div>

</body>
</html>
