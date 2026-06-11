<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

    private String repeat(String text, int count) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < count; i++) {
            builder.append(text);
        }
        return builder.toString();
    }

    private String square(int size) {
        StringBuilder builder = new StringBuilder();
        for (int row = 0; row < size; row++) {
            builder.append(repeat("*", size)).append('\n');
        }
        return builder.toString();
    }

    private String leftTriangle(int size) {
        StringBuilder builder = new StringBuilder();
        for (int row = 1; row <= size; row++) {
            builder.append(repeat("*", row)).append('\n');
        }
        return builder.toString();
    }

    private String invertedTriangle(int size) {
        StringBuilder builder = new StringBuilder();
        for (int row = size; row >= 1; row--) {
            builder.append(repeat("*", row)).append('\n');
        }
        return builder.toString();
    }

    private String rightTriangle(int size) {
        StringBuilder builder = new StringBuilder();
        for (int row = 1; row <= size; row++) {
            builder.append(repeat(" ", size - row)).append(repeat("*", row)).append('\n');
        }
        return builder.toString();
    }

    private String isoscelesTriangle(int size) {
        StringBuilder builder = new StringBuilder();
        for (int row = 1; row <= size; row++) {
            builder.append(repeat(" ", size - row)).append(repeat("*", (row * 2) - 1)).append('\n');
        }
        return builder.toString();
    }

    private String halfDiamond(int size) {
        StringBuilder builder = new StringBuilder();
        for (int row = 1; row <= size; row++) {
            builder.append(repeat(" ", size - row)).append(repeat("*", row)).append('\n');
        }
        for (int row = size - 1; row >= 1; row--) {
            builder.append(repeat(" ", size - row)).append(repeat("*", row)).append('\n');
        }
        return builder.toString();
    }

    private String multiplicationTable(int value) {
        StringBuilder builder = new StringBuilder();
        for (int number = 1; number <= value; number++) {
            builder.append(value).append(" x ").append(number).append(" = ").append(value * number).append('\n');
        }
        return builder.toString();
    }
%>
<%
    String rawValue = request.getParameter("valeur");
    Integer value = null;
    String error = null;

    if (rawValue != null && !rawValue.trim().isEmpty()) {
        try {
            value = Integer.parseInt(rawValue.trim());
            if (value <= 0 || value > 30) {
                error = "Saisissez un nombre entre 1 et 30.";
                value = null;
            }
        } catch (NumberFormatException exception) {
            error = "La valeur doit etre un nombre entier.";
        }
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Boucles - Atelier Java</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/styles.css?v=4">
</head>
<body>
<a class="skip-link" href="#contenu">Aller au contenu</a>
<main id="contenu" class="app-shell">
    <header class="topbar">
        <div class="brand">
            <span class="brand-mark">JSP</span>
            <span class="brand-copy">
                <strong>Atelier Java</strong>
                <span>Boucles</span>
            </span>
        </div>
        <nav class="nav" aria-label="Navigation principale">
            <a href="<%= request.getContextPath() %>/index.jsp">Accueil</a>
            <a href="<%= request.getContextPath() %>/lesconditions.jsp">Conditions</a>
            <a href="<%= request.getContextPath() %>/leschaines.jsp">Chaines</a>
            <a href="<%= request.getContextPath() %>/lestableaux.jsp">Tableaux</a>
        </nav>
    </header>

    <section class="panel exercise-page">
        <div class="panel-header">
            <div>
                <span class="eyebrow">Exercice 1</span>
                <h1>Boucles</h1>
            </div>
            <a class="button secondary" href="<%= request.getContextPath() %>/index.jsp">Retour</a>
        </div>

        <form class="inline-form" method="post" action="<%= request.getContextPath() %>/lesboucles.jsp">
            <label for="valeur">Nombre</label>
            <input id="valeur" name="valeur" type="number" min="1" max="30" value="<%= escapeHtml(rawValue == null ? "" : rawValue.trim()) %>" required>
            <button type="submit">Afficher</button>
        </form>

        <% if (error != null) { %>
            <div class="alert error"><%= error %></div>
        <% } %>

        <% if (value != null) { %>
            <div class="result-grid">
                <article class="result-card">
                    <h2>Carre</h2>
                    <pre><%= square(value) %></pre>
                </article>
                <article class="result-card">
                    <h2>Triangle gauche</h2>
                    <pre><%= leftTriangle(value) %></pre>
                </article>
                <article class="result-card">
                    <h2>Triangle inverse</h2>
                    <pre><%= invertedTriangle(value) %></pre>
                </article>
                <article class="result-card">
                    <h2>Triangle droit</h2>
                    <pre><%= rightTriangle(value) %></pre>
                </article>
                <article class="result-card">
                    <h2>Triangle isocele</h2>
                    <pre><%= isoscelesTriangle(value) %></pre>
                </article>
                <article class="result-card">
                    <h2>Demi losange</h2>
                    <pre><%= halfDiamond(value) %></pre>
                </article>
                <article class="result-card">
                    <h2>Multiplication</h2>
                    <pre><%= multiplicationTable(value) %></pre>
                </article>
            </div>
        <% } %>
    </section>
</main>
</body>
</html>
