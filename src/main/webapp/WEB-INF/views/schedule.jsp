<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.ScheduleSlot" %>
<%@ page import="com.medicale.consultation.consultationmedicale.enums.SlotStatus" %>
<%@ page import="java.util.List" %>
<%
    List<ScheduleSlot> scheduleSlots = (List<ScheduleSlot>) request.getAttribute("scheduleSlots");

    java.util.Map<String, SlotStatus> slotMap = new java.util.HashMap<>();
    if (scheduleSlots != null) {
        for (ScheduleSlot s : scheduleSlots) {
            String key = s.getDay() + "_" + s.getTime().toString().substring(0,5);
            slotMap.put(key, s.getStatus());
        }
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Planning | Gestion des Disponibilités</title>
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
        .reserved-slot {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%) !important;
            cursor: not-allowed !important;
            position: relative;
            overflow: hidden;
        }
        .reserved-slot::after {
            content: '🔒';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 1.2rem;
            opacity: 0.3;
        }
        .slot-checkbox {
            transition: all 0.2s ease;
        }
        .slot-checkbox:checked {
            transform: scale(1.1);
        }
        .table-cell {
            transition: all 0.2s ease;
        }
        .table-cell:hover:not(.reserved-slot) {
            background-color: rgba(20, 184, 166, 0.1);
            transform: scale(1.02);
        }
    </style>
</head>
<body class="bg-white dark:bg-slate-900 min-h-screen">
<!-- Diagonal Grid Background -->
<div class="fixed inset-0 diagonal-grid"></div>

<%@include file="../../header.jsp"%>

<main class="relative z-10 min-h-screen p-6 lg:p-8">
    <div class="max-w-7xl mx-auto">
        <!-- Header Card -->
        <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 overflow-hidden mb-6">
            <div class="bg-gradient-to-r from-indigo-600 via-purple-600 to-pink-600 p-8 text-white">
                <div class="flex items-center justify-between">
                    <div class="flex items-center gap-4">
                        <div class="w-16 h-16 bg-white/20 backdrop-blur-sm rounded-2xl flex items-center justify-center">
                            <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                            </svg>
                        </div>
                        <div>
                            <h1 class="text-3xl font-bold mb-1">Mon Planning Hebdomadaire</h1>
                            <p class="text-indigo-100">Gérez vos disponibilités et créneaux horaires</p>
                        </div>
                    </div>
                    <div class="hidden md:flex items-center gap-4">
                        <div class="text-right">
                            <div class="text-2xl font-bold" id="total-slots">0</div>
                            <div class="text-sm text-indigo-100">Créneaux sélectionnés</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Legend -->
            <div class="p-6 border-b border-gray-200 dark:border-slate-700">
                <h3 class="text-sm font-semibold text-gray-700 dark:text-gray-300 mb-3">Légende :</h3>
                <div class="flex flex-wrap gap-4">
                    <div class="flex items-center gap-2">
                        <div class="w-8 h-8 bg-gradient-to-br from-green-100 to-emerald-100 dark:from-green-900/30 dark:to-emerald-900/30 border-2 border-green-300 dark:border-green-700 rounded-lg"></div>
                        <span class="text-sm text-gray-700 dark:text-gray-300 font-medium">Disponible</span>
                    </div>
                    <div class="flex items-center gap-2">
                        <div class="w-8 h-8 bg-gradient-to-br from-gray-200 to-gray-300 dark:from-gray-700 dark:to-gray-800 border-2 border-gray-400 dark:border-gray-600 rounded-lg"></div>
                        <span class="text-sm text-gray-700 dark:text-gray-300 font-medium">Bloqué par vous</span>
                    </div>
                    <div class="flex items-center gap-2">
                        <div class="w-8 h-8 bg-gradient-to-br from-blue-500 to-blue-600 border-2 border-blue-700 rounded-lg relative">
                            <span class="absolute inset-0 flex items-center justify-center text-white text-xs">🔒</span>
                        </div>
                        <span class="text-sm text-gray-700 dark:text-gray-300 font-medium">Réservé par généraliste</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Schedule Table Card -->
        <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 overflow-hidden">
            <form method="post" action="<%= request.getContextPath() %>/specialist/schedule?action=save" id="scheduleForm">
                <div class="overflow-x-auto">
                    <table class="w-full border-collapse">
                        <thead>
                        <tr class="bg-gradient-to-r from-indigo-50 via-purple-50 to-pink-50 dark:from-indigo-900/20 dark:via-purple-900/20 dark:to-pink-900/20">
                            <th class="border border-gray-200 dark:border-slate-700 px-4 py-4 text-left font-bold text-gray-900 dark:text-white">
                                <div class="flex items-center gap-2">
                                    <svg class="w-5 h-5 text-indigo-600 dark:text-indigo-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                    Heure
                                </div>
                            </th>
                            <th class="border border-gray-200 dark:border-slate-700 px-4 py-4 text-center font-bold text-gray-900 dark:text-white">
                                <div class="flex flex-col items-center gap-1">
                                    <svg class="w-5 h-5 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707" />
                                    </svg>
                                    Lundi
                                </div>
                            </th>
                            <th class="border border-gray-200 dark:border-slate-700 px-4 py-4 text-center font-bold text-gray-900 dark:text-white">
                                <div class="flex flex-col items-center gap-1">
                                    <svg class="w-5 h-5 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707" />
                                    </svg>
                                    Mardi
                                </div>
                            </th>
                            <th class="border border-gray-200 dark:border-slate-700 px-4 py-4 text-center font-bold text-gray-900 dark:text-white">
                                <div class="flex flex-col items-center gap-1">
                                    <svg class="w-5 h-5 text-purple-600 dark:text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707" />
                                    </svg>
                                    Mercredi
                                </div>
                            </th>
                            <th class="border border-gray-200 dark:border-slate-700 px-4 py-4 text-center font-bold text-gray-900 dark:text-white">
                                <div class="flex flex-col items-center gap-1">
                                    <svg class="w-5 h-5 text-orange-600 dark:text-orange-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707" />
                                    </svg>
                                    Jeudi
                                </div>
                            </th>
                            <th class="border border-gray-200 dark:border-slate-700 px-4 py-4 text-center font-bold text-gray-900 dark:text-white">
                                <div class="flex flex-col items-center gap-1">
                                    <svg class="w-5 h-5 text-pink-600 dark:text-pink-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707" />
                                    </svg>
                                    Vendredi
                                </div>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            int startHour = 8, startMinute = 30;
                            int endHour = 17, endMinute = 30;
                            int lunchStart = 12, lunchEnd = 13;
                            java.util.List<String> times = new java.util.ArrayList<>();
                            int h=startHour, m=startMinute;
                            while(h<endHour || (h==endHour && m<=endMinute)){
                                if(h<lunchStart || h>=lunchEnd){
                                    times.add(String.format("%02d:%02d", h,m));
                                }
                                m+=30;
                                if(m>=60){ m-=60; h+=1; }
                            }

                            for(String time : times){
                        %>
                        <tr class="hover:bg-gray-50 dark:hover:bg-slate-700/30 transition-colors">
                            <td class="border border-gray-200 dark:border-slate-700 px-4 py-3 font-semibold text-gray-900 dark:text-white bg-gray-50 dark:bg-slate-900/50">
                                <div class="flex items-center gap-2">
                                    <svg class="w-4 h-4 text-gray-500 dark:text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                    <%=time%>
                                </div>
                            </td>
                            <% for(int d=0; d<5; d++){
                                String key = d + "_" + time;
                                SlotStatus status = slotMap.get(key);
                                boolean isBlocked = status == SlotStatus.BLOCKED;
                                boolean isReserved = status == SlotStatus.RESERVED;
                                boolean checked = isBlocked || isReserved;
                                String cellClass = isReserved ? "reserved-slot" : "";
                            %>
                            <td class="border border-gray-200 dark:border-slate-700 px-4 py-3 text-center table-cell <%=cellClass%>">
                                <label class="flex items-center justify-center cursor-pointer <%=isReserved?"cursor-not-allowed":""%>">
                                    <input type="checkbox"
                                           class="slot-checkbox w-6 h-6 rounded-lg border-2 border-gray-300 dark:border-slate-600 focus:ring-2 focus:ring-indigo-500 text-indigo-600 transition-all"
                                           data-day="<%=d%>"
                                           data-time="<%=time%>"
                                           <%=checked?"checked":""%>
                                           <%=isReserved?"disabled":""%>>
                                    <%if(isReserved){%>
                                        <input type="hidden" name="reservedSlot" value="<%=d%>_<%=time%>">
                                    <%}%>
                                </label>
                            </td>
                            <% } %>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>

                <input type="hidden" name="selectedSlots" id="selectedSlots"/>
                
                <div class="p-6 bg-gray-50 dark:bg-slate-900/50 border-t border-gray-200 dark:border-slate-700">
                    <div class="flex flex-col sm:flex-row items-center justify-between gap-4">
                        <div class="flex items-center gap-3 text-sm text-gray-600 dark:text-gray-400">
                            <svg class="w-5 h-5 text-indigo-600 dark:text-indigo-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                            <span>Cochez les cases pour bloquer vos disponibilités</span>
                        </div>
                        <button type="submit" class="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-indigo-600 via-purple-600 to-pink-600 hover:from-indigo-700 hover:via-purple-700 hover:to-pink-700 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            <span>Enregistrer le Planning</span>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</main>

<!-- Footer -->
<jsp:include page="../../footer.jsp" />

<script>
    // Dark mode
    if (localStorage.getItem('darkMode') === 'enabled' || (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
    }

    const form = document.getElementById('scheduleForm');
    const totalSlotsEl = document.getElementById('total-slots');

    // Update slot count
    function updateSlotCount() {
        const count = document.querySelectorAll('.slot-checkbox:checked:not([disabled])').length;
        if (totalSlotsEl) {
            totalSlotsEl.textContent = count;
        }
    }

    // Add listeners to checkboxes
    document.querySelectorAll('.slot-checkbox').forEach(cb => {
        cb.addEventListener('change', updateSlotCount);
    });

    // Initial count
    updateSlotCount();

    // Submit selected slots as JSON (excluding disabled/reserved ones)
    form.addEventListener('submit', function(e){
        const selected = [];
        document.querySelectorAll('.slot-checkbox:checked:not([disabled])').forEach(cb=>{
            selected.push({ day: cb.dataset.day, time: cb.dataset.time });
        });
        document.getElementById('selectedSlots').value = JSON.stringify(selected);
    });
</script>

</body>
</html>