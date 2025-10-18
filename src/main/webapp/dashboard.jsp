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
    <title>Dashboard | <%= user.getFirstName() %> <%= user.getLastName() %></title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in-up { animation: fadeInUp 0.6s ease-out forwards; }
        .delay-1 { animation-delay: 0.1s; opacity: 0; }
        .delay-2 { animation-delay: 0.2s; opacity: 0; }
        .delay-3 { animation-delay: 0.3s; opacity: 0; }
        .delay-4 { animation-delay: 0.4s; opacity: 0; }
        .stat-card { transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); }
        .stat-card:hover { transform: translateY(-4px) scale(1.02); }
    </style>
</head>
<body class="bg-white dark:bg-slate-900 min-h-screen">
<!-- Diagonal Grid Background -->
<div class="fixed inset-0 diagonal-grid"></div>

<!-- Header -->
<jsp:include page="header.jsp" />

<!-- Main Content -->
<main class="relative z-10 min-h-screen p-6 lg:p-8">
    <div class="max-w-7xl mx-auto">
        <!-- Welcome Card -->
        <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 p-8 mb-8 fade-in-up">
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-6">
                <div class="flex items-center gap-4">
                    <div class="w-16 h-16 bg-gradient-to-br from-teal-500 to-teal-600 rounded-2xl flex items-center justify-center shadow-lg shadow-teal-500/30 animate-pulse">
                        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                        </svg>
                    </div>
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900 dark:text-white">
                            Bienvenue, <%= user.getFirstName() %> <%= user.getLastName() %>
                        </h1>
                        <p class="text-gray-600 dark:text-gray-400 mt-1">Votre tableau de bord personnalisé</p>
                    </div>
                </div>
                <div class="inline-flex items-center gap-2 px-4 py-2.5 bg-teal-50 dark:bg-teal-900/30 border border-teal-200 dark:border-teal-800 rounded-xl">
                    <svg class="w-5 h-5 text-teal-600 dark:text-teal-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z" />
                    </svg>
                    <span class="text-sm font-semibold text-teal-700 dark:text-teal-300"><%= role.toString() %></span>
                </div>
            </div>
        </div>

        <!-- Role-Based Content -->
        <% if (role == Role.ADMIN) { %>
        <!-- Admin dashboard with management-focused design -->
        <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 overflow-hidden fade-in-up delay-1">
            <div class="bg-gradient-to-r from-purple-600 to-purple-700 p-8 text-white">
                <div class="flex items-center gap-4">
                    <div class="w-14 h-14 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center">
                        <svg class="w-7 h-7" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                        </svg>
                    </div>
                    <div>
                        <h2 class="text-2xl font-bold mb-1">Panneau d'Administration</h2>
                        <p class="text-purple-100">Gérer les utilisateurs, consulter les rapports et configurer le système</p>
                    </div>
                </div>
            </div>
            <div class="p-8">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div class="stat-card p-6 bg-gradient-to-br from-purple-50 to-purple-100 dark:from-purple-900/20 dark:to-purple-800/20 rounded-2xl border-2 border-purple-200 dark:border-purple-800 shadow-lg">
                        <div class="flex items-center justify-between mb-3">
                            <div class="w-12 h-12 bg-purple-600 rounded-xl flex items-center justify-center shadow-lg">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
                                </svg>
                            </div>
                            <div class="text-xs font-semibold text-purple-700 dark:text-purple-300 bg-purple-200 dark:bg-purple-900/50 px-3 py-1 rounded-full">+12%</div>
                        </div>
                        <div class="text-3xl font-bold text-purple-600 dark:text-purple-400 mb-1">248</div>
                        <div class="text-sm font-medium text-gray-700 dark:text-gray-300">Utilisateurs actifs</div>
                    </div>

                    <div class="stat-card p-6 bg-gradient-to-br from-blue-50 to-blue-100 dark:from-blue-900/20 dark:to-blue-800/20 rounded-2xl border-2 border-blue-200 dark:border-blue-800 shadow-lg">
                        <div class="flex items-center justify-between mb-3">
                            <div class="w-12 h-12 bg-blue-600 rounded-xl flex items-center justify-center shadow-lg">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                </svg>
                            </div>
                            <div class="text-xs font-semibold text-blue-700 dark:text-blue-300 bg-blue-200 dark:bg-blue-900/50 px-3 py-1 rounded-full">+8%</div>
                        </div>
                        <div class="text-3xl font-bold text-blue-600 dark:text-blue-400 mb-1">1,429</div>
                        <div class="text-sm font-medium text-gray-700 dark:text-gray-300">Consultations ce mois</div>
                    </div>
                    
                    <div class="stat-card p-6 bg-gradient-to-br from-green-50 to-green-100 dark:from-green-900/20 dark:to-green-800/20 rounded-2xl border-2 border-green-200 dark:border-green-800 shadow-lg">
                        <div class="flex items-center justify-between mb-3">
                            <div class="w-12 h-12 bg-green-600 rounded-xl flex items-center justify-center shadow-lg">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                            </div>
                            <div class="text-xs font-semibold text-green-700 dark:text-green-300 bg-green-200 dark:bg-green-900/50 px-3 py-1 rounded-full">+2.5%</div>
                        </div>
                        <div class="text-3xl font-bold text-green-600 dark:text-green-400 mb-1">98.5%</div>
                        <div class="text-sm font-medium text-gray-700 dark:text-gray-300">Taux de satisfaction</div>
                    </div>
                </div>
            </div>
        </div>

        <% } else if (role == Role.NURSE) { %>
        <!-- Nurse dashboard with patient care focus and quick actions -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <!-- Main Action Card -->
            <div class="lg:col-span-2 bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 overflow-hidden fade-in-up delay-1">
                <div class="bg-gradient-to-br from-blue-500 via-blue-600 to-cyan-600 p-8 text-white">
                    <div class="flex items-start justify-between mb-6">
                        <div>
                            <h2 class="text-2xl font-bold mb-2">Gestion des Patients</h2>
                            <p class="text-blue-100">Rechercher et enregistrer les signes vitaux</p>
                        </div>
                        <div class="w-12 h-12 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                            </svg>
                        </div>
                    </div>
                    <button id="openPatientModal" class="w-full flex items-center justify-center gap-3 px-6 py-4 bg-white text-blue-600 font-semibold rounded-2xl shadow-lg hover:shadow-xl hover:-translate-y-1 transition-all">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                        <span>Rechercher / Enregistrer un Patient</span>
                    </button>
                </div>

                <div class="p-8">
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Actions Rapides</h3>
                    <div class="grid grid-cols-2 gap-4">
                        <div class="stat-card group p-5 bg-gradient-to-br from-teal-50 to-cyan-50 dark:from-teal-900/20 dark:to-cyan-900/20 rounded-2xl border-2 border-teal-200 dark:border-teal-800 cursor-pointer">
                            <div class="w-12 h-12 bg-gradient-to-br from-teal-600 to-teal-700 rounded-xl flex items-center justify-center mb-3 shadow-lg group-hover:scale-110 transition-transform">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
                                </svg>
                            </div>
                            <div class="text-sm font-semibold text-gray-900 dark:text-white mb-1">Signes Vitaux</div>
                            <div class="text-xs text-gray-600 dark:text-gray-400">Enregistrer les mesures</div>
                        </div>

                        <div class="stat-card group p-5 bg-gradient-to-br from-purple-50 to-pink-50 dark:from-purple-900/20 dark:to-pink-900/20 rounded-2xl border-2 border-purple-200 dark:border-purple-800 cursor-pointer">
                            <div class="w-12 h-12 bg-gradient-to-br from-purple-600 to-purple-700 rounded-xl flex items-center justify-center mb-3 shadow-lg group-hover:scale-110 transition-transform">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                </svg>
                            </div>
                            <div class="text-sm font-semibold text-gray-900 dark:text-white mb-1">Dossier Patient</div>
                            <div class="text-xs text-gray-600 dark:text-gray-400">Consulter l'historique</div>
                        </div>

                        <div class="stat-card group p-5 bg-gradient-to-br from-orange-50 to-amber-50 dark:from-orange-900/20 dark:to-amber-900/20 rounded-2xl border-2 border-orange-200 dark:border-orange-800 cursor-pointer">
                            <div class="w-12 h-12 bg-gradient-to-br from-orange-600 to-orange-700 rounded-xl flex items-center justify-center mb-3 shadow-lg group-hover:scale-110 transition-transform">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                            </div>
                            <div class="text-sm font-semibold text-gray-900 dark:text-white mb-1">Rendez-vous</div>
                            <div class="text-xs text-gray-600 dark:text-gray-400">Planifier</div>
                        </div>

                        <div class="stat-card group p-5 bg-gradient-to-br from-green-50 to-emerald-50 dark:from-green-900/20 dark:to-emerald-900/20 rounded-2xl border-2 border-green-200 dark:border-green-800 cursor-pointer">
                            <div class="w-12 h-12 bg-gradient-to-br from-green-600 to-green-700 rounded-xl flex items-center justify-center mb-3 shadow-lg group-hover:scale-110 transition-transform">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                            </div>
                            <div class="text-sm font-semibold text-gray-900 dark:text-white mb-1">Tâches</div>
                            <div class="text-xs text-gray-600 dark:text-gray-400">5 aujourd'hui</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tickets Sidebar -->
            <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 p-6 fade-in-up delay-2">
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white">Tickets</h3>
                    <div class="w-8 h-8 bg-blue-100 dark:bg-blue-900/30 rounded-lg flex items-center justify-center">
                        <svg class="w-4 h-4 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z" />
                        </svg>
                    </div>
                </div>

                <div class="space-y-3 mb-6">
                    <div class="stat-card p-5 bg-gradient-to-br from-yellow-50 to-yellow-100 dark:from-yellow-900/20 dark:to-yellow-800/20 rounded-2xl border-2 border-yellow-200 dark:border-yellow-800">
                        <div class="flex items-center justify-between mb-2">
                            <span class="text-xs font-bold text-yellow-700 dark:text-yellow-400 uppercase tracking-wide">En Attente</span>
                            <span class="text-2xl font-black text-yellow-600 dark:text-yellow-400">12</span>
                        </div>
                        <div class="w-full bg-yellow-200 dark:bg-yellow-900/50 rounded-full h-2">
                            <div class="bg-yellow-600 dark:bg-yellow-500 h-2 rounded-full" style="width: 60%"></div>
                        </div>
                    </div>

                    <div class="stat-card p-5 bg-gradient-to-br from-blue-50 to-blue-100 dark:from-blue-900/20 dark:to-blue-800/20 rounded-2xl border-2 border-blue-200 dark:border-blue-800">
                        <div class="flex items-center justify-between mb-2">
                            <span class="text-xs font-bold text-blue-700 dark:text-blue-400 uppercase tracking-wide">En Cours</span>
                            <span class="text-2xl font-black text-blue-600 dark:text-blue-400">8</span>
                        </div>
                        <div class="w-full bg-blue-200 dark:bg-blue-900/50 rounded-full h-2">
                            <div class="bg-blue-600 dark:bg-blue-500 h-2 rounded-full" style="width: 40%"></div>
                        </div>
                    </div>

                    <div class="stat-card p-5 bg-gradient-to-br from-green-50 to-green-100 dark:from-green-900/20 dark:to-green-800/20 rounded-2xl border-2 border-green-200 dark:border-green-800">
                        <div class="flex items-center justify-between mb-2">
                            <span class="text-xs font-bold text-green-700 dark:text-green-400 uppercase tracking-wide">Terminés</span>
                            <span class="text-2xl font-black text-green-600 dark:text-green-400">45</span>
                        </div>
                        <div class="text-xs text-gray-600 dark:text-gray-400 mt-1">Cette semaine</div>
                    </div>
                </div>

                <a href="${pageContext.request.contextPath}/allTickets" class="flex items-center justify-center gap-2 w-full py-3.5 bg-gradient-to-r from-blue-600 to-cyan-600 hover:from-blue-700 hover:to-cyan-700 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all">
                    <span>Voir tous les tickets</span>
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                    </svg>
                </a>
            </div>
        </div>

        <% } else if (role == Role.GENERALIST) { %>
        <!-- Generalist dashboard with consultation-focused layout -->
        <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 overflow-hidden fade-in-up delay-1">
            <div class="p-8 border-b border-gray-200 dark:border-slate-700">
                <div class="flex items-center gap-4 mb-6">
                    <div class="w-16 h-16 bg-gradient-to-br from-green-500 to-emerald-600 rounded-2xl flex items-center justify-center shadow-lg shadow-green-500/30">
                        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                        </svg>
                    </div>
                    <div>
                        <h2 class="text-2xl font-bold text-gray-900 dark:text-white mb-1">Médecin Généraliste</h2>
                        <p class="text-gray-600 dark:text-gray-400">Gérer les consultations et dossiers patients</p>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div class="stat-card p-5 bg-gradient-to-br from-green-50 to-emerald-100 dark:from-green-900/20 dark:to-emerald-800/20 rounded-2xl border-2 border-green-200 dark:border-green-800 shadow-lg">
                        <div class="flex items-center gap-3 mb-2">
                            <div class="w-12 h-12 bg-gradient-to-br from-green-600 to-green-700 rounded-xl flex items-center justify-center shadow-lg">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
                                </svg>
                            </div>
                            <div class="text-3xl font-black text-green-600 dark:text-green-400">24</div>
                        </div>
                        <div class="text-sm font-semibold text-gray-700 dark:text-gray-300">Patients aujourd'hui</div>
                    </div>

                    <div class="stat-card p-5 bg-gradient-to-br from-blue-50 to-cyan-100 dark:from-blue-900/20 dark:to-cyan-800/20 rounded-2xl border-2 border-blue-200 dark:border-blue-800 shadow-lg">
                        <div class="flex items-center gap-3 mb-2">
                            <div class="w-12 h-12 bg-gradient-to-br from-blue-600 to-blue-700 rounded-xl flex items-center justify-center shadow-lg">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                </svg>
                            </div>
                            <div class="text-3xl font-black text-blue-600 dark:text-blue-400">8</div>
                        </div>
                        <div class="text-sm font-semibold text-gray-700 dark:text-gray-300">RDV programmés</div>
                    </div>

                    <div class="stat-card p-5 bg-gradient-to-br from-purple-50 to-pink-100 dark:from-purple-900/20 dark:to-pink-800/20 rounded-2xl border-2 border-purple-200 dark:border-purple-800 shadow-lg">
                        <div class="flex items-center gap-3 mb-2">
                            <div class="w-12 h-12 bg-gradient-to-br from-purple-600 to-purple-700 rounded-xl flex items-center justify-center shadow-lg">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                </svg>
                            </div>
                            <div class="text-3xl font-black text-purple-600 dark:text-purple-400">156</div>
                        </div>
                        <div class="text-sm font-semibold text-gray-700 dark:text-gray-300">Dossiers actifs</div>
                    </div>

                    <div class="stat-card p-5 bg-gradient-to-br from-orange-50 to-amber-100 dark:from-orange-900/20 dark:to-amber-800/20 rounded-2xl border-2 border-orange-200 dark:border-orange-800 shadow-lg">
                        <div class="flex items-center gap-3 mb-2">
                            <div class="w-12 h-12 bg-gradient-to-br from-orange-600 to-orange-700 rounded-xl flex items-center justify-center shadow-lg">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z" />
                                </svg>
                            </div>
                            <div class="text-3xl font-black text-orange-600 dark:text-orange-400">12</div>
                        </div>
                        <div class="text-sm font-semibold text-gray-700 dark:text-gray-300">Tickets ouverts</div>
                    </div>
                </div>
            </div>

            <div class="p-8">
                <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Actions Rapides</h3>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <a href="${pageContext.request.contextPath}/consultations?action=new" class="stat-card group p-6 bg-gradient-to-br from-teal-50 to-cyan-50 dark:from-teal-900/20 dark:to-cyan-900/20 rounded-2xl border-2 border-teal-200 dark:border-teal-800 hover:shadow-xl transition-all">
                        <div class="w-14 h-14 bg-gradient-to-br from-teal-600 to-teal-700 rounded-xl flex items-center justify-center mb-4 shadow-lg group-hover:scale-110 transition-transform">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                            </svg>
                        </div>
                        <div class="text-base font-bold text-gray-900 dark:text-white mb-1">Nouvelle Consultation</div>
                        <div class="text-xs text-gray-600 dark:text-gray-400">Créer une nouvelle consultation</div>
                    </a>

                    <a href="${pageContext.request.contextPath}/medicalFiles" class="stat-card group p-6 bg-gradient-to-br from-purple-50 to-pink-50 dark:from-purple-900/20 dark:to-pink-900/20 rounded-2xl border-2 border-purple-200 dark:border-purple-800 hover:shadow-xl transition-all">
                        <div class="w-14 h-14 bg-gradient-to-br from-purple-600 to-purple-700 rounded-xl flex items-center justify-center mb-4 shadow-lg group-hover:scale-110 transition-transform">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-6l-2-2H5a2 2 0 00-2 2z" />
                            </svg>
                        </div>
                        <div class="text-base font-bold text-gray-900 dark:text-white mb-1">Dossiers Médicaux</div>
                        <div class="text-xs text-gray-600 dark:text-gray-400">Consulter les dossiers patients</div>
                    </a>

                    <a href="${pageContext.request.contextPath}/allTickets" class="stat-card group p-6 bg-gradient-to-br from-orange-50 to-amber-50 dark:from-orange-900/20 dark:to-amber-900/20 rounded-2xl border-2 border-orange-200 dark:border-orange-800 hover:shadow-xl transition-all">
                        <div class="w-14 h-14 bg-gradient-to-br from-orange-600 to-orange-700 rounded-xl flex items-center justify-center mb-4 shadow-lg group-hover:scale-110 transition-transform">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z" />
                            </svg>
                        </div>
                        <div class="text-base font-bold text-gray-900 dark:text-white mb-1">Tickets</div>
                        <div class="text-xs text-gray-600 dark:text-gray-400">Gérer les tickets du jour</div>
                    </a>
                </div>
            </div>
        </div>

        <% } else if (role == Role.SPECIALIST) { %>
        <!-- Specialist dashboard -->
        <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 overflow-hidden fade-in-up delay-1">
            <div class="bg-gradient-to-r from-indigo-600 to-purple-600 p-8 text-white">
                <div class="flex items-center gap-4">
                    <div class="w-14 h-14 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center">
                        <svg class="w-7 h-7" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
                        </svg>
                    </div>
                    <div>
                        <h2 class="text-2xl font-bold mb-1">Médecin Spécialiste</h2>
                        <p class="text-indigo-100">Gérer vos expertises et votre planning</p>
                    </div>
                </div>
            </div>
            <div class="p-8">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <a href="${pageContext.request.contextPath}/specialist/schedule" class="stat-card group p-6 bg-gradient-to-br from-indigo-50 to-purple-50 dark:from-indigo-900/20 dark:to-purple-900/20 rounded-2xl border-2 border-indigo-200 dark:border-indigo-800 hover:shadow-xl transition-all">
                        <div class="w-14 h-14 bg-gradient-to-br from-indigo-600 to-indigo-700 rounded-xl flex items-center justify-center mb-4 shadow-lg group-hover:scale-110 transition-transform">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                            </svg>
                        </div>
                        <div class="text-base font-bold text-gray-900 dark:text-white mb-1">Mon Planning</div>
                        <div class="text-xs text-gray-600 dark:text-gray-400">Gérer les disponibilités</div>
                    </a>

                    <a href="${pageContext.request.contextPath}/specialist/consultations" class="stat-card group p-6 bg-gradient-to-br from-blue-50 to-cyan-50 dark:from-blue-900/20 dark:to-cyan-900/20 rounded-2xl border-2 border-blue-200 dark:border-blue-800 hover:shadow-xl transition-all">
                        <div class="w-14 h-14 bg-gradient-to-br from-blue-600 to-blue-700 rounded-xl flex items-center justify-center mb-4 shadow-lg group-hover:scale-110 transition-transform">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                            </svg>
                        </div>
                        <div class="text-base font-bold text-gray-900 dark:text-white mb-1">Expertises</div>
                        <div class="text-xs text-gray-600 dark:text-gray-400">Consultations reçues</div>
                    </a>

                    <div class="stat-card p-6 bg-gradient-to-br from-green-50 to-emerald-50 dark:from-green-900/20 dark:to-emerald-900/20 rounded-2xl border-2 border-green-200 dark:border-green-800">
                        <div class="flex items-center gap-3 mb-2">
                            <div class="w-12 h-12 bg-gradient-to-br from-green-600 to-green-700 rounded-xl flex items-center justify-center shadow-lg">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                            </div>
                            <div class="text-3xl font-black text-green-600 dark:text-green-400">18</div>
                        </div>
                        <div class="text-sm font-semibold text-gray-700 dark:text-gray-300">Expertises ce mois</div>
                    </div>
                </div>
            </div>
        </div>

        <% } %>
    </div>
</main>

<!-- Footer -->
<jsp:include page="footer.jsp" />

<!-- Modal Rechercher / Enregistrer Patient -->
<div id="patientModal" class="hidden fixed inset-0 z-50 overflow-y-auto">
    <div class="flex items-center justify-center min-h-screen px-4 pt-4 pb-20 text-center sm:block sm:p-0">
        <!-- Backdrop -->
        <div class="fixed inset-0 transition-opacity bg-gray-900 bg-opacity-75 backdrop-blur-sm" onclick="closePatientModal()"></div>

        <!-- Modal -->
        <div class="inline-block align-bottom bg-white dark:bg-slate-800 rounded-3xl text-left overflow-hidden shadow-2xl transform transition-all sm:my-8 sm:align-middle sm:max-w-4xl sm:w-full">
            <!-- Header -->
            <div class="bg-gradient-to-r from-blue-600 to-cyan-600 px-6 py-5">
                <div class="flex items-center justify-between">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                            </svg>
                        </div>
                        <div>
                            <h3 class="text-xl font-bold text-white">Rechercher / Enregistrer un Patient</h3>
                            <p class="text-sm text-blue-100">Entrez le nom pour rechercher ou ajouter un nouveau patient</p>
                        </div>
                    </div>
                    <button onclick="closePatientModal()" class="text-white hover:bg-white/20 rounded-xl p-2 transition-colors">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>
            </div>

            <!-- Body -->
            <div class="px-6 py-6">
                <!-- Search Section -->
                <div class="mb-6">
                    <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">
                        <svg class="w-4 h-4 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                        Rechercher par nom ou prénom
                    </label>
                    <div class="relative">
                        <input
                            type="text"
                            id="patientSearchInput"
                            placeholder="Tapez le nom du patient..."
                            class="w-full px-5 py-4 pr-12 text-base border-2 border-gray-300 dark:border-slate-600 rounded-2xl focus:outline-none focus:ring-4 focus:ring-blue-500/20 focus:border-blue-500 dark:bg-slate-700 dark:text-white transition-all"
                            oninput="searchPatient(this.value)"
                        />
                        <div class="absolute right-4 top-1/2 -translate-y-1/2">
                            <svg class="w-6 h-6 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                            </svg>
                        </div>
                    </div>

                    <!-- Search Results -->
                    <div id="searchResults" class="mt-3"></div>
                </div>

                <div class="relative my-8">
                    <div class="absolute inset-0 flex items-center">
                        <div class="w-full border-t-2 border-gray-300 dark:border-slate-600"></div>
                    </div>
                    <div class="relative flex justify-center text-sm">
                        <span class="px-4 bg-white dark:bg-slate-800 text-gray-500 dark:text-gray-400 font-semibold">OU CRÉER UN NOUVEAU PATIENT</span>
                    </div>
                </div>

                <!-- Patient Form -->
                <form id="patientForm" method="post" action="${pageContext.request.contextPath}/nurse/patients">
                    <input type="hidden" name="action" value="register">
                    <input type="hidden" id="patientId" name="patientId">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <!-- Prénom -->
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">
                                Prénom <span class="text-red-500">*</span>
                            </label>
                            <input
                                type="text"
                                id="firstName"
                                name="firstName"
                                required
                                class="w-full px-4 py-3 border-2 border-gray-300 dark:border-slate-600 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-blue-500 dark:bg-slate-700 dark:text-white transition-all"
                                placeholder="Entrez le prénom"
                            />
                        </div>

                        <!-- Nom -->
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">
                                Nom <span class="text-red-500">*</span>
                            </label>
                            <input
                                type="text"
                                id="lastName"
                                name="lastName"
                                required
                                class="w-full px-4 py-3 border-2 border-gray-300 dark:border-slate-600 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-blue-500 dark:bg-slate-700 dark:text-white transition-all"
                                placeholder="Entrez le nom"
                            />
                        </div>

                        <!-- Username -->
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">
                                Nom d'utilisateur <span class="text-red-500">*</span>
                            </label>
                            <input
                                type="text"
                                id="username"
                                name="username"
                                required
                                class="w-full px-4 py-3 border-2 border-gray-300 dark:border-slate-600 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-blue-500 dark:bg-slate-700 dark:text-white transition-all"
                                placeholder="Nom d'utilisateur unique"
                            />
                        </div>

                        <!-- Password -->
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">
                                Mot de passe <span class="text-red-500">*</span>
                            </label>
                            <input
                                type="password"
                                id="password"
                                name="password"
                                required
                                class="w-full px-4 py-3 border-2 border-gray-300 dark:border-slate-600 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-blue-500 dark:bg-slate-700 dark:text-white transition-all"
                                placeholder="Mot de passe sécurisé"
                            />
                        </div>

                        <!-- Email -->
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">
                                Email <span class="text-red-500">*</span>
                            </label>
                            <input
                                type="email"
                                id="email"
                                name="email"
                                required
                                class="w-full px-4 py-3 border-2 border-gray-300 dark:border-slate-600 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-blue-500 dark:bg-slate-700 dark:text-white transition-all"
                                placeholder="email@exemple.com"
                            />
                        </div>

                        <!-- Téléphone -->
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">
                                Téléphone
                            </label>
                            <input
                                type="tel"
                                id="phone"
                                name="phone"
                                class="w-full px-4 py-3 border-2 border-gray-300 dark:border-slate-600 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-blue-500 dark:bg-slate-700 dark:text-white transition-all"
                                placeholder="+212 6XX XXX XXX"
                            />
                        </div>

                        <!-- Genre -->
                        <div class="md:col-span-2">
                            <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">
                                Genre <span class="text-red-500">*</span>
                            </label>
                            <div class="flex gap-4">
                                <label class="flex items-center gap-2 px-6 py-3 border-2 border-gray-300 dark:border-slate-600 rounded-xl cursor-pointer hover:bg-blue-50 dark:hover:bg-slate-700 transition-colors">
                                    <input type="radio" name="gender" value="MALE" required class="w-4 h-4 text-blue-600">
                                    <span class="text-gray-700 dark:text-gray-300 font-medium">Homme</span>
                                </label>
                                <label class="flex items-center gap-2 px-6 py-3 border-2 border-gray-300 dark:border-slate-600 rounded-xl cursor-pointer hover:bg-pink-50 dark:hover:bg-slate-700 transition-colors">
                                    <input type="radio" name="gender" value="FEMALE" required class="w-4 h-4 text-pink-600">
                                    <span class="text-gray-700 dark:text-gray-300 font-medium">Femme</span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="flex items-center gap-3 mt-8 pt-6 border-t-2 border-gray-200 dark:border-slate-700">
                        <button
                            type="button"
                            onclick="closePatientModal()"
                            class="flex-1 px-6 py-3 bg-gray-100 dark:bg-slate-700 text-gray-700 dark:text-gray-300 font-semibold rounded-xl hover:bg-gray-200 dark:hover:bg-slate-600 transition-colors"
                        >
                            Annuler
                        </button>
                        <button
                            type="submit"
                            class="flex-1 px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 text-white font-semibold rounded-xl hover:shadow-lg hover:-translate-y-0.5 transition-all"
                        >
                            <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Enregistrer le Patient
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Dark mode
    if (localStorage.getItem('darkMode') === 'enabled' || (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
    }

    // Open Modal
    const openModalBtn = document.getElementById('openPatientModal');
    if (openModalBtn) {
        openModalBtn.addEventListener('click', function() {
            document.getElementById('patientModal').classList.remove('hidden');
            document.body.style.overflow = 'hidden';
        });
    }

    // Close Modal
    function closePatientModal() {
        document.getElementById('patientModal').classList.add('hidden');
        document.body.style.overflow = 'auto';
        // Reset form
        document.getElementById('patientForm').reset();
        document.getElementById('patientId').value = '';
        document.getElementById('searchResults').innerHTML = '';
        document.getElementById('patientSearchInput').value = '';
    }

    // Search Patient Function
    let searchTimeout;
    function searchPatient(query) {
        clearTimeout(searchTimeout);

        const resultsDiv = document.getElementById('searchResults');

        if (query.trim().length < 2) {
            resultsDiv.innerHTML = '';
            return;
        }

        resultsDiv.innerHTML = '<div class="text-center py-4"><div class="inline-block animate-spin rounded-full h-8 w-8 border-4 border-blue-600 border-t-transparent"></div></div>';

        searchTimeout = setTimeout(() => {
            fetch('${pageContext.request.contextPath}/nurse/patients?action=search&query=' + encodeURIComponent(query))
                .then(response => response.json())
                .then(data => {
                    if (data.length === 0) {
                        resultsDiv.innerHTML = `
                            <div class="bg-yellow-50 dark:bg-yellow-900/20 border-2 border-yellow-200 dark:border-yellow-800 rounded-xl p-4">
                                <div class="flex items-center gap-3">
                                    <svg class="w-6 h-6 text-yellow-600 dark:text-yellow-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                                    </svg>
                                    <div>
                                        <p class="font-semibold text-yellow-800 dark:text-yellow-300">Aucun patient trouvé</p>
                                        <p class="text-sm text-yellow-600 dark:text-yellow-400">Remplissez le formulaire ci-dessous pour l'ajouter</p>
                                    </div>
                                </div>
                            </div>
                        `;
                    } else {
                        let html = '<div class="space-y-2 max-h-60 overflow-y-auto">';
                        data.forEach(patient => {
                            html += `
                                <div class="bg-gradient-to-r from-green-50 to-emerald-50 dark:from-green-900/20 dark:to-emerald-900/20 border-2 border-green-200 dark:border-green-800 rounded-xl p-4 cursor-pointer hover:shadow-lg transition-all" onclick="fillPatientForm(${patient.id}, '${patient.firstName}', '${patient.lastName}', '${patient.username}', '${patient.email}', '${patient.phone || ''}', '${patient.gender}')">
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center gap-3">
                                            <div class="w-12 h-12 bg-gradient-to-br from-green-600 to-green-700 rounded-xl flex items-center justify-center">
                                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                                </svg>
                                            </div>
                                            <div>
                                                <p class="font-bold text-gray-900 dark:text-white">${patient.firstName} ${patient.lastName}</p>
                                                <p class="text-sm text-gray-600 dark:text-gray-400">${patient.email}</p>
                                            </div>
                                        </div>
                                        <svg class="w-6 h-6 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                                        </svg>
                                    </div>
                                </div>
                            `;
                        });
                        html += '</div>';
                        resultsDiv.innerHTML = html;
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    resultsDiv.innerHTML = `
                        <div class="bg-red-50 dark:bg-red-900/20 border-2 border-red-200 dark:border-red-800 rounded-xl p-4">
                            <p class="text-red-800 dark:text-red-300 font-semibold">Erreur lors de la recherche</p>
                        </div>
                    `;
                });
        }, 300);
    }

    // Fill Form with Patient Data
    function fillPatientForm(id, firstName, lastName, username, email, phone, gender) {
        document.getElementById('patientId').value = id;
        document.getElementById('firstName').value = firstName;
        document.getElementById('lastName').value = lastName;
        document.getElementById('username').value = username;
        document.getElementById('email').value = email;
        document.getElementById('phone').value = phone;

        // Set gender radio button
        const genderRadios = document.querySelectorAll('input[name="gender"]');
        genderRadios.forEach(radio => {
            if (radio.value === gender) {
                radio.checked = true;
            }
        });

        // Disable fields for existing patient
        document.getElementById('firstName').readOnly = true;
        document.getElementById('lastName').readOnly = true;
        document.getElementById('username').readOnly = true;
        document.getElementById('password').required = false;
        document.getElementById('password').parentElement.classList.add('hidden');

        // Clear search results
        document.getElementById('searchResults').innerHTML = `
            <div class="bg-green-50 dark:bg-green-900/20 border-2 border-green-200 dark:border-green-800 rounded-xl p-4">
                <p class="text-green-800 dark:text-green-300 font-semibold">✓ Patient sélectionné - Vous pouvez modifier les informations ci-dessous</p>
            </div>
        `;
    }
</script>
</body>
</html>
