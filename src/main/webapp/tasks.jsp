<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="fr.bryan.taskmanager.model.Task" %>
<%!
    private String escapeHtml(String value) {
        if (value == null) {
            return "";
        }

        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>
<%
    ArrayList<Task> tasks = (ArrayList<Task>) session.getAttribute("tasks");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes taches - Mini Gestionnaire de Taches</title>
    <meta name="description" content="Liste des taches stockees dans la session utilisateur avec suppression et statut termine.">
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
                <span>Liste en session</span>
            </span>
        </div>
        <nav class="nav" aria-label="Navigation principale">
            <a href="<%= request.getContextPath() %>/index.jsp">Accueil</a>
            <a href="<%= request.getContextPath() %>/add-task.jsp">Ajouter</a>
            <a class="is-active" href="<%= request.getContextPath() %>/tasks.jsp">Mes taches</a>
        </nav>
    </header>

    <section class="panel">
        <div class="panel-header">
            <div>
                <span class="eyebrow">Tableau de bord</span>
                <h1>Mes taches</h1>
                <p>Ajoutez, terminez ou supprimez vos taches.</p>
            </div>
            <a class="button" href="<%= request.getContextPath() %>/add-task.jsp">Ajouter</a>
        </div>

        <% if ("true".equals(request.getParameter("added"))) { %>
            <div class="alert success">La tache a bien ete ajoutee.</div>
        <% } else if ("true".equals(request.getParameter("deleted"))) { %>
            <div class="alert success">La tache a bien ete supprimee.</div>
        <% } else if ("true".equals(request.getParameter("updated"))) { %>
            <div class="alert success">Le statut de la tache a ete mis a jour.</div>
        <% } %>

        <% if (tasks == null || tasks.isEmpty()) { %>
            <div class="empty">
                <p>Aucune tache pour le moment.</p>
                <a class="button" href="<%= request.getContextPath() %>/add-task.jsp">Ajouter une tache</a>
            </div>
        <% } else { %>
            <div class="task-list">
                <% int taskNumber = 1; %>
                <% for (Task task : tasks) { %>
                    <article class="task-card <%= task.isCompleted() ? "completed" : "" %>">
                        <span class="task-index"><%= String.format("%02d", taskNumber++) %></span>
                        <div>
                            <h2><%= escapeHtml(task.getTitle()) %></h2>
                            <p><%= escapeHtml(task.getDescription()) %></p>
                            <div class="task-meta">
                                <span class="badge">Echeance : <%= task.getDueDate() %></span>
                                <% if (task.isCompleted()) { %>
                                    <span class="badge done">Terminee</span>
                                <% } else { %>
                                    <span class="badge">En cours</span>
                                <% } %>
                            </div>
                        </div>

                        <div class="task-actions">
                            <form method="post" action="<%= request.getContextPath() %>/complete-task">
                                <input type="hidden" name="id" value="<%= task.getId() %>">
                                <button type="submit" class="secondary">
                                    <%= task.isCompleted() ? "Reouvrir" : "Terminer" %>
                                </button>
                            </form>
                            <form method="post" action="<%= request.getContextPath() %>/delete-task">
                                <input type="hidden" name="id" value="<%= task.getId() %>">
                                <button type="submit" class="danger">Supprimer</button>
                            </form>
                        </div>
                    </article>
                <% } %>
            </div>
        <% } %>
    </section>
</main>
</body>
</html>
