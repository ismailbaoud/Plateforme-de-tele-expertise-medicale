<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Détails du Fichier Médical</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 font-sans text-gray-800">

<div class="max-w-5xl mx-auto mt-10 mb-10 bg-white rounded-2xl shadow-xl overflow-hidden">
    <!-- Header -->
    <div class="bg-cyan-700 text-white p-6 flex justify-between items-center">
        <h1 class="text-3xl font-bold">Dossier Médical du Patient</h1>
        <div class="space-x-2">
            <a href="consultation?action=endingSession&status=complete"
               class="bg-emerald-500 hover:bg-emerald-600 text-white font-semibold px-4 py-2 rounded-xl transition">
                ✅ Clôturer la consultation
            </a>
            <a href="consultation?action=endingSession&status=specialistOpinion"
               class="bg-amber-500 hover:bg-amber-600 text-white font-semibold px-4 py-2 rounded-xl transition">
                🩺 Avis spécialiste
            </a>
        </div>
    </div>

    <div class="p-8 space-y-10">

        <!-- Patient Info -->
        <section class="bg-gray-50 rounded-xl border border-gray-200 p-6 shadow-sm">
            <h2 class="text-2xl font-semibold text-cyan-700 mb-4">Informations du Patient</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div><strong>Prénom:</strong> ${medicalFile.patient.firstName}</div>
                <div><strong>Nom:</strong> ${medicalFile.patient.lastName}</div>
                <div><strong>Email:</strong> ${medicalFile.patient.email}</div>
                <div><strong>Téléphone:</strong> ${medicalFile.patient.phone}</div>
                <div><strong>Taille:</strong> ${medicalFile.patient.height} cm</div>
                <div><strong>Poids:</strong> ${medicalFile.patient.weight} kg</div>
                <div><strong>Âge:</strong> ${age} ans</div>
            </div>
        </section>

        <!-- Medical File Info -->
        <section class="bg-gray-50 rounded-xl border border-gray-200 p-6 shadow-sm">
            <h2 class="text-2xl font-semibold text-cyan-700 mb-4">Paramètres Médicaux</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div><strong>Température:</strong> ${medicalFile.temperature} °C</div>
                <div><strong>Pouls:</strong> ${medicalFile.pulse} bpm</div>
                <div><strong>Pression Artérielle:</strong> ${medicalFile.bloodPresure}</div>
                <div><strong>Fréquence Respiratoire:</strong> ${medicalFile.respiratoryRate}</div>
                <div><strong>Saturation O₂:</strong> ${medicalFile.oxygenSaturation} %</div>
                <div><strong>Douleur:</strong> ${medicalFile.pain}</div>
            </div>
        </section>

        <!-- Consultation Creation Form -->
        <section class="bg-gray-50 rounded-xl border border-gray-200 p-6 shadow-sm">
            <h2 class="text-2xl font-semibold text-cyan-700 mb-4">Nouvelle Consultation</h2>
            <form action="consultation?action=update&id=${consultation.id}" method="post" class="space-y-5">
                <input type="hidden" name="medicalFileId" value="${medicalFile.id}"/>

                <div>
                    <label class="block text-gray-700 font-medium mb-1">Motif de consultation</label>
                    <input type="text" name="reason" placeholder="Ex: douleur abdominale"
                           class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-cyan-500 focus:outline-none" required>
                </div>

                <div>
                    <label class="block text-gray-700 font-medium mb-1">Symptômes (ce que le patient ressent)</label>
                    <textarea name="symptoms" placeholder="Ex: fatigue, fièvre, maux de tête..."
                              class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-cyan-500 focus:outline-none" rows="3" required></textarea>
                </div>

                <div>
                    <label class="block text-gray-700 font-medium mb-1">Examen clinique (constatations du médecin)</label>
                    <textarea name="clinicalExam" placeholder="Ex: température élevée, toux sèche..."
                              class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-cyan-500 focus:outline-none" rows="3" required></textarea>
                </div>

                <div>
                    <label class="block text-gray-700 font-medium mb-1">Observations / Diagnostic</label>
                    <textarea name="observations" placeholder="Ex: suspicion d'infection virale..."
                              class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-cyan-500 focus:outline-none" rows="3"></textarea>
                </div>

                <div class="flex justify-end">
                    <button type="submit"
                            class="bg-cyan-600 hover:bg-cyan-700 text-white px-6 py-2 rounded-xl font-medium shadow transition">
                        💾 Enregistrer la Consultation
                    </button>
                </div>
            </form>
        </section>

        <!-- Medical Acts -->
        <div class="flex justify-end">
            <a href="/medicalActs?id=${medicalFile.id}"
               class="bg-gray-100 hover:bg-gray-200 text-cyan-700 font-medium px-5 py-2 rounded-xl border border-cyan-300 shadow-sm transition">
                ➕ Ajouter des Actes Médicaux
            </a>
        </div>
    </div>
</div>

</body>
</html>
