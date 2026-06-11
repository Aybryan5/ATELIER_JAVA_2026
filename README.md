# Mini Gestionnaire de Taches Collaboratif

Application web Java JSP/Servlets permettant de gerer des taches stockees dans la session utilisateur, avec les exercices JSP demandes par l'atelier Java 2026.

## Fonctionnalites

- Ajout d'une tache avec titre, description et date d'echeance.
- Affichage des taches depuis une `ArrayList<Task>` stockee en session.
- Suppression d'une tache.
- Marquage d'une tache comme terminee.
- Exercices JSP : boucles, conditions, chaines de caracteres, tableaux.

## Lancer le projet

```bash
mvn clean package
```

Le WAR genere est :

```text
target/bryan.war
```

Pour Tomcat local :

```text
http://localhost:8080/bryan/
```

## GitHub Actions

Le workflow `.github/workflows/CICD.yml` construit `bryan.war` avec Maven puis le copie dans `/opt/tomcat/webapps` avec les secrets demandes par le README OpenRSI :

- `HOST_DNS`
- `USERNAME`
- `DEPLOY_PORT`
- `EC2_SSH_KEY`
