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

    private String valueOrEmpty(String value) {
        return value == null ? "" : value.trim();
    }
%>
<%
    String rawA = request.getParameter("a");
    String rawB = request.getParameter("b");
    String rawC = request.getParameter("c");
    String rawNumber = request.getParameter("nombre");
    String error = null;

    Integer a = null;
    Integer b = null;
    Integer c = null;
    Integer number = null;

    boolean submitted = rawA != null || rawB != null || rawC != null || rawNumber != null;
    if (submitted) {
        try {
            a = Integer.parseInt(valueOrEmpty(rawA));
            b = Integer.parseInt(valueOrEmpty(rawB));
            c = Integer.parseInt(valueOrEmpty(rawC));
            number = Integer.parseInt(valueOrEmpty(rawNumber));
        } catch (NumberFormatException exception) {
            error = "Tous les champs doivent contenir des nombres entiers.";
        }
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Conditions - Atelier Java</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/styles.css?v=3">
</head>
<body>
<a class="skip-link" href="#contenu">Aller au contenu</a>
<main id="contenu" class="app-shell">
    <header class="topbar">
        <div class="brand">
            <span class="brand-mark">JSP</span>
            <span class="brand-copy">
                <strong>Atelier Java</strong>
                <span>Conditions</span>
            </span>
        </div>
        <nav class="nav" aria-label="Navigation principale">
            <a href="<%= request.getContextPath() %>/index.jsp">Accueil</a>
            <a href="<%= request.getContextPath() %>/lesboucles.jsp">Boucles</a>
            <a href="<%= request.getContextPath() %>/leschaines.jsp">Chaines</a>
            <a href="<%= request.getContextPath() %>/lestableaux.jsp">Tableaux</a>
        </nav>
    </header>

    <section class="panel exercise-page">
        <div class="panel-header">
            <div>
                <span class="eyebrow">Exercice 2</span>
                <h1>Conditions</h1>
            </div>
            <a class="button secondary" href="<%= request.getContextPath() %>/index.jsp">Retour</a>
        </div>

        <form class="form-grid compact-form" method="post" action="<%= request.getContextPath() %>/lesconditions.jsp">
            <div class="mini-fields">
                <div class="field">
                    <label for="a">A</label>
                    <input id="a" name="a" type="number" value="<%= escapeHtml(valueOrEmpty(rawA)) %>" required>
                </div>
                <div class="field">
                    <label for="b">B</label>
                    <input id="b" name="b" type="number" value="<%= escapeHtml(valueOrEmpty(rawB)) %>" required>
                </div>
                <div class="field">
                    <label for="c">C</label>
                    <input id="c" name="c" type="number" value="<%= escapeHtml(valueOrEmpty(rawC)) %>" required>
                </div>
                <div class="field">
                    <label for="nombre">Pair / impair</label>
                    <input id="nombre" name="nombre" type="number" value="<%= escapeHtml(valueOrEmpty(rawNumber)) %>" required>
                </div>
            </div>
            <button type="submit">Verifier</button>
        </form>

        <% if (error != null) { %>
            <div class="alert error"><%= error %></div>
        <% } %>

        <% if (error == null && a != null && b != null && c != null && number != null) { %>
            <div class="result-grid two-columns">
                <article class="result-card">
                    <h2>C entre A et B</h2>
                    <p>
                        <%= c >= Math.min(a, b) && c <= Math.max(a, b)
                                ? "Oui, C est compris entre A et B."
                                : "Non, C n'est pas compris entre A et B." %>
                    </p>
                </article>
                <article class="result-card">
                    <h2>Pair ou impair</h2>
                    <p><%= number %> est <%= number % 2 == 0 ? "pair" : "impair" %>.</p>
                </article>
            </div>
        <% } %>
    </section>
</main>
</body>
</html>
