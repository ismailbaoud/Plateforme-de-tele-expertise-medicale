<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ajouter un Acte Médical</title>

    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<div class="max-w-3xl mx-auto mt-10 bg-white rounded-2xl shadow-lg p-8">
    <h1 class="text-3xl font-bold text-cyan-700 mb-8 text-center">
        ➕ Ajouter un Nouvel Acte Médical
    </h1>

    <%-- The form is submitted to a servlet responsible for saving the new act --%>
    <%-- Replace "saveMedicalAct" with your actual servlet mapping/URL --%>
    <form action="medicalActs?action=create&id=${consultationId}" method="POST" class="space-y-6">

        <%-- Hidden field to associate the act with a consultation (if applicable) --%>
        <%-- Assuming 'consultationId' is passed as a request attribute --%>
        <input type="hidden" name="consultationId" value="${consultationId}">

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

            <%-- Field for Label --%>
            <div class="col-span-1">
                <label for="label" class="block text-sm font-medium text-gray-700 mb-1">
                    Libellé de l'Acte
                </label>
                <input type="text" id="label" name="label" required
                       class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-cyan-500 focus:border-cyan-500 transition duration-150">
            </div>

            <%-- Field for Price --%>
            <div class="col-span-1">
                <label for="price" class="block text-sm font-medium text-gray-700 mb-1">
                    Prix (€ ou Monnaie Locale)
                </label>
                <input type="number" id="price" name="price" step="0.01" min="0" required
                       class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-cyan-500 focus:border-cyan-500 transition duration-150">
            </div>

        </div>

        <hr class="mt-8 mb-4">

        <div class="flex justify-between items-center mt-6">

            <%-- Submission Button --%>
            <button type="submit"
                    class="bg-cyan-600 hover:bg-cyan-700 text-white font-semibold py-3 px-6 rounded-lg shadow-md transition duration-300 transform hover:scale-105 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-cyan-500">
                💾 Enregistrer l'Acte
            </button>

            <%-- Cancel/Back Link --%>
            <a href="consultationDetails?id=${consultationId}"
               class="text-gray-500 hover:text-gray-700 font-medium transition duration-200">
                ⬅️ Annuler et Retour
            </a>
        </div>
    </form>
</div>

</body>
</html>