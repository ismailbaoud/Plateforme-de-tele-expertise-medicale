<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<header class="relative z-50 bg-white/90 dark:bg-slate-800/90 backdrop-blur-xl shadow-lg border-b border-gray-200/50 dark:border-slate-700/50 sticky top-0">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
            <!-- Logo and Title -->
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-gradient-to-br from-teal-500 to-teal-600 rounded-xl flex items-center justify-center shadow-lg shadow-teal-500/20">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h-4m-8 0H5m7-7h6m-6-4h6m-6-4h6" />
                    </svg>
                </div>
                <h1 class="text-lg font-bold text-gray-900 dark:text-white">Télé-Expertise Médicale</h1>
            </div>

            <!-- Desktop Navigation -->
            <nav id="desktopNav" class="hidden md:flex items-center gap-6">
                <a href="<%=request.getContextPath()%>/dashboard" class="flex items-center gap-2 text-gray-700 dark:text-gray-300 hover:text-teal-600 dark:hover:text-teal-400 font-medium transition-colors">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" /></svg>
                    <span>Accueil</span>
                </a>
            </nav>

            <!-- Right Side: Notifications, User Menu, Mobile Toggle -->
            <div class="flex items-center gap-4">
                <!-- Notifications Bell -->
                <div class="relative">
                    <button id="notiBtn" class="p-2 text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-slate-700 rounded-xl transition-colors">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" /></svg>
                        <span class="absolute top-1 right-1 block h-2 w-2 rounded-full bg-red-500 ring-2 ring-white dark:ring-slate-800"></span>
                    </button>
                    <div id="notiDropdown" class="hidden absolute right-0 mt-2 w-72 bg-white dark:bg-slate-800 rounded-2xl shadow-2xl border border-gray-200 dark:border-slate-700 z-50 overflow-hidden">
                        <div class="p-4 border-b border-gray-200 dark:border-slate-700">
                            <p class="font-semibold text-gray-900 dark:text-white">Notifications</p>
                        </div>
                        <div class="p-4 max-h-80 overflow-y-auto">
                            <ul class="space-y-3">
                                <li class="flex items-start gap-3 p-3 bg-teal-50 dark:bg-teal-900/20 rounded-xl">
                                    <div class="w-2 h-2 bg-teal-500 rounded-full mt-2"></div>
                                    <div class="flex-1">
                                        <p class="text-sm text-gray-900 dark:text-white">Nouvelle demande d'expertise de Dr. Martin</p>
                                        <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">Il y a 5 minutes</p>
                                    </div>
                                </li>
                                <li class="flex items-start gap-3 p-3 hover:bg-gray-50 dark:hover:bg-slate-700/50 rounded-xl transition-colors">
                                    <div class="w-2 h-2 bg-gray-300 dark:bg-gray-600 rounded-full mt-2"></div>
                                    <div class="flex-1">
                                        <p class="text-sm text-gray-700 dark:text-gray-300">Rapport patient #123 prêt</p>
                                        <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">Il y a 2 heures</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="p-3 border-t border-gray-200 dark:border-slate-700">
                            <a href="<%=request.getContextPath()%>/notifications" class="block text-center text-sm text-teal-600 dark:text-teal-400 hover:text-teal-700 dark:hover:text-teal-300 font-medium">Voir tout</a>
                        </div>
                    </div>
                </div>

                <!-- User Menu Dropdown -->
                <div class="relative">
                    <button id="userMenuBtn" class="flex items-center gap-2 p-2 pr-3 hover:bg-gray-100 dark:hover:bg-slate-700 rounded-xl transition-colors">
                        <img src="https://via.placeholder.com/32" alt="Avatar" class="w-8 h-8 rounded-lg border-2 border-teal-200 dark:border-teal-700">
                        <span class="font-medium text-gray-900 dark:text-white hidden sm:inline">Dr. <%= session.getAttribute("username") != null ? session.getAttribute("username") : "User" %></span>
                        <svg class="w-4 h-4 text-gray-500 dark:text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" /></svg>
                    </button>
                    <div id="userDropdown" class="hidden absolute right-0 mt-2 w-48 bg-white dark:bg-slate-800 rounded-2xl shadow-2xl border border-gray-200 dark:border-slate-700 z-50 overflow-hidden">
                        <a href="<%=request.getContextPath()%>/login?action=logout" class="flex items-center gap-3 px-4 py-3 text-sm text-red-600 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20 transition-colors">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" /></svg>
                            <span>Déconnexion</span>
                        </a>
                    </div>
                </div>

                <!-- Mobile Menu Toggle -->
                <button id="mobileToggle" class="md:hidden p-2 text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-slate-700 rounded-xl transition-colors">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" /></svg>
                </button>
            </div>
        </div>

        <!-- Mobile Navigation Dropdown -->
        <nav id="mobileNav" class="hidden md:hidden pb-4 space-y-2 border-t border-gray-200 dark:border-slate-700 pt-4">
            <a href="<%=request.getContextPath()%>/dashboard" class="flex items-center gap-2 px-3 py-2 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-slate-700 rounded-xl font-medium transition-colors">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" /></svg>
                <span>Accueil</span>
            </a>
        </nav>
    </div>
</header>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        // User menu dropdown
        const userMenuBtn = document.getElementById('userMenuBtn');
        const userDropdown = document.getElementById('userDropdown');
        if (userMenuBtn && userDropdown) {
            userMenuBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                userDropdown.classList.toggle('hidden');
                notiDropdown?.classList.add('hidden');
            });
        }

        // Notifications dropdown
        const notiBtn = document.getElementById('notiBtn');
        const notiDropdown = document.getElementById('notiDropdown');
        if (notiBtn && notiDropdown) {
            notiBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                notiDropdown.classList.toggle('hidden');
                userDropdown?.classList.add('hidden');
            });
        }

        // Close dropdowns on outside click
        document.addEventListener('click', () => {
            userDropdown?.classList.add('hidden');
            notiDropdown?.classList.add('hidden');
        });

        // Mobile menu toggle
        const mobileToggle = document.getElementById('mobileToggle');
        const mobileNav = document.getElementById('mobileNav');
        if (mobileToggle && mobileNav) {
            mobileToggle.addEventListener('click', () => {
                mobileNav.classList.toggle('hidden');
            });
        }
    });
</script>
