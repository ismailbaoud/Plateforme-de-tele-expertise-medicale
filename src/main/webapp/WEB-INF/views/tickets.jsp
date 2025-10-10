<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.Ticket" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Person" %>
<%@ page import="com.medicale.consultation.consultationmedicale.enums.Role" %>

<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Tickets</title>

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

        .table-header {
            background: linear-gradient(to right, #2563eb, #06b6d4);
            color: white;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 to-cyan-100 min-h-screen p-6 flex flex-col items-center">

<!-- Header -->
<div class="bg-white rounded-2xl shadow-2xl w-full max-w-5xl p-8 mb-8">
    <div class="flex items-center space-x-4 mb-6">
        <div class="bg-blue-100 text-blue-600 p-3 rounded-full">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24"
                 stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M9 17v-6h13V7a2 2 0 00-2-2H5a2 2 0 00-2 2v13a2 2 0 002 2h6v-5h2v5h8a2 2 0 002-2v-1H9z"/>
            </svg>
        </div>
        <div>
            <h1 class="text-3xl font-bold text-gray-800">Liste des Tickets</h1>
            <p class="text-gray-500 mt-1">Tickets créés aujourd'hui</p>
        </div>
    </div>

    <!-- Table Container -->
    <div class="overflow-x-auto rounded-xl border border-gray-200 shadow-sm">
        <table class="min-w-full text-left text-gray-700">
            <thead class="table-header">
            <tr>
                <th class="py-3 px-6 text-sm font-semibold">#</th>
                <th class="py-3 px-6 text-sm font-semibold">Dossier</th>
                <th class="py-3 px-6 text-sm font-semibold">Patient</th>
                <th class="py-3 px-6 text-sm font-semibold">Créé le</th>

                <th class="py-3 px-6 text-sm font-semibold text-center">Actions</th>

            </tr>
            </thead>
            <tbody class="divide-y divide-gray-200 bg-white">
            <%
                List<Ticket> tickets = (List<Ticket>) request.getAttribute("tickets");
                if (tickets != null && !tickets.isEmpty()) {
                    for (Ticket t : tickets) {
            %>
            <tr class="hover:bg-blue-50 transition-colors">
                <td class="py-3 px-6"><%= t.getId() %>
                </td>
                <td class="py-3 px-6 font-medium"><%= t.getPatient().getDossierNumber() %>
                </td>
                <td class="py-3 px-6 text-gray-600">
                    <%= t.getPatient() != null ? t.getPatient().getFirstName() + " " + t.getPatient().getLastName() : "—" %>
                </td>
                <td class="py-3 px-6 text-gray-500"><%= t.getCreatedAt() %>
                </td>

                <td class="py-3 px-6 text-center space-x-2">
                    <a href="${pageContext.request.contextPath}/medicalFiles?id=<%=t.getId()%>"
                       class="text-blue-600 hover:text-blue-800 font-medium">Voir</a>
                    <%
                        Person user = (Person) session.getAttribute("user");
                        if (user != null && user.getRole() == Role.NURSE) {
                    %>
                    <a href="${pageContext.request.contextPath}/editTicket?id=<%=t.getId()%>"
                       class="text-cyan-600 hover:text-cyan-800 font-medium">Modifier</a>
                    <a href="${pageContext.request.contextPath}/deleteTicket?id=<%=t.getId()%>"
                       class="text-red-600 hover:text-red-800 font-medium"
                       onclick="return confirm('Supprimer ce ticket ?');">Supprimer</a> <%
                    }
                %>


                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5" class="py-6 text-center text-gray-500">Aucun ticket créé aujourd'hui.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
