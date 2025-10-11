<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.Ticket" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Person" %>
<%@ page import="com.medicale.consultation.consultationmedicale.enums.Role" %>

<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tickets du Jour</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
        .table-header { background: linear-gradient(to right, #2563eb, #06b6d4); color: white; }
        .badge { @apply px-3 py-1 rounded-full text-xs font-semibold; }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 to-cyan-100 min-h-screen p-4">

<div class="max-w-5xl mx-auto">
    <!-- Header -->
    <div class="mb-6 text-center">
        <h1 class="text-3xl font-bold text-gray-800 mb-1">Tickets du Jour</h1>
        <p class="text-gray-500">Tous les tickets créés aujourd'hui</p>
    </div>

    <!-- Tickets Table -->
    <div class="overflow-x-auto bg-white rounded-xl shadow-lg border border-gray-200">
        <table class="min-w-full text-left text-gray-700">
            <thead class="table-header">
            <tr>
                <th class="py-3 px-4 text-sm font-semibold">#</th>
                <th class="py-3 px-4 text-sm font-semibold">Dossier</th>
                <th class="py-3 px-4 text-sm font-semibold">Patient</th>
                <th class="py-3 px-4 text-sm font-semibold">Créé le</th>
                <th class="py-3 px-4 text-sm font-semibold text-center">Actions</th>
            </tr>
            </thead>
            <tbody class="divide-y divide-gray-200 bg-white">
            <%
                List<Ticket> tickets = (List<Ticket>) request.getAttribute("tickets");
                if (tickets != null && !tickets.isEmpty()) {
                    for (Ticket t : tickets) {
            %>
            <tr class="hover:bg-blue-50 transition-colors">
                <td class="py-3 px-4 font-medium"><%= t.getId() %></td>
                <td class="py-3 px-4"><%= t.getPatient() != null ? t.getPatient().getDossierNumber() : "—" %></td>
                <td class="py-3 px-4"><%= t.getPatient() != null ? t.getPatient().getFirstName() + " " + t.getPatient().getLastName() : "—" %></td>
                <td class="py-3 px-4 text-gray-500"><%= t.getCreatedAt() %></td>
                <td class="py-3 px-4 text-center flex justify-center gap-2">
                    <a href="${pageContext.request.contextPath}/medicalFiles?id=<%=t.getId()%>"
                       class="badge bg-blue-100 text-blue-800 hover:bg-blue-200 transition">Voir</a>
                    <%
                        Person user = (Person) session.getAttribute("user");
                        if (user != null && user.getRole() == Role.NURSE) {
                    %>
                    <a href="${pageContext.request.contextPath}/editTicket?id=<%=t.getId()%>"
                       class="badge bg-cyan-100 text-cyan-800 hover:bg-cyan-200 transition">Modifier</a>
                    <a href="${pageContext.request.contextPath}/deleteTicket?id=<%=t.getId()%>"
                       class="badge bg-red-100 text-red-800 hover:bg-red-200 transition"
                       onclick="return confirm('Supprimer ce ticket ?');">Supprimer</a>
                    <% } %>
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
