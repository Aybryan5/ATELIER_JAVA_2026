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

    class Personne {
        private String nom;
        private int age;

        public String getNom() {
            return nom;
        }

        public void setNom(String nom) {
            this.nom = nom;
        }

        public int getAge() {
            return age;
        }

        public void setAge(int age) {
            this.age = Math.max(0, age);
        }

        public String seDecrire() {
            return "Je m'appelle " + nom + " et j'ai " + age + " ans.";
        }
    }

    class Voiture {
        private String marque;
        private String modele;
        private int annee;

        public Voiture(String marque, String modele, int annee) {
            this.marque = marque;
            this.modele = modele;
            this.annee = annee;
        }

        public String decrire() {
            return marque + " " + modele + " (" + annee + ")";
        }
    }

    class Rectangle {
        private double longueur;
        private double largeur;

        public Rectangle(double longueur, double largeur) {
            this.longueur = longueur;
            this.largeur = largeur;
        }

        public double calculerSurface() {
            return longueur * largeur;
        }
    }

    class CompteBancaire {
        private double solde;

        public void deposer(double montant) {
            if (montant > 0) {
                solde += montant;
            }
        }

        public void retirer(double montant) {
            if (montant > 0 && montant <= solde) {
                solde -= montant;
            }
        }

        public double getSolde() {
            return solde;
        }
    }
%>
<%
    String nom = request.getParameter("nom");
    String ageValue = request.getParameter("age");
    String error = null;
    Personne personne = null;

    if (nom != null || ageValue != null) {
        try {
            int age = Integer.parseInt(ageValue == null ? "" : ageValue.trim());
            if (nom == null || nom.trim().isEmpty()) {
                error = "Le nom est obligatoire.";
            } else {
                personne = new Personne();
                personne.setNom(nom.trim());
                personne.setAge(age);
            }
        } catch (NumberFormatException exception) {
            error = "L'age doit etre un nombre entier.";
        }
    }

    Voiture voiture = new Voiture("Peugeot", "208", 2024);
    Rectangle rectangle = new Rectangle(5, 3);
    CompteBancaire compte = new CompteBancaire();
    compte.deposer(100);
    compte.retirer(30);
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Objets - Atelier Java 2</title>
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
                <span>Objets</span>
            </span>
        </div>
        <nav class="nav" aria-label="Navigation principale">
            <a href="<%= request.getContextPath() %>/index.jsp">Accueil</a>
            <a href="<%= request.getContextPath() %>/lesconstructeurs.jsp">Constructeurs</a>
            <a href="<%= request.getContextPath() %>/lepolymorphisme.jsp">Polymorphisme</a>
        </nav>
    </header>

    <section class="panel exercise-page">
        <div class="panel-header">
            <div>
                <span class="eyebrow">POO 1</span>
                <h1>Objets</h1>
            </div>
            <a class="button secondary" href="<%= request.getContextPath() %>/index.jsp">Retour</a>
        </div>

        <form class="inline-form multi-inline-form" method="post" action="<%= request.getContextPath() %>/lesobjets.jsp">
            <label for="nom">Personne</label>
            <input id="nom" name="nom" type="text" placeholder="Nom" value="<%= escapeHtml(nom) %>" required>
            <input id="age" name="age" type="number" min="0" placeholder="Age" value="<%= escapeHtml(ageValue) %>" required>
            <button type="submit">Creer</button>
        </form>

        <% if (error != null) { %>
            <div class="alert error"><%= error %></div>
        <% } %>

        <div class="result-grid">
            <% if (personne != null) { %>
                <article class="result-card">
                    <h2>Personne encapsulee</h2>
                    <p><%= escapeHtml(personne.seDecrire()) %></p>
                </article>
            <% } %>
            <article class="result-card">
                <h2>Voiture</h2>
                <p><%= escapeHtml(voiture.decrire()) %></p>
            </article>
            <article class="result-card">
                <h2>Rectangle</h2>
                <p>Surface : <%= rectangle.calculerSurface() %></p>
            </article>
            <article class="result-card">
                <h2>Compte bancaire</h2>
                <p>Solde final : <%= compte.getSolde() %> EUR</p>
            </article>
        </div>
    </section>
</main>
</body>
</html>
