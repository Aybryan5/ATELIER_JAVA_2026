<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.Normalizer" %>
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

    private boolean isVowel(char character) {
        String normalized = Normalizer.normalize(String.valueOf(character), Normalizer.Form.NFD);
        char plain = Character.toLowerCase(normalized.charAt(0));
        return "aeiouy".indexOf(plain) >= 0;
    }

    private String verticalText(String text) {
        StringBuilder builder = new StringBuilder();
        for (int index = 0; index < text.length(); index++) {
            builder.append(text.charAt(index)).append('\n');
        }
        return builder.toString();
    }

    private String oneCharacterOutOfTwo(String text) {
        StringBuilder builder = new StringBuilder();
        for (int index = 0; index < text.length(); index += 2) {
            builder.append(text.charAt(index));
        }
        return builder.toString();
    }

    private int countLetterE(String text) {
        int count = 0;
        for (int index = 0; index < text.length(); index++) {
            if (Character.toLowerCase(text.charAt(index)) == 'e') {
                count++;
            }
        }
        return count;
    }
%>
<%
    String text = request.getParameter("chaine");
    String error = null;
    int vowels = 0;
    int consonants = 0;

    if (text != null) {
        text = text.trim();
        if (text.length() < 6) {
            error = "Saisissez au moins 6 caracteres.";
        } else {
            for (int index = 0; index < text.length(); index++) {
                char character = text.charAt(index);
                if (Character.isLetter(character)) {
                    if (isVowel(character)) {
                        vowels++;
                    } else {
                        consonants++;
                    }
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chaines - Atelier Java</title>
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
                <span>Chaines</span>
            </span>
        </div>
        <nav class="nav" aria-label="Navigation principale">
            <a href="<%= request.getContextPath() %>/index.jsp">Accueil</a>
            <a href="<%= request.getContextPath() %>/lesboucles.jsp">Boucles</a>
            <a href="<%= request.getContextPath() %>/lesconditions.jsp">Conditions</a>
            <a href="<%= request.getContextPath() %>/lestableaux.jsp">Tableaux</a>
        </nav>
    </header>

    <section class="panel exercise-page">
        <div class="panel-header">
            <div>
                <span class="eyebrow">Exercice 3</span>
                <h1>Chaines</h1>
            </div>
            <a class="button secondary" href="<%= request.getContextPath() %>/index.jsp">Retour</a>
        </div>

        <form class="inline-form wide-form" method="post" action="<%= request.getContextPath() %>/leschaines.jsp">
            <label for="chaine">Texte</label>
            <input id="chaine" name="chaine" type="text" minlength="6" value="<%= escapeHtml(text) %>" required>
            <button type="submit">Analyser</button>
        </form>

        <% if (error != null) { %>
            <div class="alert error"><%= error %></div>
        <% } %>

        <% if (text != null && error == null) { %>
            <div class="result-grid">
                <article class="result-card">
                    <h2>Longueur</h2>
                    <p><%= text.length() %> caracteres</p>
                </article>
                <article class="result-card">
                    <h2>Lettre e</h2>
                    <p><%= countLetterE(text) %> occurrence(s)</p>
                </article>
                <article class="result-card">
                    <h2>Affichage vertical</h2>
                    <pre><%= escapeHtml(verticalText(text)) %></pre>
                </article>
                <article class="result-card">
                    <h2>Espaces en retours ligne</h2>
                    <pre><%= escapeHtml(text.replace(" ", "\n")) %></pre>
                </article>
                <article class="result-card">
                    <h2>Une lettre sur deux</h2>
                    <p><%= escapeHtml(oneCharacterOutOfTwo(text)) %></p>
                </article>
                <article class="result-card">
                    <h2>Verlan</h2>
                    <p><%= escapeHtml(new StringBuilder(text).reverse().toString()) %></p>
                </article>
                <article class="result-card">
                    <h2>Voyelles / consonnes</h2>
                    <p><%= vowels %> voyelle(s), <%= consonants %> consonne(s)</p>
                </article>
            </div>
        <% } %>
    </section>
</main>
</body>
</html>
