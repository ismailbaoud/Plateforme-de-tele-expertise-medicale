<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails du Patient - Infirmière</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .info-card {
            border-left: 4px solid #0d6efd;
        }
        .vital-signs-card {
            border-left: 4px solid #dc3545;
        }
        .consultation-card {
            border-left: 4px solid #198754;
            margin-bottom: 15px;
        }
        .section-title {
            border-bottom: 2px solid #0d6efd;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .status-badge {
            font-size: 0.9rem;
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/nurse/patients">
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

    <div class="container mt-4 mb-5">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/nurse/patients">
                        <i class="fas fa-users"></i> Patients
                    </a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                    ${patient.firstName} ${patient.lastName}
                </li>
            </ol>
        </nav>

        <!-- Patient Information Card -->
        <div class="card info-card shadow mb-4">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">
                    <i class="fas fa-user-circle"></i> Informations du Patient
                </h4>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <p><strong><i class="fas fa-id-badge text-primary"></i> ID:</strong> ${patient.id}</p>
                        <p><strong><i class="fas fa-user text-primary"></i> Nom Complet:</strong> ${patient.firstName} ${patient.lastName}</p>
                        <p><strong><i class="fas fa-user-tag text-primary"></i> Nom d'utilisateur:</strong> ${patient.username}</p>
                        <p>
                            <strong><i class="fas fa-venus-mars text-primary"></i> Genre:</strong>
                            <c:choose>
                                <c:when test="${patient.gender == 'MALE'}">
                                    <span class="badge bg-info"><i class="fas fa-mars"></i> Homme</span>
                                </c:when>
                                <c:when test="${patient.gender == 'FEMALE'}">
                                    <span class="badge bg-danger"><i class="fas fa-venus"></i> Femme</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">N/A</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <div class="col-md-6">
                        <p><strong><i class="fas fa-phone text-primary"></i> Téléphone:</strong> ${patient.phone != null ? patient.phone : 'Non renseigné'}</p>
                        <p><strong><i class="fas fa-envelope text-primary"></i> Email:</strong> ${patient.email != null ? patient.email : 'Non renseigné'}</p>
                        <p><strong><i class="fas fa-calendar-plus text-primary"></i> Date d'inscription:</strong> ${patient.createdAt}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Medical Files Section -->
        <div class="card shadow mb-4">
            <div class="card-header bg-danger text-white">
                <h4 class="mb-0">
                    <i class="fas fa-folder-open"></i> Dossiers Médicaux (${medicalFiles.size()})
                </h4>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty medicalFiles}">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle"></i> Aucun dossier médical disponible pour ce patient.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="file" items="${medicalFiles}">
                            <div class="card vital-signs-card mb-3">
                                <div class="card-body">
                                    <h5 class="card-title">
                                        <i class="fas fa-file-medical text-danger"></i> Dossier Médical #${file.id}
                                    </h5>

                                    <div class="row mt-3">
                                        <div class="col-md-6">
                                            <h6 class="text-danger"><i class="fas fa-stethoscope"></i> Informations Médicales</h6>
                                            <p><strong>Diagnostic:</strong> ${file.diagnosis != null ? file.diagnosis : 'Non renseigné'}</p>
                                            <p><strong>Plan de traitement:</strong> ${file.treatmentPlan != null ? file.treatmentPlan : 'Non renseigné'}</p>
                                            <p><strong>Prescriptions:</strong> ${file.prescriptions != null ? file.prescriptions : 'Aucune'}</p>
                                            <p><strong>Notes:</strong> ${file.notes != null ? file.notes : 'Aucune'}</p>
                                        </div>

                                        <div class="col-md-6">
                                            <h6 class="text-danger"><i class="fas fa-heartbeat"></i> Signes Vitaux</h6>
                                            <div class="row">
                                                <div class="col-6">
                                                    <p><strong>Température:</strong>
                                                        <c:choose>
                                                            <c:when test="${file.temperature != null}">
                                                                ${file.temperature}°C
                                                            </c:when>
                                                            <c:otherwise>N/A</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <p><strong>Pouls:</strong>
                                                        <c:choose>
                                                            <c:when test="${file.pulse != null}">
                                                                ${file.pulse} bpm
                                                            </c:when>
                                                            <c:otherwise>N/A</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <p><strong>Pression artérielle:</strong>
                                                        <c:choose>
                                                            <c:when test="${file.bloodPresure != null}">
                                                                ${file.bloodPresure} mmHg
                                                            </c:when>
                                                            <c:otherwise>N/A</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                                <div class="col-6">
                                                    <p><strong>Rythme respiratoire:</strong>
                                                        <c:choose>
                                                            <c:when test="${file.respiratoryRate != null}">
                                                                ${file.respiratoryRate} /min
                                                            </c:when>
                                                            <c:otherwise>N/A</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <p><strong>Saturation O2:</strong>
                                                        <c:choose>
                                                            <c:when test="${file.oxygenSaturation != null}">
                                                                ${file.oxygenSaturation}%
                                                            </c:when>
                                                            <c:otherwise>N/A</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <p><strong>Douleur:</strong>
                                                        <c:choose>
                                                            <c:when test="${file.pain != null}">
                                                                ${file.pain}/10
                                                            </c:when>
                                                            <c:otherwise>N/A</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mt-3">
                                        <small class="text-muted">
                                            <i class="fas fa-clock"></i> Créé le: ${file.createdAt}
                                            <c:if test="${file.updatedAt != null}">
                                                | Mis à jour le: ${file.updatedAt}
                                            </c:if>
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Consultations Section -->
        <div class="card shadow mb-4">
            <div class="card-header bg-success text-white">
                <h4 class="mb-0">
                    <i class="fas fa-notes-medical"></i> Historique des Consultations (${consultations.size()})
                </h4>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty consultations}">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle"></i> Aucune consultation enregistrée pour ce patient.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="consultation" items="${consultations}">
                            <div class="card consultation-card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <h5 class="card-title">
                                            <i class="fas fa-file-medical-alt text-success"></i> Consultation #${consultation.id}
                                        </h5>
                                        <span class="status-badge">
                                            <c:choose>
                                                <c:when test="${consultation.consultationStatus == 'PENDING'}">
                                                    <span class="badge bg-warning text-dark">
                                                        <i class="fas fa-clock"></i> En Attente
                                                    </span>
                                                </c:when>
                                                <c:when test="${consultation.consultationStatus == 'COMPLETED'}">
                                                    <span class="badge bg-success">
                                                        <i class="fas fa-check-circle"></i> Complétée
                                                    </span>
                                                </c:when>
                                                <c:when test="${consultation.consultationStatus == 'CANCELLED'}">
                                                    <span class="badge bg-danger">
                                                        <i class="fas fa-times-circle"></i> Annulée
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${consultation.consultationStatus}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>

                                    <div class="row mt-3">
                                        <div class="col-md-6">
                                            <p><strong><i class="fas fa-calendar text-success"></i> Date:</strong> ${consultation.createdAt}</p>
                                            <p><strong><i class="fas fa-clipboard-list text-success"></i> Raison:</strong> ${consultation.reason != null ? consultation.reason : 'Non spécifiée'}</p>
                                            <p><strong><i class="fas fa-user-md text-success"></i> Médecin:</strong>
                                                <c:choose>
                                                    <c:when test="${consultation.generalist != null}">
                                                        Dr. ${consultation.generalist.firstName} ${consultation.generalist.lastName}
                                                    </c:when>
                                                    <c:otherwise>Non assigné</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p><strong><i class="fas fa-thermometer text-success"></i> Symptômes:</strong>
                                                ${consultation.symptoms != null ? consultation.symptoms : 'Non renseignés'}
                                            </p>
                                            <p><strong><i class="fas fa-stethoscope text-success"></i> Examen clinique:</strong>
                                                ${consultation.clinicalExam != null ? consultation.clinicalExam : 'Non effectué'}
                                            </p>
                                        </div>
                                    </div>

                                    <c:if test="${consultation.diagnosis != null || consultation.treatmentPlan != null}">
                                        <hr>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <p><strong><i class="fas fa-diagnoses text-success"></i> Diagnostic:</strong>
                                                    ${consultation.diagnosis}
                                                </p>
                                            </div>
                                            <div class="col-md-6">
                                                <p><strong><i class="fas fa-prescription text-success"></i> Plan de traitement:</strong>
                                                    ${consultation.treatmentPlan}
                                                </p>
                                            </div>
                                        </div>
                                    </c:if>

                                    <c:if test="${consultation.observations != null}">
                                        <hr>
                                        <p><strong><i class="fas fa-comment-medical text-success"></i> Observations:</strong></p>
                                        <p class="text-muted">${consultation.observations}</p>
                                    </c:if>

                                    <c:if test="${consultation.recommendations != null}">
                                        <p><strong><i class="fas fa-lightbulb text-success"></i> Recommandations:</strong></p>
                                        <p class="text-muted">${consultation.recommendations}</p>
                                    </c:if>

                                    <c:if test="${consultation.updatedAt != null}">
                                        <div class="mt-2">
                                            <small class="text-muted">
                                                <i class="fas fa-edit"></i> Dernière mise à jour: ${consultation.updatedAt}
                                            </small>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Back Button -->
        <div class="text-center">
            <a href="${pageContext.request.contextPath}/nurse/patients" class="btn btn-primary btn-lg">
                <i class="fas fa-arrow-left"></i> Retour à la liste des patients
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

