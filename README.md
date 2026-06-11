# Mini Gestionnaire de Taches Collaboratif

Application web Java JSP/Servlets permettant de gerer des taches stockees dans la session utilisateur.

## Fonctionnalites

- Page d'accueil avec navigation.
- Ajout d'une tache avec titre, description et date d'echeance.
- Affichage de la liste des taches depuis une `ArrayList<Task>` stockee en session.
- Suppression d'une tache.
- Marquage d'une tache comme terminee.

## Structure principale

- `src/main/java/fr/bryan/taskmanager/model/Task.java` : classe Java representant une tache.
- `src/main/java/fr/bryan/taskmanager/servlet/` : servlets d'ajout, suppression et validation.
- `src/main/webapp/*.jsp` : pages JSP.
- `src/main/webapp/WEB-INF/web.xml` : configuration Tomcat.

## Lancer le projet

Construire le fichier WAR :

```bash
mvn clean package
```

Le fichier deployable est genere ici :

```text
target/bryan.war
```

Copier ce fichier dans le dossier `webapps` d'Apache Tomcat, puis ouvrir :

```text
http://localhost:8080/bryan/
```

## Deploiement GitHub Actions

Le workflow `.github/workflows/CICD.yml` genere `bryan.war` et le copie sur le Tomcat AWS avec les secrets demandes dans le README du projet OpenRSI.
