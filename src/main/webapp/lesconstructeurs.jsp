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

    class Livre {
        private String titre;
        private String auteur;

        public Livre() {
            this("Titre inconnu", "Auteur inconnu");
        }

        public Livre(String titre, String auteur) {
            this.titre = titre;
            this.auteur = auteur;
        }

        public String decrire() {
            return titre + " - " + auteur;
        }
    }

    class Etudiant {
        private String nom;
        private int note;

        public Etudiant() {
            this("Anonyme", 10);
        }

        public Etudiant(String nom) {
            this(nom, 10);
        }

        public Etudiant(String nom, int note) {
            this.nom = nom;
            this.note = note;
        }

        public Etudiant(Etudiant autre) {
            this(autre.nom, autre.note);
        }

        public String decrire() {
            return nom + " : " + note + "/20";
        }
    }

    class Produit {
        private double prix;

        public Produit(double prix) {
            this.prix = Math.max(0, prix);
        }

        public double getPrix() {
            return prix;
        }
    }
%>
<%
    String titre = request.getParameter("titre");
    String auteur = request.getParameter("auteur");
    boolean submitted = titre != null || auteur != null;
    String error = null;

    if (submitted && (titre == null || titre.trim().isEmpty() || auteur == null || auteur.trim().isEmpty())) {
        error = "Le titre et l'auteur sont obligatoires.";
    }

    Livre livreVide = new Livre();
    Livre livrePlein = error == null && submitted
            ? new Livre(titre.trim(), auteur.trim())
            : new Livre("Le Petit Prince", "Antoine de Saint-Exupery");

    Etudiant etudiant1 = new Etudiant();
    Etudiant etudiant2 = new Etudiant("Marie");
    Etudiant etudiant3 = new Etudiant("Nassim", 16);
    Etudiant copie = new Etudiant(etudiant3);
    Produit produit = new Produit(-50);
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Constructeurs - Atelier Java 2</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/styles.css?v=4">
</head>
<body>
<a class="skip-link" href="#contenu">Aller au contenu</a>
<main id="contenu" class="app-shell">
    <header class="topbar">
        <div class="brand">
            <span class="brand-mark">POO</span>
            <span class="brand-copy">
                <strong>Atelier Java 2</strong>
                <span>Constructeurs</span>
            </span>
        </div>
        <nav class="nav" aria-label="Navigation principale">
            <a href="<%= request.getContextPath() %>/index.jsp">Accueil</a>
            <a href="<%= request.getContextPath() %>/lesobjets.jsp">Objets</a>
            <a href="<%= request.getContextPath() %>/lepolymorphisme.jsp">Polymorphisme</a>
        </nav>
    </header>

    <section class="panel exercise-page">
        <div class="panel-header">
            <div>
                <span class="eyebrow">POO 2</span>
                <h1>Constructeurs</h1>
            </div>
            <a class="button secondary" href="<%= request.getContextPath() %>/index.jsp">Retour</a>
        </div>

        <form class="inline-form multi-inline-form" method="post" action="<%= request.getContextPath() %>/lesconstructeurs.jsp">
            <label for="titre">Livre</label>
            <input id="titre" name="titre" type="text" placeholder="Titre" value="<%= escapeHtml(titre) %>" required>
            <input id="auteur" name="auteur" type="text" placeholder="Auteur" value="<%= escapeHtml(auteur) %>" required>
            <button type="submit">Creer</button>
        </form>

        <% if (error != null) { %>
            <div class="alert error"><%= error %></div>
        <% } %>

        <div class="result-grid">
            <article class="result-card">
                <h2>Constructeur par defaut</h2>
                <p><%= escapeHtml(livreVide.decrire()) %></p>
            </article>
            <article class="result-card">
                <h2>Constructeur avec parametres</h2>
                <p><%= escapeHtml(livrePlein.decrire()) %></p>
            </article>
            <article class="result-card">
                <h2>Surcharge Etudiant</h2>
                <pre><%= escapeHtml(etudiant1.decrire() + "\n" + etudiant2.decrire() + "\n" + etudiant3.decrire()) %></pre>
            </article>
            <article class="result-card">
                <h2>Constructeur de copie</h2>
                <p><%= escapeHtml(copie.decrire()) %></p>
            </article>
            <article class="result-card">
                <h2>Validation Produit</h2>
                <p>Prix apres validation : <%= produit.getPrix() %> EUR</p>
            </article>
        </div>
    </section>
</main>
</body>
</html>
