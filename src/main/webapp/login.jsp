<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion Sécurisée | Système de Télé-Expertise Médicale</title>
    <!-- Tailwind CSS CDN with Dark Mode Support -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class', // Enable class-based dark mode
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
    <script src="https://unpkg.com/heroicons@2.0.18/dist/heroicons.min.js"></script>
    <style>
        .floating-label .peer:focus ~ label,
        .floating-label .peer:not(:placeholder-shown) ~ label {
            transform: translateY(-1.75rem) scale(0.75);
            color: #3b82f6;
        }
        .password-toggle {
            cursor: pointer;
        }
        .dark .bg-gradient-to-br {
            background-image: linear-gradient(to bottom right, #1e3a8a, #164e63); /* Darker blues for medical trust */
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const passwordInput = document.getElementById('password');
            const toggleBtn = document.getElementById('togglePassword');
            toggleBtn.addEventListener('click', () => {
                const type = passwordInput.type === 'password' ? 'text' : 'password';
                passwordInput.type = type;
                toggleBtn.innerHTML = type === 'password' ? '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>' : '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.542-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0l3.59 3.59" /></svg>';
            });

            if (localStorage.getItem('darkMode') === 'enabled' || (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
                document.documentElement.classList.add('dark');
            }
            const darkToggle = document.getElementById('darkToggle');
            darkToggle.addEventListener('click', () => {
                document.documentElement.classList.toggle('dark');
                localStorage.setItem('darkMode', document.documentElement.classList.contains('dark') ? 'enabled' : 'disabled');
            });
        });
    </script>
</head>
<body class="bg-gradient-to-br from-blue-50 to-cyan-100 dark:from-blue-900 dark:to-cyan-900 flex items-center justify-center min-h-screen p-4 transition-colors duration-500">
<div class="absolute top-4 right-4">
    <button id="darkToggle" class="p-2 rounded-full bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-gray-200">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" /></svg>
    </button>
</div>

<div class="bg-white dark:bg-gray-800 rounded-2xl shadow-2xl w-full max-w-md overflow-hidden transition-all duration-300">
    <div class="p-8 md:p-12">
        <div class="flex flex-col items-center text-center mb-8">
            <div class="bg-blue-100 dark:bg-blue-900 text-blue-600 dark:text-blue-300 p-4 rounded-full mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                </svg>
            </div>
            <p class="text-gray-500 dark:text-gray-400 mt-1">Système de Télé-Expertise Médicale</p>
            <p class="text-xs text-gray-400 dark:text-gray-500 mt-2 flex items-center"><svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" /></svg> Connexion chiffrée et conforme HIPAA/GDPR.</p>
        </div>

        <form action="<%=request.getContextPath()%>/login?action=authenticate" method="post" class="space-y-6">
            <!-- Email -->
            <div class="relative floating-label">
                <input type="email" id="email" name="email" required placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-300 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white" aria-label="Adresse email">
                <label for="email" class="absolute left-4 top-3.5 text-gray-500 dark:text-gray-400 transition-all duration-300 origin-top-left pointer-events-none">Email</label>
            </div>

            <!-- Password with Toggle -->
            <div class="relative floating-label">
                <input type="password" id="password" name="password" required placeholder=" " class="peer w-full px-4 py-3 pr-12 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-300 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white" aria-label="Mot de passe">
                <label for="password" class="absolute left-4 top-3.5 text-gray-500 dark:text-gray-400 transition-all duration-300 origin-top-left pointer-events-none">Mot de passe</label>
                <span id="togglePassword" class="password-toggle absolute right-4 top-3.5 text-gray-500 dark:text-gray-400">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>
                    </span>
            </div>

            <!-- Options -->
            <div class="flex items-center justify-between">
                <label class="flex items-center">
                    <input type="checkbox" name="remember" class="mr-2 rounded text-blue-600 focus:ring-blue-500">
                    <span class="text-sm text-gray-600 dark:text-gray-400">Se souvenir de moi</span>
                </label>
                <a href="forgot-password.jsp" class="text-sm text-blue-600 dark:text-blue-400 hover:underline">Mot de passe oublié ?</a>
            </div>

            <% if (request.getAttribute("error") != null) { %>
            <div class="bg-red-100 dark:bg-red-900 border border-red-400 dark:border-red-700 text-red-700 dark:text-red-300 px-4 py-3 rounded-lg relative" role="alert" aria-live="assertive">
                <span class="block sm:inline"><%= request.getAttribute("error") %></span>
            </div>
            <% } %>

            <!-- Submit Button -->
            <div>
                <button type="submit" class="w-full bg-gradient-to-r from-blue-600 to-cyan-500 dark:from-blue-700 dark:to-cyan-600 text-white font-bold py-3 rounded-lg hover:from-blue-700 hover:to-cyan-600 focus:outline-none focus:ring-4 focus:ring-blue-300 dark:focus:ring-blue-800 mt-4 transition-all duration-300 transform hover:scale-105 shadow-lg flex items-center justify-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 006 0v-1m-6-1V9a3 3 0 00-6 0v1" /></svg>
                    Se connecter
                </button>
            </div>

            <!-- Enterprise SSO Hint -->
            <div class="text-center mt-4">
                <p class="text-xs text-gray-500 dark:text-gray-400">Ou utilisez <a href="sso-login.jsp" class="text-blue-600 dark:text-blue-400 hover:underline">SSO Entreprise</a> pour une authentification sécurisée.</p>
            </div>
        </form>
    </div>
</div>
</body>
</html>