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

    interface Affichable {
        String afficher();
    }

    abstract class Animal {
        protected String nom;

        public Animal(String nom) {
            this.nom = nom;
        }

        public abstract String crier();

        @Override
        public String toString() {
            return "Animal nomme " + nom;
        }
    }

    class Chien extends Animal implements Affichable {
        public Chien(String nom) {
            super(nom);
        }

        @Override
        public String crier() {
            return "Wouf wouf !";
        }

        @Override
        public String toString() {
            return "Chien nomme " + nom;
        }

        @Override
        public String afficher() {
            return toString() + " dit " + crier();
        }
    }

    class Chat extends Animal implements Affichable {
        public Chat(String nom) {
            super(nom);
        }

        @Override
        public String crier() {
            return "Miaou !";
        }

        @Override
        public String toString() {
            return "Chat nomme " + nom;
        }

        @Override
        public String afficher() {
            return toString() + " dit " + crier();
        }
    }

    class Oiseau extends Animal {
        public Oiseau(String nom) {
            super(nom);
        }

        @Override
        public String crier() {
            return "Cui cui !";
        }

        @Override
        public String toString() {
            return "Oiseau nomme " + nom;
        }
    }

    abstract class Forme {
        public abstract double aire();
    }

    class Cercle extends Forme {
        private double rayon;

        public Cercle(double rayon) {
            this.rayon = rayon;
        }

        @Override
        public double aire() {
            return Math.PI * rayon * rayon;
        }
    }

    class Carre extends Forme {
        private double cote;

        public Carre(double cote) {
            this.cote = cote;
        }

        @Override
        public double aire() {
            return cote * cote;
        }
    }

    private String animalType(Animal animal) {
        if (animal instanceof Chien) {
            return "C'est un chien";
        }
        if (animal instanceof Chat) {
            return "C'est un chat";
        }
        return "Autre animal";
    }
%>
<%
    String chien = request.getParameter("chien");
    String chat = request.getParameter("chat");
    String oiseau = request.getParameter("oiseau");

    if (chien == null || chien.trim().isEmpty()) {
        chien = "Rex";
    }
    if (chat == null || chat.trim().isEmpty()) {
        chat = "Felix";
    }
    if (oiseau == null || oiseau.trim().isEmpty()) {
        oiseau = "Rio";
    }

    Animal[] animaux = {
            new Chien(chien.trim()),
            new Chat(chat.trim()),
            new Oiseau(oiseau.trim())
    };

    Affichable[] affichables = {
            new Chien(chien.trim()),
            new Chat(chat.trim())
    };

    Forme[] formes = {
            new Cercle(3),
            new Carre(4)
    };
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Polymorphisme - Atelier Java 2</title>
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
                <span>Polymorphisme</span>
            </span>
        </div>
        <nav class="nav" aria-label="Navigation principale">
            <a href="<%= request.getContextPath() %>/index.jsp">Accueil</a>
            <a href="<%= request.getContextPath() %>/lesobjets.jsp">Objets</a>
            <a href="<%= request.getContextPath() %>/lesconstructeurs.jsp">Constructeurs</a>
        </nav>
    </header>

    <section class="panel exercise-page">
        <div class="panel-header">
            <div>
                <span class="eyebrow">POO 3</span>
                <h1>Polymorphisme</h1>
            </div>
            <a class="button secondary" href="<%= request.getContextPath() %>/index.jsp">Retour</a>
        </div>

        <form class="form-grid compact-form" method="post" action="<%= request.getContextPath() %>/lepolymorphisme.jsp">
            <div class="mini-fields three-fields">
                <div class="field">
                    <label for="chien">Chien</label>
                    <input id="chien" name="chien" type="text" value="<%= escapeHtml(chien) %>" required>
                </div>
                <div class="field">
                    <label for="chat">Chat</label>
                    <input id="chat" name="chat" type="text" value="<%= escapeHtml(chat) %>" required>
                </div>
                <div class="field">
                    <label for="oiseau">Oiseau</label>
                    <input id="oiseau" name="oiseau" type="text" value="<%= escapeHtml(oiseau) %>" required>
                </div>
            </div>
            <button type="submit">Afficher</button>
        </form>

        <div class="result-grid">
            <article class="result-card">
                <h2>Animal[]</h2>
                <pre><% for (Animal animal : animaux) { %><%= escapeHtml(animal.toString() + " dit " + animal.crier() + " - " + animalType(animal)) %>
<% } %></pre>
            </article>
            <article class="result-card">
                <h2>Interface Affichable</h2>
                <pre><% for (Affichable affichable : affichables) { %><%= escapeHtml(affichable.afficher()) %>
<% } %></pre>
            </article>
            <article class="result-card">
                <h2>Classe abstraite Forme</h2>
                <pre>Cercle : <%= String.format("%.2f", formes[0].aire()) %>
Carre : <%= String.format("%.2f", formes[1].aire()) %></pre>
            </article>
        </div>
    </section>
</main>
</body>
</html>
