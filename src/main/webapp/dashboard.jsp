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
<html lang="fr" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | <%= user.getFirstName() %> <%= user.getLastName() %></title>
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
    <style>
        .modal-enter { opacity: 0; transform: scale(0.95); }
        .modal-enter-active { opacity: 1; transform: scale(1); transition: all 200ms ease-out; }
        .modal-exit-active { opacity: 0; transform: scale(0.95); transition: all 200ms ease-in; }
    </style>
</head>
<body class="bg-gray-50 dark:bg-gray-900 flex flex-col min-h-screen text-gray-800 dark:text-gray-200 transition-colors duration-300">

<jsp:include page="header.jsp" />

<main class="flex-grow p-6 lg:p-8">
    <div class="max-w-7xl mx-auto">
        <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm p-6 md:p-8 border border-gray-200 dark:border-gray-700">
            <h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-2">
                Bienvenue, <%= user.getFirstName() %> <%= user.getLastName() %>
            </h2>
            <p class="text-sm text-gray-500 dark:text-gray-400 mb-8">Votre tableau de bord personnalisé.</p>

            <div class="space-y-6">
                <% if (role == Role.ADMIN) { %>
                <div class="bg-white dark:bg-gray-700 rounded-lg p-6 border border-gray-200 dark:border-gray-600">
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">Panneau d'Administration</h3>
                    <p class="text-sm text-gray-600 dark:text-gray-400">Gérer les utilisateurs, consulter les rapports et configurer le système.</p>
                </div>
                <% } else if (role == Role.NURSE) { %>
                <div class="bg-white dark:bg-gray-700 rounded-lg p-6 border border-gray-200 dark:border-gray-600">
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">Tableau de bord Infirmière</h3>
                    <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">Vous pouvez rechercher un patient et saisir ses signes vitaux.</p>
                    <button id="openPatientModal"
                            class="px-5 py-2 bg-blue-600 text-white text-sm font-medium rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 transition-colors">
                        Rechercher / Enregistrer un patient
                    </button>
                    <button class="ml-4 px-5 py-2 bg-blue-600 text-white text-sm font-medium rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 transition-colors">
                        <a href="/allTickets?action=allTickets" class="text-white">tickets</a>
                    </button>
                </div>
                <% } else if (role == Role.GENERALIST) { %>
                <div class="bg-white dark:bg-gray-700 rounded-lg p-6 border border-gray-200 dark:border-gray-600">
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">Tableau de bord Généraliste</h3>
                    <p class="text-sm text-gray-600 dark:text-gray-400">Gérer les consultations générales et les dossiers patients.</p>
                    <button class="px-5 py-2 bg-blue-600 text-white text-sm font-medium rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 transition-colors">
                        <a href="/allTickets?action=allTickets" class="text-white">tickets</a>
                    </button>
                </div>
                <% } else if (role == Role.SPECIALIST) { %>
                <div class="bg-white dark:bg-gray-700 rounded-lg p-6 border border-gray-200 dark:border-gray-600">
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">Tableau de bord Spokesman</h3>
                    <p class="text-sm text-gray-600 dark:text-gray-400">Gérer les consultations spécialisées et les soins avancés.</p>
                </div>
                <% } else if (role == Role.PATIENT) { %>
                <div class="bg-white dark:bg-gray-700 rounded-lg p-6 border border-gray-200 dark:border-gray-600">
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">Tableau de bord Patient</h3>
                    <p class="text-sm text-gray-600 dark:text-gray-400">Voir vos dossiers médicaux, rendez-vous et prescriptions.</p>
                </div>
                <% } else { %>
                <div class="bg-white dark:bg-gray-700 rounded-lg p-6 border border-gray-200 dark:border-gray-600">
                    <p class="text-sm text-gray-600 dark:text-gray-400">Rôle inconnu.</p>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</main>

<!-- Modal -->
<div id="patientModal" class="hidden fixed inset-0 bg-black bg-opacity-50 dark:bg-opacity-70 flex items-center justify-center z-50 p-4">
    <div class="bg-white dark:bg-gray-800 rounded-lg w-full max-w-md p-6 shadow-lg modal-enter" id="modal-content">
        <button id="closeModal" class="absolute top-3 right-3 text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-200" aria-label="Fermer">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
        </button>
        <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-5">Rechercher un Patient</h3>
        <form id="patientForm" method="post" action="savePatientOrVitals?action=findPatient" class="space-y-5">
            <div>
                <label for="fullName" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Nom complet</label>
                <input type="text" id="fullName" name="fullName" placeholder="Prénom Nom" required class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md focus:ring-1 focus:ring-blue-500 focus:border-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white">
            </div>
            <button type="submit" class="w-full px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors">
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
        setTimeout(() => modalContent.classList.add('modal-enter-active'), 10);
    };

    const closeModalFunc = () => {
        modalContent.classList.remove('modal-enter-active');
        modalContent.classList.add('modal-exit-active');
        setTimeout(() => modal.classList.add('hidden'), 200);
    };

    openBtn?.addEventListener('click', openModal);
    closeBtn?.addEventListener('click', closeModalFunc);
    modal?.addEventListener('click', (e) => { if (e.target === modal) closeModalFunc(); });

    // Dark mode persistence
    if (localStorage.getItem('darkMode') === 'enabled' || (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
    }
</script>

</body>
</html>