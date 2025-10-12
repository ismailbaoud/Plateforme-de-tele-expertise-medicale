<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.medicale.consultation.consultationmedicale.models.person.Person" %>

<%
    Person user = (Person) session.getAttribute("user");
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
    <title>Nouvelle consultation</title>
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
</head>
<body class="bg-gray-50 dark:bg-gray-900 min-h-screen text-gray-800 dark:text-gray-200 transition-colors duration-300 flex flex-col">

<jsp:include page="../../header.jsp"/>

<main class="flex-grow p-6 lg:p-8">
    <div class="max-w-4xl mx-auto">
        <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700 p-6">
            <h1 class="text-xl font-semibold text-gray-900 dark:text-white mb-6">
                Nouvelle consultation pour ${patient.firstName} ${patient.lastName}
            </h1>

            <form id="consultationForm" action="/consultation?action=create" method="post" class="space-y-6">
                <input type="hidden" name="patientId" value="${patient.id}"/>

                <!-- Reason -->
                <div>
                    <label for="reason"
                           class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Motif</label>
                    <input type="text" id="reason" name="reason" required
                           class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-1 focus:ring-blue-500 focus:border-blue-500"/>
                </div>

                <!-- Symptoms -->
                <div>
                    <label for="symptoms" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Symptômes</label>
                    <textarea id="symptoms" name="symptoms" rows="3" required
                              class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-1 focus:ring-blue-500 focus:border-blue-500"></textarea>
                </div>

                <!-- Clinical Exam -->
                <div>
                    <label for="clinicalExam" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Examen
                        clinique</label>
                    <textarea id="clinicalExam" name="clinicalExam" rows="3"
                              class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-1 focus:ring-blue-500 focus:border-blue-500"></textarea>
                </div>

                <!-- Diagnosis -->
                <div>
                    <label for="diagnosis" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Diagnostic</label>
                    <textarea id="diagnosis" name="diagnosis" rows="2"
                              class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-1 focus:ring-blue-500 focus:border-blue-500"></textarea>
                </div>

                <!-- Observations -->
                <div>
                    <label for="observations" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Observations
                        / Notes</label>
                    <textarea id="observations" name="observations" rows="3"
                              class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-1 focus:ring-blue-500 focus:border-blue-500"></textarea>
                </div>

                <!-- Treatment Plan -->
                <div>
                    <label for="treatmentPlan" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Plan
                        de traitement</label>
                    <textarea id="treatmentPlan" name="treatmentPlan" rows="3"
                              class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-1 focus:ring-blue-500 focus:border-blue-500"></textarea>
                </div>

                <!-- Medical Acts -->
                <div>
                    <h3 class="text-base font-medium text-gray-700 dark:text-gray-300 mb-3">Actes médicaux</h3>
                    <div id="actsContainer" class="space-y-2 mb-4">
                        <p class="text-sm text-gray-500 dark:text-gray-400 italic">Aucun acte médical ajouté</p>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="newActLabel"
                                   class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Libellé de
                                l'acte</label>
                            <input type="text" id="newActLabel"
                                   class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-1 focus:ring-blue-500 focus:border-blue-500"
                                   placeholder="Ex: Radiographie thorax"/>
                        </div>
                        <div>
                            <label for="newActPrice"
                                   class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Prix
                                (€)</label>
                            <input type="number" id="newActPrice" step="0.01" min="0"
                                   class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-1 focus:ring-blue-500 focus:border-blue-500"
                                   placeholder="Ex: 50"/>
                        </div>
                    </div>
                    <div class="flex justify-end mt-3">
                        <button type="button" id="addActButton"
                                class="px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 transition-colors">
                            Ajouter l'acte
                        </button>
                    </div>
                </div>

                <!-- Consultation Status -->
                <div>
                    <label for="status" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Statut
                        de la consultation</label>
                    <select id="status" name="status"
                            class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-1 focus:ring-blue-500 focus:border-blue-500">
                        <option value="COMPLETED">Terminée</option>
                        <option value="WAITING_SPECIALIST">En attente avis spécialiste</option>
                    </select>
                </div>

                <!-- Submit Button -->
                <div class="flex justify-between items-center">
                    <a href="/medicalFiles?id=${patient.id}"
                       class="text-sm text-blue-600 dark:text-blue-400 hover:underline">⬅ Retour au dossier patient</a>
                    <button type="submit" id="submitButton"
                            class="px-5 py-2 bg-blue-600 text-white text-sm font-medium rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 transition-colors">
                        Créer consultation
                    </button>
                </div>
            </form>
        </div>
    </div>
</main>

<%--<jsp:include page="footer.jsp" />--%>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const acts = [];
        const form = document.getElementById('consultationForm');
        const actsContainer = document.getElementById('actsContainer');
        const addBtn = document.getElementById('addActButton');
        const labelInput = document.getElementById('newActLabel');
        const priceInput = document.getElementById('newActPrice');
        const submitButton = document.getElementById('submitButton');

        const addAct = () => {
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
        };

        const updateActsUI = () => {
            actsContainer.innerHTML = '';

            if (acts.length === 0) {
                actsContainer.innerHTML = '<p class="text-sm text-gray-500 dark:text-gray-400 italic">Aucun acte médical ajouté</p>';
                return;
            }

            acts.forEach((act, index) => {
                const div = document.createElement('div');
                div.className = 'flex justify-between items-center border border-gray-200 dark:border-gray-600 p-3 rounded-md bg-white dark:bg-gray-700';
                div.innerHTML = `
                    <span class="text-sm text-gray-700 dark:text-gray-300">` + act.label + ` – ` + act.price + ` €</span>
                    <button type="button" class="text-red-600 dark:text-red-400 hover:text-red-800 dark:hover:text-red-300 text-sm" data-index="${index}">
                        Supprimer
                    </button>`;
                actsContainer.appendChild(div);
            });
        };

        addBtn.addEventListener('click', addAct);

        labelInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                if (labelInput.value.trim()) priceInput.focus();
            }
        });

        priceInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                addAct();
            }
        });

        actsContainer.addEventListener('click', (e) => {
            const removeButton = e.target.closest('button[data-index]');
            if (removeButton) {
                const index = parseInt(removeButton.dataset.index, 10);
                if (!isNaN(index)) {
                    acts.splice(index, 1);
                    updateActsUI();
                }
            }
        });

        form.addEventListener('submit', (e) => {
            e.preventDefault();
            form.querySelectorAll('input[name^="acts["]').forEach(input => input.remove());

            acts.forEach((act, index) => {
                const hiddenLabel = document.createElement('input');
                hiddenLabel.type = 'hidden';
                hiddenLabel.name = `acts[` + index + `].label`;
                hiddenLabel.value = act.label;
                form.appendChild(hiddenLabel);

                const hiddenPrice = document.createElement('input');
                hiddenPrice.type = 'hidden';
                hiddenPrice.name = `acts[` + index + `].price`;
                hiddenPrice.value = act.price;
                form.appendChild(hiddenPrice);
            });

            submitButton.disabled = true;
            submitButton.textContent = 'Création en cours...';
            form.submit();
        });

        updateActsUI();
    });

    // Dark mode persistence
    if (localStorage.getItem('darkMode') === 'enabled' || (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
    }
</script>

</body>
</html>