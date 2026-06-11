<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="fr.bryan.taskmanager.model.Task" %>
<%
    ArrayList<Task> tasks = (ArrayList<Task>) session.getAttribute("tasks");
    int totalTasks = tasks == null ? 0 : tasks.size();
    int completedTasks = 0;

    if (tasks != null) {
        for (Task task : tasks) {
            if (task.isCompleted()) {
                completedTasks++;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil - Mini Gestionnaire de Taches</title>
    <meta name="description" content="Application JSP et Servlets pour gerer des taches en session utilisateur.">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/styles.css?v=4">
</head>
<body>
<a class="skip-link" href="#contenu">Aller au contenu</a>
<main id="contenu" class="app-shell">
    <header class="topbar">
        <div class="brand">
            <span class="brand-mark">JSP</span>
            <span class="brand-copy">
                <strong>Mini Gestionnaire de Taches</strong>
                <span>Projet Java web</span>
            </span>
        </div>
        <nav class="nav" aria-label="Navigation principale">
            <a class="is-active" href="<%= request.getContextPath() %>/index.jsp">Accueil</a>
            <a href="<%= request.getContextPath() %>/add-task.jsp">Ajouter</a>
            <a href="<%= request.getContextPath() %>/tasks.jsp">Mes taches</a>
        </nav>
    </header>

    <section class="hero">
        <div class="hero-main">
            <span class="eyebrow">Session utilisateur</span>
            <h1>Carnet de taches JSP</h1>
            <p>
                Ajoutez vos taches, suivez leur echeance et terminez-les quand c'est fait.
            </p>
            <div class="hero-actions">
                <a class="button" href="<%= request.getContextPath() %>/add-task.jsp">Ajouter une tache</a>
                <a class="button secondary" href="<%= request.getContextPath() %>/tasks.jsp">Voir la liste</a>
            </div>
        </div>
        <div class="stats" aria-label="Statistiques des taches">
            <div class="stat">
                <span>Taches creees</span>
                <strong><%= totalTasks %></strong>
            </div>
            <div class="stat">
                <span>Taches terminees</span>
                <strong><%= completedTasks %></strong>
            </div>
        </div>
    </section>

    <section class="exercise-section" aria-labelledby="exercices-title">
        <div class="section-heading">
            <span class="eyebrow">Atelier Java</span>
            <h2 id="exercices-title">Exercices JSP</h2>
        </div>
        <div class="link-board">
            <a class="exercise-link" href="<%= request.getContextPath() %>/lesboucles.jsp">Boucles</a>
            <a class="exercise-link" href="<%= request.getContextPath() %>/lesconditions.jsp">Conditions</a>
            <a class="exercise-link" href="<%= request.getContextPath() %>/leschaines.jsp">Chaines</a>
            <a class="exercise-link" href="<%= request.getContextPath() %>/lestableaux.jsp">Tableaux</a>
        </div>
    </section>

    <section class="exercise-section" aria-labelledby="poo-title">
        <div class="section-heading">
            <span class="eyebrow">Atelier Java 2</span>
            <h2 id="poo-title">POO</h2>
        </div>
        <div class="link-board compact-board">
            <a class="exercise-link" href="<%= request.getContextPath() %>/lesobjets.jsp">Objets</a>
            <a class="exercise-link" href="<%= request.getContextPath() %>/lesconstructeurs.jsp">Constructeurs</a>
            <a class="exercise-link" href="<%= request.getContextPath() %>/lepolymorphisme.jsp">Polymorphisme</a>
        </div>
    </section>
</main>
</body>
</html>
