<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter une tache - Mini Gestionnaire de Taches</title>
    <meta name="description" content="Formulaire JSP pour ajouter une tache stockee dans la session utilisateur.">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/styles.css?v=3">
</head>
<body>
<a class="skip-link" href="#contenu">Aller au contenu</a>
<main id="contenu" class="app-shell">
    <header class="topbar">
        <div class="brand">
            <span class="brand-mark">JSP</span>
            <span class="brand-copy">
                <strong>Mini Gestionnaire de Taches</strong>
                <span>Nouvelle entree</span>
            </span>
        </div>
        <nav class="nav" aria-label="Navigation principale">
            <a href="<%= request.getContextPath() %>/index.jsp">Accueil</a>
            <a class="is-active" href="<%= request.getContextPath() %>/add-task.jsp">Ajouter</a>
            <a href="<%= request.getContextPath() %>/tasks.jsp">Mes taches</a>
        </nav>
    </header>

    <section class="panel">
        <div class="panel-header">
            <div>
                <span class="eyebrow">Creation</span>
                <h1>Ajouter une tache</h1>
                <p>Renseignez les informations principales de la tache.</p>
            </div>
            <a class="button secondary" href="<%= request.getContextPath() %>/tasks.jsp">Retour a la liste</a>
        </div>

        <% if ("missing".equals(request.getParameter("error"))) { %>
            <div class="alert error">Tous les champs sont obligatoires.</div>
        <% } else if ("date".equals(request.getParameter("error"))) { %>
            <div class="alert error">La date d'echeance est invalide.</div>
        <% } %>

        <form class="form-grid" method="post" action="<%= request.getContextPath() %>/add-task">
            <div class="field">
                <label for="title">Titre</label>
                <input id="title" name="title" type="text" maxlength="120" autocomplete="off" required>
            </div>

            <div class="field">
                <label for="description">Description</label>
                <textarea id="description" name="description" maxlength="1000" required></textarea>
            </div>

            <div class="field">
                <label for="dueDate">Date d'echeance</label>
                <input id="dueDate" name="dueDate" type="date" required>
            </div>

            <div class="hero-actions">
                <button type="submit">Enregistrer</button>
                <a class="button secondary" href="<%= request.getContextPath() %>/tasks.jsp">Annuler</a>
            </div>
        </form>
    </section>
</main>
</body>
</html>
