<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion | Système Médical</title>
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
        /* Custom styles for floating labels */
        .floating-label .peer:focus ~ label,
        .floating-label .peer:not(:placeholder-shown) ~ label {
            transform: translateY(-1.75rem) scale(0.75);
            color: #3b82f6; /* blue-500 */
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 to-cyan-100 flex items-center justify-center min-h-screen p-4">
<%--<jsp:include page="header.jsp" />--%>


<div class="bg-white rounded-2xl shadow-2xl w-full max-w-md overflow-hidden">
    <div class="p-8 md:p-12">
        <div class="flex flex-col items-center text-center mb-8">
            <div class="bg-blue-100 text-blue-600 p-3 rounded-full mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M10 6H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V8a2 2 0 00-2-2h-5m-4 0V5a2 2 0 114 0v1m-4 0a2 2 0 104 0m-5 8h2.586a1 1 0 01.707.293l2.414 2.414a1 1 0 001.414 0l2.414-2.414a1 1 0 01.707-.293H19" />
                </svg>
            </div>
            <h1 class="text-3xl font-bold text-gray-800">Connexion</h1>
            <p class="text-gray-500 mt-1">Accédez à votre tableau de bord.</p>
        </div>

        <form action="<%=request.getContextPath()%>/login?action=authenticate" method="post" class="space-y-6">
            <!-- Email -->
            <div class="relative floating-label">
                <input type="text" id="email" name="email" required placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-300 bg-gray-50">
                <label for="email" class="absolute left-4 top-3.5 text-gray-500 transition-all duration-300 origin-top-left">Email</label>
            </div>

            <!-- Password -->
            <div class="relative floating-label">
                <input type="password" id="password" name="password" required placeholder=" " class="peer w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-300 bg-gray-50">
                <label for="password" class="absolute left-4 top-3.5 text-gray-500 transition-all duration-300 origin-top-left">Mot de passe</label>
            </div>

            <% if (request.getAttribute("error") != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg relative" role="alert">
                <span class="block sm:inline"><%= request.getAttribute("error") %></span>
            </div>
            <% } %>

            <!-- Submit Button -->
            <div>
                <button type="submit" class="w-full bg-gradient-to-r from-blue-600 to-cyan-500 text-white font-bold py-3 rounded-lg hover:from-blue-700 hover:to-cyan-600 focus:outline-none focus:ring-4 focus:ring-blue-300 mt-4 transition-all duration-300 transform hover:scale-105 shadow-lg">
                    Se connecter
                </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
