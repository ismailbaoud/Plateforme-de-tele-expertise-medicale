<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.Ticket" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Person" %>
<%@ page import="com.medicale.consultation.consultationmedicale.enums.Role" %>

<%
    Person user = (Person) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
    List<Ticket> tickets = (List<Ticket>) request.getAttribute("tickets");
%>

<!DOCTYPE html>
<html lang="fr" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tickets du Jour</title>
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
    <link rel="preconnect" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet DL">
    <style>
        .badge { @apply px-3 py-1 rounded-full text-xs font-medium transition-colors; }
    </style>
</head>
<body class="bg-gray-50 dark:bg-gray-900 min-h-screen text-gray-800 dark:text-gray-200 transition-colors duration-300">

<jsp:include page="../../header.jsp" />

<main class="p-6 lg:p-8">
    <div class="max-w-5xl mx-auto">
        <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700 p-6">
            <div class="mb-6">
                <h1 class="text-2xl font-semibold text-gray-900 dark:text-white mb-1">Tickets du Jour</h1>
                <p class="text-sm text-gray-500 dark:text-gray-400">Tous les tickets créés aujourd'hui.</p>
            </div>

            <!-- Tickets Table -->
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                    <thead class="bg-gray-100 dark:bg-gray-700">
                    <tr>
                        <th class="py-3 px-4 text-left text-xs font-medium text-gray-700 dark:text-gray-300 uppercase tracking-wider">#</th>
                        <th class="py-3 px-4 text-left text-xs font-medium text-gray-700 dark:text-gray-300 uppercase tracking-wider">Dossier</th>
                        <th class="py-3 px-4 text-left text-xs font-medium text-gray-700 dark:text-gray-300 uppercase tracking-wider">Patient</th>
                        <th class="py-3 px-4 text-left text-xs font-medium text-gray-700 dark:text-gray-300 uppercase tracking-wider">Créé le</th>
                        <th class="py-3 px-4 text-center text-xs font-medium text-gray-700 dark:text-gray-300 uppercase tracking-wider">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
                    <%
                        if (tickets != null && !tickets.isEmpty()) {
                            for (Ticket t : tickets) {
                    %>
                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                        <td class="py-3 px-4 text-sm"><%= t.getId() %></td>
                        <td class="py-3 px-4 text-sm"><%= t.getPatient() != null ? t.getPatient().getDossierNumber() : "—" %></td>
                        <td class="py-3 px-4 text-sm"><%= t.getPatient() != null ? t.getPatient().getFirstName() + " " + t.getPatient().getLastName() : "—" %></td>
                        <td class="py-3 px-4 text-sm text-gray-500 dark:text-gray-400"><%= t.getCreatedAt() %></td>
                        <td class="py-3 px-4 text-center">
                            <div class="flex justify-center gap-2">
                                <a href="${pageContext.request.contextPath}/medicalFiles?id=<%=t.getPatient().getId()%>"
                                   class="badge bg-blue-100 dark:bg-blue-900 text-blue-800 dark:text-blue-200 hover:bg-blue-200 dark:hover:bg-blue-800">
                                    Voir
                                </a>
                                <%
                                    if (user != null && user.getRole() == Role.NURSE) {
                                %>
                                <a href="${pageContext.request.contextPath}/editTicket?id=<%=t.getId()%>"
                                   class="badge bg-cyan-100 dark:bg-cyan-900 text-cyan-800 dark:text-cyan-200 hover:bg-cyan-200 dark:hover:bg-cyan-800">
                                    Modifier60">
                                    Modifier
                                </a>
                                <a href="${pageContext.request.contextPath}/deleteTicket?id=<%=t.getId()%>"
                                   class="badge bg-red-100 dark:bg-red-900 text-red-worthiness-800 dark:text-red-200 hover:bg-red-200 dark:hover:bg-red-800"
                                   onclick="return confirm('Supprimer ce ticket ?');">
                                    Supprimer
                                </a>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5" class="py-6 text-center text-sm text-gray-500 dark:text-gray-400">Aucun ticket créé aujourd'hui.</td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

<jsp:include page="../../footer.jsp" />

<script>
    // Dark mode persistence
    if (localStorage.getItem('darkMode') === 'enabled' || (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
    }
</script>

</body>
</html>