<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Patients - Infirmière</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .patient-card {
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .patient-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .badge-gender {
            font-size: 0.85rem;
        }
        .search-highlight {
            background-color: #fff3cd;
        }
        .tab-content {
            padding-top: 20px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <i class="fas fa-hospital"></i> Système Médical - Infirmière
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/nurse/patients">
                            <i class="fas fa-users"></i> Patients
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Déconnexion
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col-md-8">
                <h2><i class="fas fa-users text-primary"></i> Liste de Tous les Patients</h2>
                <p class="text-muted">Consultez les informations de tous les patients enregistrés</p>
            </div>
            <div class="col-md-4 text-end">
                <button type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#patientModal">
                    <i class="fas fa-search"></i> <i class="fas fa-user-plus"></i> Rechercher / Enregistrer un Patient
                </button>
            </div>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty infoMessage}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                <i class="fas fa-info-circle"></i> ${infoMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0"><i class="fas fa-list"></i> Patients (${patients != null ? patients.size() : 0})</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty patients}">
                        <div class="alert alert-info text-center">
                            <i class="fas fa-info-circle"></i> Aucun patient enregistré dans le système.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover table-striped" id="patientsTable">
                                <thead class="table-primary">
                                    <tr>
                                        <th><i class="fas fa-hashtag"></i> ID</th>
                                        <th><i class="fas fa-user"></i> Nom Complet</th>
                                        <th><i class="fas fa-venus-mars"></i> Genre</th>
                                        <th><i class="fas fa-phone"></i> Téléphone</th>
                                        <th><i class="fas fa-envelope"></i> Email</th>
                                        <th><i class="fas fa-calendar"></i> Date d'inscription</th>
                                        <th class="text-center"><i class="fas fa-cogs"></i> Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="patient" items="${patients}">
                                        <tr data-patient-id="${patient.id}"
                                            data-patient-name="${patient.firstName} ${patient.lastName}"
                                            data-patient-email="${patient.email}">
                                            <td>${patient.id}</td>
                                            <td>
                                                <strong>${patient.firstName} ${patient.lastName}</strong>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${patient.gender == 'MALE'}">
                                                        <span class="badge bg-info badge-gender">
                                                            <i class="fas fa-mars"></i> Homme
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${patient.gender == 'FEMALE'}">
                                                        <span class="badge bg-danger badge-gender">
                                                            <i class="fas fa-venus"></i> Femme
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary badge-gender">N/A</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${patient.phone != null ? patient.phone : 'N/A'}</td>
                                            <td>${patient.email != null ? patient.email : 'N/A'}</td>
                                            <td>${patient.createdAt}</td>
                                            <td class="text-center">
                                                <a href="${pageContext.request.contextPath}/nurse/patients?action=view&id=${patient.id}"
                                                   class="btn btn-sm btn-primary">
                                                    <i class="fas fa-eye"></i> Voir Détails
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Modal Rechercher / Enregistrer Patient -->
    <div class="modal fade" id="patientModal" tabindex="-1" aria-labelledby="patientModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="patientModalLabel">
                        <i class="fas fa-search"></i> <i class="fas fa-user-plus"></i> Rechercher / Enregistrer un Patient
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Tabs Navigation -->
                    <ul class="nav nav-tabs" id="patientTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="search-tab" data-bs-toggle="tab" data-bs-target="#search" type="button" role="tab">
                                <i class="fas fa-search"></i> Rechercher un Patient
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="register-tab" data-bs-toggle="tab" data-bs-target="#register" type="button" role="tab">
                                <i class="fas fa-user-plus"></i> Enregistrer un Nouveau Patient
                            </button>
                        </li>
                    </ul>

                    <!-- Tabs Content -->
                    <div class="tab-content" id="patientTabsContent">
                        <!-- Tab Rechercher -->
                        <div class="tab-pane fade show active" id="search" role="tabpanel">
                            <div class="mb-3">
                                <label for="searchInput" class="form-label">
                                    <i class="fas fa-keyboard"></i> Rechercher par nom, email ou ID
                                </label>
                                <input type="text" class="form-control form-control-lg" id="searchInput"
                                       placeholder="Entrez le nom, email ou ID du patient...">
                            </div>
                            <div id="searchResults">
                                <div class="alert alert-info">
                                    <i class="fas fa-info-circle"></i> Commencez à taper pour rechercher un patient...
                                </div>
                            </div>
                        </div>

                        <!-- Tab Enregistrer -->
                        <div class="tab-pane fade" id="register" role="tabpanel">
                            <form id="registerPatientForm" method="post" action="${pageContext.request.contextPath}/nurse/patients">
                                <input type="hidden" name="action" value="register">

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="firstName" class="form-label">
                                            <i class="fas fa-user"></i> Prénom <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="firstName" name="firstName" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="lastName" class="form-label">
                                            <i class="fas fa-user"></i> Nom <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="lastName" name="lastName" required>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="username" class="form-label">
                                            <i class="fas fa-user-tag"></i> Nom d'utilisateur <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="username" name="username" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="password" class="form-label">
                                            <i class="fas fa-lock"></i> Mot de passe <span class="text-danger">*</span>
                                        </label>
                                        <input type="password" class="form-control" id="password" name="password" required>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="email" class="form-label">
                                            <i class="fas fa-envelope"></i> Email <span class="text-danger">*</span>
                                        </label>
                                        <input type="email" class="form-control" id="email" name="email" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="phone" class="form-label">
                                            <i class="fas fa-phone"></i> Téléphone
                                        </label>
                                        <input type="tel" class="form-control" id="phone" name="phone">
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="gender" class="form-label">
                                            <i class="fas fa-venus-mars"></i> Genre <span class="text-danger">*</span>
                                        </label>
                                        <select class="form-select" id="gender" name="gender" required>
                                            <option value="">Sélectionner...</option>
                                            <option value="MALE">Homme</option>
                                            <option value="FEMALE">Femme</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="alert alert-info">
                                    <i class="fas fa-info-circle"></i> Les champs marqués d'un <span class="text-danger">*</span> sont obligatoires.
                                </div>

                                <div class="d-flex justify-content-end gap-2">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                        <i class="fas fa-times"></i> Annuler
                                    </button>
                                    <button type="submit" class="btn btn-success">
                                        <i class="fas fa-save"></i> Enregistrer le Patient
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Fonction de recherche en temps réel
        document.getElementById('searchInput').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();
            const resultsDiv = document.getElementById('searchResults');

            if (searchTerm === '') {
                resultsDiv.innerHTML = '<div class="alert alert-info"><i class="fas fa-info-circle"></i> Commencez à taper pour rechercher un patient...</div>';
                return;
            }

            // Récupérer tous les patients depuis le tableau
            const tableRows = document.querySelectorAll('#patientsTable tbody tr');
            const results = [];

            tableRows.forEach(row => {
                const id = row.dataset.patientId;
                const name = row.dataset.patientName.toLowerCase();
                const email = row.dataset.patientEmail ? row.dataset.patientEmail.toLowerCase() : '';

                if (id.includes(searchTerm) || name.includes(searchTerm) || email.includes(searchTerm)) {
                    const cells = row.querySelectorAll('td');
                    results.push({
                        id: id,
                        name: row.dataset.patientName,
                        gender: cells[2].textContent.trim(),
                        phone: cells[3].textContent.trim(),
                        email: cells[4].textContent.trim(),
                        date: cells[5].textContent.trim()
                    });
                }
            });

            if (results.length === 0) {
                resultsDiv.innerHTML = '<div class="alert alert-warning"><i class="fas fa-exclamation-triangle"></i> Aucun patient trouvé pour "' + searchTerm + '"</div>';
            } else {
                let html = '<div class="alert alert-success"><i class="fas fa-check-circle"></i> ' + results.length + ' patient(s) trouvé(s)</div>';
                html += '<div class="list-group">';

                results.forEach(patient => {
                    html += '<div class="list-group-item list-group-item-action">';
                    html += '<div class="d-flex w-100 justify-content-between">';
                    html += '<h6 class="mb-1"><i class="fas fa-user"></i> ' + patient.name + '</h6>';
                    html += '<small>ID: ' + patient.id + '</small>';
                    html += '</div>';
                    html += '<p class="mb-1"><i class="fas fa-envelope"></i> ' + patient.email + ' | <i class="fas fa-phone"></i> ' + patient.phone + '</p>';
                    html += '<div class="d-flex justify-content-between align-items-center">';
                    html += '<small class="text-muted"><i class="fas fa-calendar"></i> ' + patient.date + '</small>';
                    html += '<a href="${pageContext.request.contextPath}/nurse/patients?action=view&id=' + patient.id + '" class="btn btn-sm btn-primary">';
                    html += '<i class="fas fa-eye"></i> Voir Détails</a>';
                    html += '</div>';
                    html += '</div>';
                });

                html += '</div>';
                resultsDiv.innerHTML = html;
            }
        });

        // Réinitialiser le modal quand il est fermé
        document.getElementById('patientModal').addEventListener('hidden.bs.modal', function () {
            document.getElementById('searchInput').value = '';
            document.getElementById('searchResults').innerHTML = '<div class="alert alert-info"><i class="fas fa-info-circle"></i> Commencez à taper pour rechercher un patient...</div>';
            document.getElementById('registerPatientForm').reset();
            // Réactiver l'onglet recherche
            const searchTab = new bootstrap.Tab(document.getElementById('search-tab'));
            searchTab.show();
        });
    </script>
</body>
</html>

