<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.consultation.Consultation" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Person" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Specialist" %>
<%@ page import="com.medicale.consultation.consultationmedicale.enums.ConsultationStatus" %>

<%
    Person user = (Person) session.getAttribute("user");
    if (user == null || !(user instanceof Specialist)) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    Specialist specialist = (Specialist) user;
    List<Consultation> consultations = (List<Consultation>) request.getAttribute("consultations");
    String successMessage = (String) session.getAttribute("successMessage");
    if (successMessage != null) {
        session.removeAttribute("successMessage");
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Consultations | Spécialiste</title>
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
        @keyframes slideIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .consultation-card {
            animation: slideIn 0.4s ease-out forwards;
        }
        .modal {
            display: none;
        }
        .modal.active {
            display: flex;
        }
    </style>
</head>
<body class="bg-white dark:bg-slate-900 min-h-screen">
<!-- Diagonal Grid Background -->
<div class="fixed inset-0 diagonal-grid"></div>

<%@include file="../../header.jsp"%>

<main class="relative z-10 min-h-screen p-6 lg:p-8">
    <div class="max-w-7xl mx-auto">
        <!-- Success Message -->
        <% if (successMessage != null) { %>
        <div class="mb-6 bg-green-50 dark:bg-green-900/20 border-2 border-green-500 dark:border-green-700 rounded-2xl p-4 flex items-center gap-3 animate-pulse">
            <svg class="w-6 h-6 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <span class="text-green-800 dark:text-green-200 font-semibold"><%= successMessage %></span>
        </div>
        <% } %>

        <!-- Header Card -->
        <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 overflow-hidden mb-6">
            <div class="bg-gradient-to-r from-indigo-600 via-purple-600 to-pink-600 p-8 text-white">
                <div class="flex items-center justify-between">
                    <div class="flex items-center gap-4">
                        <div class="w-16 h-16 bg-white/20 backdrop-blur-sm rounded-2xl flex items-center justify-center">
                            <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                            </svg>
                        </div>
                        <div>
                            <h1 class="text-3xl font-bold mb-1">Mes Consultations</h1>
                            <p class="text-indigo-100">Demandes d'expertise médicale</p>
                        </div>
                    </div>
                    <div class="hidden md:block">
                        <div class="text-right bg-white/20 backdrop-blur-sm rounded-2xl px-6 py-4">
                            <div class="text-4xl font-black"><%= consultations != null ? consultations.size() : 0 %></div>
                            <div class="text-sm text-indigo-100 font-medium">Consultations</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Stats -->
            <div class="grid grid-cols-3 divide-x divide-gray-200 dark:divide-slate-700 bg-gradient-to-r from-indigo-50 to-purple-50 dark:from-indigo-900/20 dark:to-purple-900/20">
                <%
                    int total = consultations != null ? consultations.size() : 0;
                    int pending = 0, inProgress = 0, completed = 0;
                    if (consultations != null) {
                        for (Consultation c : consultations) {
                            if (c.getStatus() == ConsultationStatus.PENDING) pending++;
                            else if (c.getStatus() == ConsultationStatus.IN_PROGRESS) inProgress++;
                            else if (c.getStatus() == ConsultationStatus.COMPLETED) completed++;
                        }
                    }
                %>
                <div class="p-4 text-center">
                    <div class="text-2xl font-bold text-yellow-600 dark:text-yellow-400"><%= pending %></div>
                    <div class="text-xs text-gray-600 dark:text-gray-400 font-medium mt-1">En attente</div>
                </div>
                <div class="p-4 text-center">
                    <div class="text-2xl font-bold text-blue-600 dark:text-blue-400"><%= inProgress %></div>
                    <div class="text-xs text-gray-600 dark:text-gray-400 font-medium mt-1">En cours</div>
                </div>
                <div class="p-4 text-center">
                    <div class="text-2xl font-bold text-green-600 dark:text-green-400"><%= completed %></div>
                    <div class="text-xs text-gray-600 dark:text-gray-400 font-medium mt-1">Complétées</div>
                </div>
            </div>
        </div>

        <!-- Consultations List -->
        <div class="grid grid-cols-1 gap-6">
            <%
                if (consultations != null && !consultations.isEmpty()) {
                    int index = 0;
                    for (Consultation consultation : consultations) {
                        index++;
                        String statusColor = "";
                        String statusBg = "";
                        String statusText = "";

                        if (consultation.getStatus() == ConsultationStatus.PENDING) {
                            statusColor = "yellow";
                            statusBg = "bg-yellow-100 dark:bg-yellow-900/30";
                            statusText = "text-yellow-700 dark:text-yellow-300";
                        } else if (consultation.getStatus() == ConsultationStatus.IN_PROGRESS) {
                            statusColor = "blue";
                            statusBg = "bg-blue-100 dark:bg-blue-900/30";
                            statusText = "text-blue-700 dark:text-blue-300";
                        } else {
                            statusColor = "green";
                            statusBg = "bg-green-100 dark:bg-green-900/30";
                            statusText = "text-green-700 dark:text-green-300";
                        }
            %>
            <div class="consultation-card bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 overflow-hidden" style="animation-delay: <%= index * 0.1 %>s;">
                <div class="p-6">
                    <!-- Header -->
                    <div class="flex items-start justify-between mb-6">
                        <div class="flex items-center gap-4">
                            <div class="w-14 h-14 bg-gradient-to-br from-purple-500 to-pink-500 rounded-xl flex items-center justify-center text-white font-bold shadow-lg">
                                <%= consultation.getPatient().getFirstName().substring(0, 1).toUpperCase() %><%= consultation.getPatient().getLastName().substring(0, 1).toUpperCase() %>
                            </div>
                            <div>
                                <h3 class="text-xl font-bold text-gray-900 dark:text-white">
                                    <%= consultation.getPatient().getFirstName() %> <%= consultation.getPatient().getLastName() %>
                                </h3>
                                <div class="flex items-center gap-2 mt-1">
                                    <span class="text-sm text-gray-500 dark:text-gray-400">Dossier: <%= consultation.getPatient().getDossierNumber() %></span>
                                    <span class="text-gray-300 dark:text-gray-600">•</span>
                                    <span class="text-sm text-gray-500 dark:text-gray-400"><%= consultation.getCreatedAt() %></span>
                                </div>
                            </div>
                        </div>
                        <span class="inline-flex items-center gap-2 px-4 py-2 <%= statusBg %> <%= statusText %> rounded-xl text-sm font-bold">
                            <span class="w-2 h-2 bg-current rounded-full"></span>
                            <%= consultation.getStatus().toString() %>
                        </span>
                    </div>

                    <!-- Consultation Details -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                        <div class="p-4 bg-gradient-to-br from-blue-50 to-cyan-50 dark:from-blue-900/20 dark:to-cyan-900/20 rounded-2xl border border-blue-200 dark:border-blue-800">
                            <div class="flex items-center gap-2 mb-3">
                                <svg class="w-5 h-5 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                                </svg>
                                <h4 class="font-semibold text-gray-900 dark:text-white">Motif</h4>
                            </div>
                            <p class="text-sm text-gray-700 dark:text-gray-300"><%= consultation.getReason() != null ? consultation.getReason() : "Non spécifié" %></p>
                        </div>

                        <div class="p-4 bg-gradient-to-br from-purple-50 to-pink-50 dark:from-purple-900/20 dark:to-pink-900/20 rounded-2xl border border-purple-200 dark:border-purple-800">
                            <div class="flex items-center gap-2 mb-3">
                                <svg class="w-5 h-5 text-purple-600 dark:text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                </svg>
                                <h4 class="font-semibold text-gray-900 dark:text-white">Diagnostic</h4>
                            </div>
                            <p class="text-sm text-gray-700 dark:text-gray-300"><%= consultation.getDiagnosis() != null ? consultation.getDiagnosis() : "Non spécifié" %></p>
                        </div>

                        <div class="p-4 bg-gradient-to-br from-orange-50 to-amber-50 dark:from-orange-900/20 dark:to-amber-900/20 rounded-2xl border border-orange-200 dark:border-orange-800">
                            <div class="flex items-center gap-2 mb-3">
                                <svg class="w-5 h-5 text-orange-600 dark:text-orange-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                                <h4 class="font-semibold text-gray-900 dark:text-white">Symptômes</h4>
                            </div>
                            <p class="text-sm text-gray-700 dark:text-gray-300"><%= consultation.getSymptoms() != null ? consultation.getSymptoms() : "Non spécifié" %></p>
                        </div>

                        <div class="p-4 bg-gradient-to-br from-green-50 to-emerald-50 dark:from-green-900/20 dark:to-emerald-900/20 rounded-2xl border border-green-200 dark:border-green-800">
                            <div class="flex items-center gap-2 mb-3">
                                <svg class="w-5 h-5 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01" />
                                </svg>
                                <h4 class="font-semibold text-gray-900 dark:text-white">Examen clinique</h4>
                            </div>
                            <p class="text-sm text-gray-700 dark:text-gray-300"><%= consultation.getClinicalExam() != null ? consultation.getClinicalExam() : "Non spécifié" %></p>
                        </div>
                    </div>

                    <% if (consultation.getObservations() != null && !consultation.getObservations().isEmpty()) { %>
                    <div class="p-4 bg-gray-50 dark:bg-slate-900/50 rounded-2xl border border-gray-200 dark:border-slate-700 mb-6">
                        <div class="flex items-center gap-2 mb-3">
                            <svg class="w-5 h-5 text-gray-600 dark:text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                            </svg>
                            <h4 class="font-semibold text-gray-900 dark:text-white">Observations</h4>
                        </div>
                        <p class="text-sm text-gray-700 dark:text-gray-300"><%= consultation.getObservations() %></p>
                    </div>
                    <% } %>

                    <!-- Expert Response Section -->
                    <% if (consultation.getStatus() == ConsultationStatus.COMPLETED && consultation.getExpertOpinion() != null) { %>
                    <div class="border-t-2 border-gray-200 dark:border-slate-700 pt-6">
                        <h4 class="text-lg font-bold text-gray-900 dark:text-white mb-4 flex items-center gap-2">
                            <svg class="w-6 h-6 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                            Votre Réponse d'Expert
                        </h4>
                        <div class="space-y-4">
                            <div class="p-4 bg-green-50 dark:bg-green-900/20 rounded-2xl border border-green-200 dark:border-green-800">
                                <h5 class="font-semibold text-green-900 dark:text-green-100 mb-2">Avis d'Expert</h5>
                                <p class="text-sm text-gray-700 dark:text-gray-300"><%= consultation.getExpertOpinion() %></p>
                            </div>
                            <% if (consultation.getRecommendations() != null && !consultation.getRecommendations().isEmpty()) { %>
                            <div class="p-4 bg-blue-50 dark:bg-blue-900/20 rounded-2xl border border-blue-200 dark:border-blue-800">
                                <h5 class="font-semibold text-blue-900 dark:text-blue-100 mb-2">Recommandations</h5>
                                <p class="text-sm text-gray-700 dark:text-gray-300"><%= consultation.getRecommendations() %></p>
                            </div>
                            <% } %>
                        </div>
                    </div>
                    <% } else { %>
                    <!-- Action Button -->
                    <div class="flex justify-end">
                        <button onclick="openResponseModal(<%= consultation.getId() %>)"
                                class="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-indigo-600 via-purple-600 to-pink-600 hover:from-indigo-700 hover:via-purple-700 hover:to-pink-700 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                            </svg>
                            <span>Répondre à la consultation</span>
                        </button>
                    </div>
                    <% } %>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 p-16">
                <div class="flex flex-col items-center gap-4">
                    <div class="w-24 h-24 bg-gradient-to-br from-gray-100 to-gray-200 dark:from-gray-800 dark:to-gray-900 rounded-full flex items-center justify-center">
                        <svg class="w-12 h-12 text-gray-400 dark:text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                        </svg>
                    </div>
                    <div class="text-center">
                        <p class="text-xl font-semibold text-gray-700 dark:text-gray-300">Aucune consultation</p>
                        <p class="text-sm text-gray-500 dark:text-gray-500 mt-2">Vous n'avez pas encore de demandes d'expertise.</p>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</main>

<!-- Response Modal -->
<div id="responseModal" class="modal fixed inset-0 bg-black/50 backdrop-blur-sm z-50 items-center justify-center p-4">
    <div class="bg-white dark:bg-slate-800 rounded-3xl shadow-2xl border border-gray-200 dark:border-slate-700 max-w-3xl w-full max-h-[90vh] overflow-y-auto">
        <div class="bg-gradient-to-r from-indigo-600 via-purple-600 to-pink-600 p-6 text-white">
            <div class="flex items-center justify-between">
                <h2 class="text-2xl font-bold">Répondre à la Consultation</h2>
                <button onclick="closeResponseModal()" class="p-2 hover:bg-white/20 rounded-lg transition-colors">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
        </div>

        <form method="post" action="<%= request.getContextPath() %>/specialist/consultations?action=respond" class="p-6 space-y-6">
            <input type="hidden" name="consultationId" id="modalConsultationId">

            <div>
                <label for="expertOpinion" class="block text-sm font-semibold text-gray-900 dark:text-white mb-2">
                    Avis d'Expert *
                </label>
                <textarea id="expertOpinion" name="expertOpinion" rows="6" required
                          placeholder="Votre analyse détaillée et avis médical sur cette consultation..."
                          class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-gray-500 focus:border-indigo-500 focus:ring-4 focus:ring-indigo-500/10 transition-all outline-none"></textarea>
            </div>

            <div>
                <label for="recommendations" class="block text-sm font-semibold text-gray-900 dark:text-white mb-2">
                    Recommandations
                </label>
                <textarea id="recommendations" name="recommendations" rows="4"
                          placeholder="Vos recommandations thérapeutiques ou de suivi..."
                          class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-gray-500 focus:border-indigo-500 focus:ring-4 focus:ring-indigo-500/10 transition-all outline-none"></textarea>
            </div>

            <div class="flex gap-4 pt-4 border-t border-gray-200 dark:border-slate-700">
                <button type="button" onclick="closeResponseModal()"
                        class="flex-1 px-6 py-3 bg-gray-100 dark:bg-slate-700 hover:bg-gray-200 dark:hover:bg-slate-600 text-gray-900 dark:text-white font-semibold rounded-xl transition-all">
                    Annuler
                </button>
                <button type="submit"
                        class="flex-1 flex items-center justify-center gap-2 px-6 py-3 bg-gradient-to-r from-indigo-600 via-purple-600 to-pink-600 hover:from-indigo-700 hover:via-purple-700 hover:to-pink-700 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                    </svg>
                    <span>Envoyer la Réponse</span>
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Footer -->
<jsp:include page="../../footer.jsp" />

<script>
    // Dark mode
    if (localStorage.getItem('darkMode') === 'enabled' || (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
    }

    function openResponseModal(consultationId) {
        document.getElementById('modalConsultationId').value = consultationId;
        document.getElementById('responseModal').classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    function closeResponseModal() {
        document.getElementById('responseModal').classList.remove('active');
        document.body.style.overflow = '';
        document.getElementById('expertOpinion').value = '';
        document.getElementById('recommendations').value = '';
    }

    // Close modal on outside click
    document.getElementById('responseModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeResponseModal();
        }
    });

    // Close modal on Escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeResponseModal();
        }
    });
</script>
</body>
</html>

