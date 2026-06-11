<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
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

    private int sum(List<Integer> numbers) {
        int total = 0;
        for (Integer number : numbers) {
            total += number;
        }
        return total;
    }

    private int maximum(List<Integer> numbers) {
        int max = numbers.get(0);
        for (Integer number : numbers) {
            if (number > max) {
                max = number;
            }
        }
        return max;
    }

    private int minimum(List<Integer> numbers) {
        int min = numbers.get(0);
        for (Integer number : numbers) {
            if (number < min) {
                min = number;
            }
        }
        return min;
    }

    private int closestToZero(List<Integer> numbers, boolean preferPositiveTie) {
        int closest = numbers.get(0);
        for (Integer number : numbers) {
            int currentAbs = Math.abs(number);
            int closestAbs = Math.abs(closest);
            if (currentAbs < closestAbs || (preferPositiveTie && currentAbs == closestAbs && number > closest)) {
                closest = number;
            }
        }
        return closest;
    }
%>
<%
    String rawNumbers = request.getParameter("chaine");
    String error = null;
    List<Integer> numbers = new ArrayList<>();

    if (rawNumbers != null && !rawNumbers.trim().isEmpty()) {
        String[] parts = rawNumbers.trim().split("\\s+");
        try {
            for (String part : parts) {
                numbers.add(Integer.parseInt(part));
            }
            if (numbers.size() < 3) {
                error = "Saisissez au moins 3 nombres.";
            }
        } catch (NumberFormatException exception) {
            error = "Utilisez seulement des nombres separes par des espaces.";
            numbers.clear();
        }
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableaux - Atelier Java</title>
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
                <span>Tableaux</span>
            </span>
        </div>
        <nav class="nav" aria-label="Navigation principale">
            <a href="<%= request.getContextPath() %>/index.jsp">Accueil</a>
            <a href="<%= request.getContextPath() %>/lesboucles.jsp">Boucles</a>
            <a href="<%= request.getContextPath() %>/lesconditions.jsp">Conditions</a>
            <a href="<%= request.getContextPath() %>/leschaines.jsp">Chaines</a>
        </nav>
    </header>

    <section class="panel exercise-page">
        <div class="panel-header">
            <div>
                <span class="eyebrow">Exercice 4</span>
                <h1>Tableaux</h1>
            </div>
            <a class="button secondary" href="<%= request.getContextPath() %>/index.jsp">Retour</a>
        </div>

        <form class="inline-form wide-form" method="post" action="<%= request.getContextPath() %>/lestableaux.jsp">
            <label for="chaine">Nombres</label>
            <input id="chaine" name="chaine" type="text" placeholder="6 78 15 -4" value="<%= escapeHtml(rawNumbers) %>" required>
            <button type="submit">Calculer</button>
        </form>

        <% if (error != null) { %>
            <div class="alert error"><%= error %></div>
        <% } %>

        <% if (error == null && numbers.size() >= 3) { %>
            <div class="result-grid">
                <article class="result-card">
                    <h2>Nombre de valeurs</h2>
                    <p><%= numbers.size() %></p>
                </article>
                <article class="result-card">
                    <h2>Carre premiere valeur</h2>
                    <p><%= numbers.get(0) * numbers.get(0) %></p>
                </article>
                <article class="result-card">
                    <h2>Somme deux premieres</h2>
                    <p><%= numbers.get(0) + numbers.get(1) %></p>
                </article>
                <article class="result-card">
                    <h2>Somme totale</h2>
                    <p><%= sum(numbers) %></p>
                </article>
                <article class="result-card">
                    <h2>Maximum</h2>
                    <p><%= maximum(numbers) %></p>
                </article>
                <article class="result-card">
                    <h2>Minimum</h2>
                    <p><%= minimum(numbers) %></p>
                </article>
                <article class="result-card">
                    <h2>Plus proche de 0</h2>
                    <p><%= closestToZero(numbers, false) %></p>
                </article>
                <article class="result-card">
                    <h2>Plus proche de 0, positif si egalite</h2>
                    <p><%= closestToZero(numbers, true) %></p>
                </article>
            </div>
        <% } %>
    </section>
</main>
</body>
</html>
