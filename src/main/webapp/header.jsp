<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Tailwind is assumed to be loaded by the parent page -->

<header class="bg-white/80 backdrop-blur-sm shadow-md sticky top-0 z-40">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
            <div class="flex items-center space-x-2">
                <div class="bg-blue-100 text-blue-600 p-2 rounded-full">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M10 6H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V8a2 2 0 00-2-2h-5m-4 0V5a2 2 0 114 0v1m-4 0a2 2 0 104 0m-5 8h2.586a1 1 0 01.707.293l2.414 2.414a1 1 0 001.414 0l2.414-2.414a1 1 0 01.707-.293H19" />
                    </svg>
                </div>
                <h1 class="text-xl font-bold text-gray-800">Système Médical</h1>
            </div>
            <nav class="flex items-center space-x-4">
                <a href="dashboard" class="text-gray-600 hover:text-blue-600 font-semibold transition-colors duration-200">Accueil</a>
                <a href="dashboard?action=logout" class="bg-red-500 text-white font-bold px-4 py-2 rounded-lg hover:bg-red-600 transition-colors duration-200 text-sm shadow">
                    Déconnexion
                </a>
            </nav>
        </div>
    </div>
</header>
