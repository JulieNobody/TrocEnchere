# trocenchere

*********** Contexte ***********

    - Projet réalisé dans le cadre de mon diplome Développeur.se Web et Web Mobile (à l’ENI Ecole informatique)
    - 2 semaines
    - équipe de 4 personnes
    - mon rôle : développeuse et Scrum master


*********** Sujet ***********

réaliser un site d'enchères
Les utilisateurs (non inscrits) peuvent
    - recherche un article en vente (accueil)
        - par défaut, trié par date de parution
        - recherche par catégorie
        - recherche par mot clé
        - recherche par catégorie et mot clé
    - s'inscire
    
Les utilisateurs inscrits peuvent
    - se connecter
    - se déconecter
    - modifier son profil
    - recherche un article en vente (accueil)
        - par défaut, trié par date de parution
        - recherche par catégorie
        - recherche par mot clé
        - recherche par catégorie et mot clé
    - voir le détail d'un article en vente
    - enchérir sur un article en vente
    - afficher l'adresse de retrait si il a remporté l'enchère
    - mettre un article à vendre


*********** Outils ***********

    - JavaEE
    - Tomcat
    - SQL Server / SQL Server Management Studio
    - Git / Gogs


*********** Mon travail ***********

   - DAL
        - DAOFactory
        - ArticlesDAO
        - ArticlesDAOJDBCImpl
        
   - BO
        - Articles
        - Catégories
        - Encheres
        - Retraits
        - Utilisateurs
        
   - BLL
        - gestionArticles
        
   - Servlets
        - Accueil
        - AfficheArticleServlet (doGet)
        
   - JSP
        - Accueil

        
        


    
