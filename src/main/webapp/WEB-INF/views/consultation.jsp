<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Person" %>

<%
    Person user = (Person) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>
<%!
    // Simple HTML escape function to replace fn:escapeXml
    String escapeHtml(String input) {
        if (input == null) return "";
        return input.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#x27;");
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle consultation</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
    </style>
</head>

<body class="bg-white dark:bg-slate-900 min-h-screen">
<!-- Diagonal Grid Background -->
<div class="fixed inset-0 diagonal-grid"></div>

<jsp:include page="/header.jsp" />

<main class="relative z-10 min-h-screen p-6 lg:p-8">
    <div class="max-w-5xl mx-auto">
        <div class="bg-white/95 dark:bg-slate-800/95 backdrop-blur-xl rounded-3xl shadow-xl border border-gray-200/50 dark:border-slate-700/50 overflow-hidden">
            <!-- Header -->
            <div class="bg-gradient-to-r from-green-600 to-emerald-600 p-8 text-white">
                <div class="flex items-center gap-4">
                    <div class="w-14 h-14 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center">
                        <svg class="w-7 h-7" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                        </svg>
                    </div>
                    <div>
                        <h1 class="text-2xl font-bold mb-1">Nouvelle Consultation</h1>
                        <p class="text-green-100">Patient: <c:out value="${patient.firstName} ${patient.lastName}"/></p>
                    </div>
                </div>
            </div>

            <!-- Form -->
            <div class="p-8">
                <form id="consultationForm" action="<%= request.getContextPath() %>/consultations?action=create" method="post" class="space-y-6" novalidate>
                    <input type="hidden" name="patientId" value="<c:out value='${patient.id}'/>"/>
                    <input type="hidden" name="selectedSlot" id="selectedSlot"/>
                    <input type="hidden" name="selectedSpecialistId" id="selectedSpecialistId"/>

                    <!-- Motif & Symptômes -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="reason" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Motif</label>
                            <input type="text" id="reason" name="reason" required
                                   class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-green-500 focus:ring-4 focus:ring-green-500/10 transition-all outline-none"/>
                            <p class="text-red-500 text-xs mt-1 hidden" id="reason-error">Veuillez entrer un motif</p>
                        </div>
                        <div>
                            <label for="diagnosis" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Diagnostic</label>
                            <input type="text" id="diagnosis" name="diagnosis"
                                   class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-green-500 focus:ring-4 focus:ring-green-500/10 transition-all outline-none"/>
                        </div>
                    </div>

                    <div>
                        <label for="symptoms" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Symptômes</label>
                        <textarea id="symptoms" name="symptoms" rows="3" required
                                  class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-green-500 focus:ring-4 focus:ring-green-500/10 transition-all outline-none"></textarea>
                        <p class="text-red-500 text-xs mt-1 hidden" id="symptoms-error">Veuillez entrer les symptômes</p>
                    </div>

                    <div>
                        <label for="clinicalExam" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Examen clinique</label>
                        <textarea id="clinicalExam" name="clinicalExam" rows="3"
                                  class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-green-500 focus:ring-4 focus:ring-green-500/10 transition-all outline-none"></textarea>
                    </div>

                    <div>
                        <label for="observations" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Observations / Notes</label>
                        <textarea id="observations" name="observations" rows="3"
                                  class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-green-500 focus:ring-4 focus:ring-green-500/10 transition-all outline-none"></textarea>
                    </div>

                    <div>
                        <label for="treatmentPlan" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Plan de traitement</label>
                        <textarea id="treatmentPlan" name="treatmentPlan" rows="3"
                                  class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-green-500 focus:ring-4 focus:ring-green-500/10 transition-all outline-none"></textarea>
                    </div>

                    <!-- Medical Acts -->
                    <div class="bg-blue-50 dark:bg-blue-900/20 rounded-2xl border border-blue-200 dark:border-blue-800 p-6">
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Actes médicaux</h3>
                        <div id="actsContainer" class="space-y-2 mb-4">
                            <p class="text-sm text-gray-500 dark:text-gray-400 italic">Aucun acte médical ajouté</p>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                            <div>
                                <label for="newActLabel" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Libellé de l'acte</label>
                                <input type="text" id="newActLabel" placeholder="Ex: Radiographie thorax"
                                       class="w-full px-4 py-3 bg-white dark:bg-slate-800 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-blue-500 focus:ring-4 focus:ring-blue-500/10 transition-all outline-none"/>
                            </div>
                            <div>
                                <label for="newActPrice" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Prix (€)</label>
                                <input type="number" id="newActPrice" step="0.01" min="0" placeholder="Ex: 50"
                                       class="w-full px-4 py-3 bg-white dark:bg-slate-800 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-blue-500 focus:ring-4 focus:ring-blue-500/10 transition-all outline-none"/>
                            </div>
                        </div>
                        <div class="flex justify-end">
                            <button type="button" id="addActButton"
                                    class="flex items-center gap-2 px-5 py-2.5 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                                </svg>
                                <span>Ajouter l'acte</span>
                            </button>
                        </div>
                    </div>

                    <!-- Status -->
                    <div>
                        <label for="status" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Statut de la consultation</label>
                        <select id="status" name="status"
                                class="w-full px-4 py-3 bg-gray-50 dark:bg-slate-900/50 border-2 border-gray-200 dark:border-slate-700 rounded-xl text-gray-900 dark:text-white focus:border-green-500 focus:ring-4 focus:ring-green-500/10 transition-all outline-none">
                            <option value="COMPLETED">Terminée</option>
                            <option value="WAITING_SPECIALIST">En attente avis spécialiste</option>
                        </select>
                    </div>

                    <!-- Specialist Section -->
                    <div id="specialistSection" class="hidden bg-purple-50 dark:bg-purple-900/20 rounded-2xl border border-purple-200 dark:border-purple-800 p-6">
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Sélection du spécialiste</h3>

                        <!-- Filter -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                            <div>
                                <label for="filterSpecialty" class="block text-sm text-gray-700 dark:text-gray-300 mb-1">Spécialité</label>
                                <select id="filterSpecialty" class="w-full px-3 py-2 border rounded-xl focus:ring-2 focus:ring-green-500">
                                    <option value="">Toutes</option>
                                    <c:forEach var="s" items="${specialists}">
                                        <c:if test="${not empty s.speciality}">
                                            <option value="${s.speciality}"><c:out value="${s.speciality}"/></option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label for="filterFee" class="block text-sm text-gray-700 dark:text-gray-300 mb-1">Frais max (€)</label>
                                <input type="number" id="filterFee" min="0" step="0.01"
                                       class="w-full px-3 py-2 border rounded-xl focus:ring-2 focus:ring-green-500"
                                       placeholder="Ex: 120"/>
                            </div>
                        </div>

                        <!-- Specialist List -->
                        <div id="specialistList" class="space-y-3 max-h-64 overflow-y-auto">
                            <c:if test="${empty specialists}">
                                <p class="text-sm text-gray-500 dark:text-gray-400 italic">Aucun spécialiste trouvé.</p>
                            </c:if>
                            <c:forEach var="s" items="${specialists}">
                                <div class="specialist-card p-4 bg-white dark:bg-slate-800 rounded-xl border-2 border-gray-200 dark:border-slate-700 flex justify-between items-center cursor-pointer"
                                     data-specialty="${s.speciality}" data-fee="${s.fee}">
                                    <div>
                                        <p class="text-sm font-semibold text-gray-900 dark:text-white"><c:out value="${s.firstName} ${s.lastName}"/></p>
                                        <p class="text-xs text-gray-500 dark:text-gray-400"><c:out value="${s.email}"/></p>
                                        <p class="text-xs text-gray-500 dark:text-gray-400">Spécialité: <c:out value="${s.speciality}"/>, Frais: ${s.fee}€</p>
                                    </div>
                                    <input type="radio" name="tempSpecialistId" value="${s.id}" class="w-5 h-5 text-purple-600 focus:ring-purple-500 specialist-radio" aria-label="Sélectionner <c:out value='${s.firstName} ${s.lastName}'/>"/>
                                </div>

                                <!-- Calendar -->
                                <div id="calendar-${s.id}" class="mt-2 hidden">
                                    <div class="overflow-x-auto rounded-2xl border border-gray-200 dark:border-slate-700">
                                        <table class="w-full border-collapse">
                                            <thead>
                                            <tr class="bg-gradient-to-r from-purple-50 to-pink-50 dark:from-purple-900/20 dark:to-pink-900/20">
                                                <th class="border px-4 py-2 text-left font-semibold">Heure</th>
                                                <th class="border px-4 py-2 text-center font-semibold">Lundi</th>
                                                <th class="border px-4 py-2 text-center font-semibold">Mardi</th>
                                                <th class="border px-4 py-2 text-center font-semibold">Mercredi</th>
                                                <th class="border px-4 py-2 text-center font-semibold">Jeudi</th>
                                                <th class="border px-4 py-2 text-center font-semibold">Vendredi</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:set var="times" value="${['08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30']}"/>
                                            <c:forEach var="time" items="${times}">
                                                <tr>
                                                    <td class="border px-4 py-2 font-medium">${time}</td>
                                                    <c:forEach var="day" begin="0" end="4">
                                                        <c:set var="slot" value="${null}"/>
                                                        <c:forEach var="sl" items="${schedules}">
                                                            <c:if test="${sl.specialist.id == s.id && sl.day == day && sl.time == time}">
                                                                <c:set var="slot" value="${sl}" />
                                                            </c:if>
                                                        </c:forEach>

                                                        <c:set var="bgClass" value="${slot == null ? 'bg-green-500 text-white' : slot.status == 'BLOCKED' ? 'bg-red-500 text-white' : slot.status == 'RESERVED' ? 'bg-blue-500 text-white' : 'bg-green-500 text-white'}"/>
                                                        <td class="border px-4 py-2 text-center ${bgClass}">
                                                            <input type="checkbox"
                                                                   class="slot-checkbox w-5 h-5 rounded border-gray-300 dark:border-slate-600 cursor-pointer"
                                                                   name="slot"
                                                                   data-day="${day}"
                                                                   data-time="${time}"
                                                                   data-specialist="${s.id}"
                                                                ${slot.status == 'BLOCKED' ? 'checked disabled' : slot != null && slot.status == 'RESERVED' ? 'disabled' : ''}
                                                                   aria-label="Créneau à ${time}"/>
                                                        </td>
                                                    </c:forEach>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <p class="text-red-500 text-xs mt-1 hidden" id="specialist-error">Veuillez sélectionner un spécialiste et un créneau</p>
                    </div>

                    <!-- Buttons -->
                    <div class="flex justify-between items-center pt-4">
                        <a href="/medicalFiles?id=<c:out value='${patient.id}'/>"
                           class="flex items-center gap-2 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white font-medium transition-colors">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                            </svg>
                            <span>Retour au dossier patient</span>
                        </a>
                        <button type="submit"
                                class="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-green-600 to-emerald-600 hover:from-green-700 hover:to-emerald-700 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all disabled:opacity-50"
                                disabled>
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                            </svg>
                            <span>Créer consultation</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Medical Acts Logic
        const acts = [];
        const form = document.getElementById('consultationForm');
        const actsContainer = document.getElementById('actsContainer');
        const addBtn = document.getElementById('addActButton');
        const labelInput = document.getElementById('newActLabel');
        const priceInput = document.getElementById('newActPrice');
        const statusSelect = document.getElementById('status');
        const specialistSection = document.getElementById('specialistSection');
        const filterSpecialty = document.getElementById('filterSpecialty');
        const filterFee = document.getElementById('filterFee');
        const specialistCards = document.querySelectorAll('.specialist-card');
        const submitButton = form.querySelector('button[type="submit"]');
        const reasonInput = document.getElementById('reason');
        const symptomsInput = document.getElementById('symptoms');
        const reasonError = document.getElementById('reason-error');
        const symptomsError = document.getElementById('symptoms-error');
        const specialistError = document.getElementById('specialist-error');
        const selectedSlotInput = document.getElementById('selectedSlot');
        const selectedSpecialistInput = document.getElementById('selectedSpecialistId');

        // Update acts UI
        const updateActsUI = () => {
            actsContainer.innerHTML = '';
            if (acts.length === 0) {
                actsContainer.innerHTML = '<p class="text-sm text-gray-500 dark:text-gray-400 italic">Aucun acte médical ajouté</p>';
                return;
            }
            acts.forEach((act, index) => {
                const div = document.createElement('div');
                div.className = 'flex justify-between items-center p-3 bg-white dark:bg-slate-800 rounded-xl border border-gray-200 dark:border-slate-700';
                div.innerHTML = `
                    <span class="text-sm font-medium text-gray-900 dark:text-white">`+act.label+` – `+act.price+` €</span>
                    <button type="button" class="text-red-600 dark:text-red-400 hover:text-red-800 dark:hover:text-red-300 text-sm font-medium" data-index="`+index+`">Supprimer</button>
                `;
                actsContainer.appendChild(div);
            });
        };

        // Add act
        addBtn.addEventListener('click', (e) => {
            e.preventDefault();
            const label = labelInput.value.trim();
            const price = priceInput.value.trim();
            if (!label || !price || parseFloat(price) < 0) {
                alert("Veuillez remplir un libellé valide et un prix positif pour l'acte.");
                return;
            }
            acts.push({label: label, price: parseFloat(price).toFixed(2)});
            updateActsUI();
            labelInput.value = '';
            priceInput.value = '';
            labelInput.focus();
        });

        // Remove act
        actsContainer.addEventListener('click', (e) => {
            const removeBtn = e.target.closest('button[data-index]');
            if (removeBtn) {
                acts.splice(parseInt(removeBtn.dataset.index), 1);
                updateActsUI();
            }
        });

        // Form submission for acts
        form.addEventListener('submit', (e) => {
            form.querySelectorAll('input[name^="acts["]').forEach(i => i.remove());
            acts.forEach((act, index) => {
                const hiddenLabel = document.createElement('input');
                hiddenLabel.type = 'hidden';
                hiddenLabel.name = `acts[${index}].label`;
                hiddenLabel.value = act.label;
                form.appendChild(hiddenLabel);

                const hiddenPrice = document.createElement('input');
                hiddenPrice.type = 'hidden';
                hiddenPrice.name = `acts[${index}].price`;
                hiddenPrice.value = act.price;
                form.appendChild(hiddenPrice);
            });
        });

        // Specialist Section Toggle
        statusSelect.addEventListener('change', () => {
            if (statusSelect.value === 'WAITING_SPECIALIST') {
                specialistSection.classList.remove('hidden');
            } else {
                specialistSection.classList.add('hidden');
                document.querySelectorAll('input[name="tempSpecialistId"]').forEach(radio => radio.checked = false);
                document.querySelectorAll('.slot-checkbox').forEach(checkbox => {
                    checkbox.checked = false;
                    if (!checkbox.hasAttribute('disabled')) checkbox.disabled = false;
                });
                document.querySelectorAll('[id^="calendar-"]').forEach(c => c.classList.add('hidden'));
                selectedSlotInput.value = '';
                selectedSpecialistInput.value = '';
            }
            updateSubmitButton();
        });

        // Filter specialists
        function applyFilter() {
            const speciality = filterSpecialty.value;
            const fee = parseFloat(filterFee.value) || Infinity;
            specialistCards.forEach(card => {
                const s = card.dataset.specialty;
                const f = parseFloat(card.dataset.fee);
                card.style.display = (!speciality || s === speciality) && f <= fee ? 'flex' : 'none';
            });
        }

        // Update submit button state
        function updateSubmitButton() {
            const reasonFilled = reasonInput.value.trim().length > 0;
            const symptomsFilled = symptomsInput.value.trim().length > 0;
            const specialistSelected = selectedSpecialistInput.value;
            const slotSelected = selectedSlotInput.value;
            const isWaitingSpecialist = statusSelect.value === 'WAITING_SPECIALIST';
            submitButton.disabled = !(reasonFilled && symptomsFilled && (!isWaitingSpecialist || (specialistSelected && slotSelected)));
        }

        // Filter events
        filterSpecialty.addEventListener('change', applyFilter);
        filterFee.addEventListener('input', applyFilter);

        // Specialist selection
        document.querySelectorAll('input[name="tempSpecialistId"]').forEach(radio => {
            radio.addEventListener('change', () => {
                document.querySelectorAll('[id^="calendar-"]').forEach(c => c.classList.add('hidden'));
                const calendar = document.getElementById('calendar-' + radio.value);
                if (calendar) calendar.classList.remove('hidden');
                selectedSpecialistInput.value = Number(radio.value);
                document.querySelectorAll('.slot-checkbox').forEach(checkbox => {
                    checkbox.checked = false;
                    if (!checkbox.hasAttribute('disabled')) checkbox.disabled = false;
                });
                selectedSlotInput.value = '';
                updateSubmitButton();
            });
        });

        // Slot selection logic
        document.querySelectorAll('.slot-checkbox').forEach(checkbox => {
            checkbox.addEventListener('change', () => {
                const calendar = checkbox.closest('[id^="calendar-"]');
                const allCheckboxes = calendar.querySelectorAll('.slot-checkbox');

                if (checkbox.checked && !checkbox.disabled) {
                    // Disable others when one is selected
                    allCheckboxes.forEach(other => {
                        if (other !== checkbox && !other.hasAttribute('disabled')) {
                            other.disabled = true;
                        }
                    });
                    selectedSlotInput.value = JSON.stringify({
                        specialistId: Number(checkbox.dataset.specialist),
                        day: Number(checkbox.dataset.day),
                        time: checkbox.dataset.time
                    });
                } else {
                    // If none is checked, re-enable all
                    const hasChecked = Array.from(allCheckboxes).some(cb => cb.checked && !cb.hasAttribute('disabled'));
                    if (!hasChecked) {
                        allCheckboxes.forEach(other => {
                            if (!other.hasAttribute('disabled')) {
                                other.disabled = false;
                            }
                        });
                        selectedSlotInput.value = '';
                    }
                }

                updateSubmitButton();
            });
        });

        // Form validation
        reasonInput.addEventListener('input', () => {
            reasonError.classList.toggle('hidden', reasonInput.value.trim().length > 0);
            updateSubmitButton();
        });
        symptomsInput.addEventListener('input', () => {
            symptomsError.classList.toggle('hidden', symptomsInput.value.trim().length > 0);
            updateSubmitButton();
        });
        form.addEventListener('submit', (e) => {
            let valid = true;
            if (!reasonInput.value.trim()) {
                reasonError.classList.remove('hidden');
                valid = false;
            }
            if (!symptomsInput.value.trim()) {
                symptomsError.classList.remove('hidden');
                valid = false;
            }
            if (statusSelect.value === 'WAITING_SPECIALIST' && (!selectedSpecialistInput.value || !selectedSlotInput.value)) {
                specialistError.classList.remove('hidden');
                valid = false;
            }
            if (!valid) {
                e.preventDefault();
            }
        });

        // Dark mode
        if (localStorage.getItem('darkMode') === 'enabled' ||
            (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
            document.documentElement.classList.add('dark');
        }

        // Initial filter and button state
        applyFilter();
        updateSubmitButton();
    });
</script>
</body>
</html>

