<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Person" %>
<%@ page import="com.medicale.consultation.consultationmedicale.enums.Role" %>

<%
    Person user = (Person) session.getAttribute("user");
    Role role = (Role) session.getAttribute("role");

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
    <title>Dashboard | <%= user.getFirstName() %></title>
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
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 to-cyan-100 flex flex-col min-h-screen">

<jsp:include page="header.jsp" />

<main class="flex-grow p-4 sm:p-6 lg:p-8">
    <div class="max-w-7xl mx-auto">
        <div class="bg-white/70 backdrop-blur-sm rounded-2xl shadow-lg p-6 md:p-8 border border-gray-200">
            <h2 class="text-3xl font-bold text-gray-800 mb-2">
                Bienvenue, <%= user.getFirstName() %> <%= user.getLastName() %>
            </h2>
            <p class="text-gray-600 mb-8">Votre tableau de bord personnalisé.</p>

            <%-- Role-based content --%>
            <div class="space-y-6">
                <% if (role == Role.ADMIN) { %>
                <div class="bg-white rounded-xl shadow-md p-6 border border-gray-100">
                    <h3 class="text-xl font-bold text-gray-800 mb-2">Panneau d'Administration</h3>
                    <p class="text-gray-600">Gérer les utilisateurs, consulter les rapports et configurer le système.</p>
                </div>
                <% } else if (role == Role.NURSE) { %>
                <div class="bg-white rounded-xl shadow-md p-6 border border-gray-100">
                    <h3 class="text-xl font-bold text-gray-800 mb-2">Tableau de bord Infirmière</h3>
                    <p class="text-gray-600 mb-4">Vous pouvez rechercher un patient et saisir ses signes vitaux.</p>
                    <button id="openPatientModal"
                            class="inline-flex items-center bg-gradient-to-r from-blue-600 to-cyan-500 text-white font-semibold px-6 py-2 rounded-lg hover:from-blue-700 hover:to-cyan-600 focus:outline-none focus:ring-4 focus:ring-blue-300 transition-all duration-300 transform hover:scale-105 shadow-md">
                        Rechercher / Enregistrer un patient
                    </button>
                    <button
                            class="inline-flex items-center bg-gradient-to-r from-blue-600 to-cyan-500 text-white font-semibold px-6 py-2 rounded-lg hover:from-blue-700 hover:to-cyan-600 focus:outline-none focus:ring-4 focus:ring-blue-300 transition-all duration-300 transform hover:scale-105 shadow-md">
                        <a href="/allTickets?action=allTickets">tickets</a>
                    </button>
                </div>
                <% } else if (role == Role.GENERALIST) { %>
                <div class="bg-white rounded-xl shadow-md p-6 border border-gray-100">
                    <h3 class="text-xl font-bold text-gray-800 mb-2">Tableau de bord Généraliste</h3>
                    <p class="text-gray-600">Gérer les consultations générales et les dossiers patients.</p>
                    <button
                            class="inline-flex items-center bg-gradient-to-r from-blue-600 to-cyan-500 text-white font-semibold px-6 py-2 rounded-lg hover:from-blue-700 hover:to-cyan-600 focus:outline-none focus:ring-4 focus:ring-blue-300 transition-all duration-300 transform hover:scale-105 shadow-md">
                        <a href="/allTickets?action=allTickets">tickets</a>
                    </button>
                </div>
                <% } else if (role == Role.SPECIALIST) { %>
                <div class="bg-white rounded-xl shadow-md p-6 border border-gray-100">
                    <h3 class="text-xl font-bold text-gray-800 mb-2">Tableau de bord Spécialiste</h3>
                    <p class="text-gray-600">Gérer les consultations spécialisées et les soins avancés.</p>
                </div>
                <% } else if (role == Role.PATIENT) { %>
                <div class="bg-white rounded-xl shadow-md p-6 border border-gray-100">
                    <h3 class="text-xl font-bold text-gray-800 mb-2">Tableau de bord Patient</h3>
                    <p class="text-gray-600">Voir vos dossiers médicaux, rendez-vous et prescriptions.</p>
                </div>
                <% } else { %>
                <div class="bg-white rounded-xl shadow-md p-6 border border-gray-100">
                    <p class="text-gray-600">Rôle inconnu.</p>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</main>

<!-- Modal -->
<div id="patientModal" class="hidden fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-50 p-4 transition-opacity duration-300">
    <div class="bg-white rounded-2xl w-full max-w-md p-8 shadow-2xl transform transition-all duration-300 scale-95 opacity-0" id="modal-content">
        <button id="closeModal" class="absolute top-4 right-4 text-gray-400 hover:text-gray-600 transition-colors">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
            </svg>
        </button>
        <h3 class="text-2xl font-bold text-gray-800 mb-6 text-center">Rechercher un Patient</h3>
        <form id="patientForm" method="post" action="savePatientOrVitals?action=findPatient" class="space-y-6">
            <div>
                <label for="fullName" class="block text-sm font-semibold text-gray-600 mb-1">Nom complet</label>
                <input type="text" id="fullName" name="fullName" placeholder="Prénom Nom" required
                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-300 bg-gray-50">
            </div>
            <button type="submit"
                    class="w-full bg-gradient-to-r from-blue-600 to-cyan-500 text-white font-bold py-3 rounded-lg hover:from-blue-700 hover:to-cyan-600 focus:outline-none focus:ring-4 focus:ring-blue-300 transition-all duration-300 transform hover:scale-105 shadow-lg">
                Rechercher
            </button>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script>
    const modal = document.getElementById('patientModal');
    const modalContent = document.getElementById('modal-content');
    const openBtn = document.getElementById('openPatientModal');
    const closeBtn = document.getElementById('closeModal');

    const openModal = () => {
        modal.classList.remove('hidden');
        setTimeout(() => {
            modal.style.opacity = '1';
            modalContent.classList.remove('scale-95', 'opacity-0');
        }, 10);
    };

    const closeModal = () => {
        modalContent.classList.add('scale-95', 'opacity-0');
        modal.style.opacity = '0';
        setTimeout(() => {
            modal.classList.add('hidden');
        }, 300);
    };

    openBtn?.addEventListener('click', openModal);
    closeBtn?.addEventListener('click', closeModal);
    modal?.addEventListener('click', (event) => {
        if (event.target === modal) {
            closeModal();
        }
    });
</script>

</body>
</html>
