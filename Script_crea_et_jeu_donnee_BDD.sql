-------------

-- Script de création de la base de données ENCHERES
--   type :      SQL Server 2012
--
DROP TABLE if exists ENCHERES;
DROP TABLE if exists RETRAITS;
DROP TABLE if exists ARTICLES_VENDUS;
DROP TABLE if exists CATEGORIES;
DROP TABLE if exists UTILISATEURS;

CREATE TABLE CATEGORIES (
    no_categorie   INTEGER IDENTITY(1,1) NOT NULL,
    libelle        VARCHAR(30) NOT NULL
)

ALTER TABLE CATEGORIES ADD constraint categories_pk PRIMARY KEY (no_categorie)

CREATE TABLE ENCHERES (
    no_utilisateur   INTEGER NOT NULL,
    no_article       INTEGER NOT NULL,
    date_enchere     DATETIME NOT NULL,
	montant_enchere  INTEGER NOT NULL

)

ALTER TABLE ENCHERES ADD constraint encheres_pk PRIMARY KEY (no_utilisateur, no_article)

CREATE TABLE RETRAITS (
	no_article       INTEGER NOT NULL,
    rue              VARCHAR(30) NOT NULL,
    code_postal      VARCHAR(15) NOT NULL,
    ville            VARCHAR(30) NOT NULL
)

ALTER TABLE RETRAITS ADD constraint retraits_pk PRIMARY KEY  (no_article)

CREATE TABLE UTILISATEURS (
    no_utilisateur   INTEGER IDENTITY(1,1) NOT NULL,
    pseudo           VARCHAR(30) NOT NULL,
    nom              VARCHAR(30) NOT NULL,
    prenom           VARCHAR(30) NOT NULL,
    email            VARCHAR(20) NOT NULL,
    telephone        VARCHAR(15) NULL,
    rue              VARCHAR(30) NOT NULL,
    code_postal      VARCHAR(10) NOT NULL,
    ville            VARCHAR(30) NOT NULL,
    mot_de_passe     VARCHAR(30) NOT NULL,
    credit           INTEGER NOT NULL,
    administrateur   BIT NOT NULL
)

ALTER TABLE UTILISATEURS ADD constraint utilisateurs_pk PRIMARY KEY (no_utilisateur)
ALTER TABLE UTILISATEURS ADD constraint utilisateurs_pseudo_uq UNIQUE (pseudo)
ALTER TABLE UTILISATEURS ADD constraint utilisateurs_email_uq UNIQUE (email) 


CREATE TABLE ARTICLES_VENDUS (
    no_article                    INTEGER IDENTITY(1,1) NOT NULL,
    nom_article                   VARCHAR(30) NOT NULL,
    description                   VARCHAR(300) NOT NULL,
	date_debut_enchere            DATETIME NOT NULL,
    date_fin_enchere              DATETIME NOT NULL,
    prix_initial                  INTEGER NULL,
    prix_vente                    INTEGER NULL,
    no_utilisateur                INTEGER NOT NULL,
    no_categorie                  INTEGER NOT NULL,
	etat_vente					  CHAR(2) NOT NULL DEFAULT 'CR',
	image 						  VARCHAR(150) NULL
)

ALTER TABLE ARTICLES_VENDUS ADD CONSTRAINT articles_vendus_pk PRIMARY KEY (no_article)
--CREER("CR"),EN_COURS("EC"),VENDU("VD"),RETIRER("RT");
ALTER TABLE ARTICLES_VENDUS ADD CONSTRAINT articles_vendus_etat_vente_ck CHECK (etat_vente IN ('CR','EC','VD','RT'))

--MISE EN PLACE DE L'INTEGRITE REFERENTIELLE
ALTER TABLE ARTICLES_VENDUS
    ADD CONSTRAINT articles_utilisateurs_fk FOREIGN KEY ( no_utilisateur ) REFERENCES UTILISATEURS ( no_utilisateur )
	ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
    
ALTER TABLE ARTICLES_VENDUS
    ADD CONSTRAINT articles_vendus_categories_fk FOREIGN KEY ( no_categorie )
        REFERENCES categories ( no_categorie )
	ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
    
ALTER TABLE ENCHERES
    ADD CONSTRAINT encheres_articles_vendus_fk FOREIGN KEY ( no_article )
        REFERENCES ARTICLES_VENDUS ( no_article )
	ON DELETE NO ACTION
    ON UPDATE NO ACTION 
    
ALTER TABLE ENCHERES
    ADD CONSTRAINT ventes_utilisateurs_fk FOREIGN KEY ( no_utilisateur )
        REFERENCES utilisateurs ( no_utilisateur )
	ON DELETE NO ACTION 
    ON UPDATE NO ACTION 

ALTER TABLE RETRAITS
    ADD CONSTRAINT retraits_articles_vendus_fk FOREIGN KEY ( no_article )
        REFERENCES ARTICLES_VENDUS ( no_article )
	ON DELETE CASCADE --A LA SUPPRESSION DE L'ARTICLE, SUPPRESSION DU RETRAIT LIES
    ON UPDATE NO ACTION 

--------------------------------------
/*
 SELECT  a.no_article,nom_article,description,date_debut_encheres,date_fin_encheres,prix_initial,prix_vente,
			a.no_utilisateur as no_user,a.no_categorie,etat_vente,image,r.rue as arue,r.code_postal as acp,r.ville as aville, c.libelle, u.*,
			e.no_utilisateur as ec_no_utilisateur, e.date_enchere, e.montant_enchere 
			FROM  (((ARTICLES_VENDUS a LEFT JOIN RETRAITS r ON a.no_article = r.no_article) 
			LEFT JOIN CATEGORIES c ON c.no_categorie = a.no_categorie)
			LEFT JOIN UTILISATEURS u ON u.no_utilisateur = a.no_utilisateur)
			LEFT JOIN ENCHERES e ON (a.no_article = e.no_article AND e.no_utilisateur = (SELECT TOP(1) ec.no_utilisateur FROM ENCHERES ec WHERE ec.no_article = a.no_article ORDER BY date_enchere DESC))
			WHERE (GETDATE() BETWEEN date_debut_encheres AND date_fin_encheres)
*/		
			
-------------------------------------
 
SET IDENTITY_INSERT [dbo].[CATEGORIES] ON 
INSERT [dbo].[CATEGORIES] ([no_categorie], [libelle]) VALUES (1, N'Informatique')
INSERT [dbo].[CATEGORIES] ([no_categorie], [libelle]) VALUES (2, N'Ameublement')
INSERT [dbo].[CATEGORIES] ([no_categorie], [libelle]) VALUES (3, N'Vêtement')
INSERT [dbo].[CATEGORIES] ([no_categorie], [libelle]) VALUES (4, N'Sport & Loisir')
SET IDENTITY_INSERT [dbo].[CATEGORIES] OFF

SET IDENTITY_INSERT [dbo].[UTILISATEURS] ON 
INSERT [dbo].[UTILISATEURS] ([no_utilisateur], [pseudo], [nom], [prenom], [email], [telephone], [rue], [code_postal], [ville], [mot_de_passe], [credit], [administrateur]) VALUES (1, N'admin', N'Bluth', N'Georges', N'gbluth@campus.fr', N'0241468598', N'16 av du monde', N'49000', N'Angers', N'Pa$$w0rd', 0, 1)
INSERT [dbo].[UTILISATEURS] ([no_utilisateur], [pseudo], [nom], [prenom], [email], [telephone], [rue], [code_postal], [ville], [mot_de_passe], [credit], [administrateur]) VALUES (2, N'felix', N'Bluth', N'Félix', N'fbluth@campus.fr', N'0241461708', N'11 rue du chêne vert', N'85000', N'La Roche/Yon', N'Pa$$w0rd', 100, 0)
INSERT [dbo].[UTILISATEURS] ([no_utilisateur], [pseudo], [nom], [prenom], [email], [telephone], [rue], [code_postal], [ville], [mot_de_passe], [credit], [administrateur]) VALUES (3, N'tom', N'Bluth', N'Tom', N'tbluth@campus.fr', N'0695020202', N'5 rue de la mer', N'44000', N'Nantes', N'Pa$$w0rd', 65, 0)
INSERT [dbo].[UTILISATEURS] ([no_utilisateur], [pseudo], [nom], [prenom], [email], [telephone], [rue], [code_postal], [ville], [mot_de_passe], [credit], [administrateur]) VALUES (4, N'samuel', N'Bluth', N'Samuel', N'sbluth@campus.fr', N'0788030303', N'9 chemin des gites', N'44000', N'Nantes', N'Pa$$w0rd', 260, 0)
INSERT [dbo].[UTILISATEURS] ([no_utilisateur], [pseudo], [nom], [prenom], [email], [telephone], [rue], [code_postal], [ville], [mot_de_passe], [credit], [administrateur]) VALUES (5, N'luisa', N'Bluth', N'Luisa', N'lbluth@campus.fr', N'', N'9 rue de l''océan', N'85000', N'Les Sables d''Olonnes', N'Pa$$w0rd', 0, 0)
INSERT [dbo].[UTILISATEURS] ([no_utilisateur], [pseudo], [nom], [prenom], [email], [telephone], [rue], [code_postal], [ville], [mot_de_passe], [credit], [administrateur]) VALUES (6, N'laure', N'Bluth', N'Laure', N'laurebluth@campus.fr', N'0202020202', N'8 rue de Nantes', N'44000', N'Nantes', N'Pa$$w0rd', 0, 0)
SET IDENTITY_INSERT [dbo].[UTILISATEURS] OFF

SET IDENTITY_INSERT [dbo].[ARTICLES_VENDUS] ON
INSERT INTO [dbo].[ARTICLES_VENDUS]
           ([no_article]
		   ,[nom_article]
           ,[description]
           ,[date_debut_enchere]
           ,[date_fin_enchere]
           ,[prix_initial]
           ,[prix_vente]
           ,[no_utilisateur]
           ,[no_categorie]
           ,[etat_vente]
           ,[image])
     VALUES
           (1
		   ,'Horloge XIXème'
           ,'Authentique horloge de type cartel du XIXème siècle.'
           ,getdate()
           ,getdate() + 1
           ,180
           ,180
           ,1
           ,2
           ,'EC'
           ,null);
INSERT INTO [dbo].[ARTICLES_VENDUS]
           ([no_article]
		   ,[nom_article]
           ,[description]
           ,[date_debut_enchere]
           ,[date_fin_enchere]
           ,[prix_initial]
           ,[prix_vente]
           ,[no_utilisateur]
           ,[no_categorie]
           ,[etat_vente]
           ,[image])
     VALUES
           (2
		   ,'Coffret DVD Buffy'
           ,'L intégrale des saisons de Buffy.'
           ,getdate() + 1
           ,getdate() + 3
           ,50
           ,50
           ,2
           ,1
           ,'VD'
           ,null);
INSERT INTO [dbo].[ARTICLES_VENDUS]
           ([no_article]
		   ,[nom_article]
           ,[description]
           ,[date_debut_enchere]
           ,[date_fin_enchere]
           ,[prix_initial]
           ,[prix_vente]
           ,[no_utilisateur]
           ,[no_categorie]
           ,[etat_vente]
           ,[image])
     VALUES
           (3
		   ,'Pull cashmire Ralph Lauren'
           ,'Très doux, taille 44 homme, collection aut/hiv 2004.'
           ,getdate()
           ,getdate() + 2
           ,60
           ,60
           ,3
           ,3
           ,'RT'
           ,null);
 INSERT INTO [dbo].[ARTICLES_VENDUS]
           ([no_article]
		   ,[nom_article]
           ,[description]
           ,[date_debut_enchere]
           ,[date_fin_enchere]
           ,[prix_initial]
           ,[prix_vente]
           ,[no_utilisateur]
           ,[no_categorie]
           ,[etat_vente]
           ,[image])
     VALUES
           (4
		   ,'Place concert Manu Chao'
           ,'1 place debout pour le concert de Manu Chao le 10 juillet à la salle des fêtes de Limoges.'
           ,getdate()
           ,getdate() + 6
           ,20
           ,20
           ,4
           ,4
           ,'RC'
           ,null);
INSERT INTO [dbo].[ARTICLES_VENDUS]
           ([no_article]
		   ,[nom_article]
           ,[description]
           ,[date_debut_enchere]
           ,[date_fin_enchere]
           ,[prix_initial]
           ,[prix_vente]
           ,[no_utilisateur]
           ,[no_categorie]
           ,[etat_vente]
           ,[image])
     VALUES
           (5
		   ,'Youtube dOr'
           ,'Je vends mon Youtube dOr gagné à mon 1M d abonnés.'
           ,getdate()
           ,getdate() + 10
           ,100
           ,100
           ,5
           ,1
           ,'VD'
           ,null);
 INSERT INTO [dbo].[ARTICLES_VENDUS]
           ([no_article]
		   ,[nom_article]
           ,[description]
           ,[date_debut_enchere]
           ,[date_fin_enchere]
           ,[prix_initial]
           ,[prix_vente]
           ,[no_utilisateur]
           ,[no_categorie]
           ,[etat_vente]
           ,[image])
     VALUES
           (6
		   ,'Service argenterie Christophle'
           ,'Couverts en argent, 32 pièces, années 20-30.'
           ,getdate()
           ,getdate() + 8
           ,160
           ,160
           ,6
           ,2
           ,'RC'
           ,null);
INSERT INTO [dbo].[ARTICLES_VENDUS]
           ([no_article]
		   ,[nom_article]
           ,[description]
           ,[date_debut_enchere]
           ,[date_fin_enchere]
           ,[prix_initial]
           ,[prix_vente]
           ,[no_utilisateur]
           ,[no_categorie]
           ,[etat_vente]
           ,[image])
     VALUES
           (7
		   ,'Tableau Dali reproduction'
           ,'"La Persistance de la mémoire", reproduction de 1977, huile sur toile.'
           ,getdate()
           ,getdate() + 12
           ,80
           ,80
           ,1
           ,2
           ,'EC'
           ,null);
INSERT INTO [dbo].[ARTICLES_VENDUS]
           ([no_article]
		   ,[nom_article]
           ,[description]
           ,[date_debut_enchere]
           ,[date_fin_enchere]
           ,[prix_initial]
           ,[prix_vente]
           ,[no_utilisateur]
           ,[no_categorie]
           ,[etat_vente]
           ,[image])
     VALUES
           (8
		   ,'PS4'
           ,'PS4 500Go, avec 1 manette'
           ,getdate()
           ,getdate() + 5
           ,150
           ,150
           ,2
           ,1
           ,'RT'
           ,null);
INSERT INTO [dbo].[ARTICLES_VENDUS]
           ([no_article]
		   ,[nom_article]
           ,[description]
           ,[date_debut_enchere]
           ,[date_fin_enchere]
           ,[prix_initial]
           ,[prix_vente]
           ,[no_utilisateur]
           ,[no_categorie]
           ,[etat_vente]
           ,[image])
     VALUES
           (9
		   ,'Bottes cuir T.38'
           ,'Bottes en cuir de chevreau, pointure 38 femme, peu portées.'
           ,getdate()
           ,getdate() + 15
           ,40
           ,40
           ,3
           ,3
           ,'VD'
           ,null);
INSERT INTO [dbo].[ARTICLES_VENDUS]
           ([no_article]
		   ,[nom_article]
           ,[description]
           ,[date_debut_enchere]
           ,[date_fin_enchere]
           ,[prix_initial]
           ,[prix_vente]
           ,[no_utilisateur]
           ,[no_categorie]
           ,[etat_vente]
           ,[image])
     VALUES
           (10
		   ,'Raquette tennis adulte'
           ,'Cordage récent, utilisée 3 fois pour compétition.'
           ,getdate()
           ,getdate() + 9
           ,90
           ,90
           ,4
           ,4
           ,'RT'
           ,null);
SET IDENTITY_INSERT [dbo].[ARTICLES_VENDUS] OFF

SET IDENTITY_INSERT [dbo].[RETRAITS] ON
INSERT INTO [dbo].[RETRAITS]
			([no_article],
			[rue],
			[code_postal],
			[ville])
	VALUES
			(1,
			N'16 av du monde',
			N'49000',
			N'Angers')
INSERT INTO [dbo].[RETRAITS]
			([no_article],
			[rue],
			[code_postal],
			[ville])
	VALUES
			(2,
			N'11 rue du chêne vert',
			N'85000',
			N'La Roche/Yon')
INSERT INTO [dbo].[RETRAITS]
			([no_article],
			[rue],
			[code_postal],
			[ville])
	VALUES
			(3,
			N'5 rue de la mer',
			N'44000',
			N'Nantes')
INSERT INTO [dbo].[RETRAITS]
			([no_article],
			[rue],
			[code_postal],
			[ville])
	VALUES
			(4,
			N'9 chemin des gites',
			N'44000',
			N'Nantes')
INSERT INTO [dbo].[RETRAITS]
			([no_article],
			[rue],
			[code_postal],
			[ville])
	VALUES
			(5,
			N'9 rue de l''océan',
			N'85000',
			N'Les Sables d''Olonnes')
INSERT INTO [dbo].[RETRAITS]
			([no_article],
			[rue],
			[code_postal],
			[ville])
	VALUES
			(6,
			N'8 rue de Nantes',
			N'44000',
			N'Nantes')
SET IDENTITY_INSERT [dbo].[RETARITS] OFF

GO	
		
CREATE PROCEDURE updateArticle      
AS   
	DECLARE @id int
	DECLARE @montant int
	DECLARE @util int

	--ouvre cursor
	DECLARE db_cursor CURSOR FOR 
	SELECT no_article 
	FROM ARTICLES_VENDUS
	WHERE etat_vente = 'CR' AND GETDATE() >= date_debut_enchere;
	
	OPEN db_cursor  
	FETCH NEXT FROM db_cursor INTO @id 

	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		UPDATE ARTICLES_VENDUS SET  
		etat_vente = 'EC'
		WHERE no_article = @id;   

		FETCH NEXT FROM db_cursor INTO @id 
	END 
	
	--close cursor
	CLOSE db_cursor 
	DEALLOCATE db_cursor;
	
	--ouvre cursor Update article EC
	DECLARE db2_cursor CURSOR FOR 
	SELECT no_article, no_utilisateur
	FROM ARTICLES_VENDUS
	WHERE etat_vente = 'EC' AND GETDATE() > date_fin_enchere;
	
	OPEN db2_cursor  
	FETCH NEXT FROM db2_cursor INTO @id , @util

	WHILE @@FETCH_STATUS = 0  
	BEGIN 
		--set montant vente a zero
		SET @montant = 0;
		DECLARE db3_cursor CURSOR FOR 
		SELECT TOP(1) montant_enchere
		FROM ENCHERES
		WHERE no_article = @id ORDER BY montant_enchere DESC;
		
		OPEN db3_cursor  
		FETCH NEXT FROM db3_cursor INTO @montant 
		
		CLOSE db3_cursor 
		DEALLOCATE db3_cursor;
	
		UPDATE ARTICLES_VENDUS SET  
		etat_vente = 'VD',
		prix_vente = @montant
		WHERE no_article = @id;  

		--Si prix de vente > 0 créditer le propriétaire de l'article
		if @montant > 0 
		BEGIN
			UPDATE UTILISATEURS SET credit += @montant WHERE no_utilisateur = @util;
		END


		FETCH NEXT FROM db2_cursor INTO @id  , @util
	END 
	
	--close cursor
	CLOSE db2_cursor 
	DEALLOCATE db2_cursor;
	
    
GO 	