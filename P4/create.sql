
----------------- Creation de listes d'étudiants -----------------
DROP TABLE Etudiant;
DROP TYPE typeEtu FORCE;
DROP TYPE listeEtu;
DROP TYPE RefEtu;


CREATE OR REPLACE TYPE typeEtu AS OBJECT (
	login VARCHAR(8),
	nom VARCHAR(30),
	prenom VARCHAR(30),
	mail VARCHAR(50)
);
/
CREATE TABLE Etudiant OF typeEtu(
    PRIMARY KEY (login), 
    nom NOT NULL,
    prenom NOT NULL
);
/
CREATE OR REPLACE TYPE RefEtu AS OBJECT(
    etudiant REF typeEtu
);
/
CREATE OR REPLACE TYPE listeEtu AS TABLE OF RefEtu;
/

---------------------- Listes de professeurs ------------------------
DROP TABLE Enseignant;
DROP TYPE typeEns FORCE;
DROP TYPE listeEns;
DROP TYPE RefEns;

CREATE OR REPLACE TYPE typeEns AS OBJECT (
	login VARCHAR(8),
	nom VARCHAR(30),
	prenom VARCHAR(30),
	mail VARCHAR(50)
);
/
CREATE TABLE Enseignant OF typeEns (
    PRIMARY KEY (login),
    nom NOT NULL,
    prenom NOT NULL
);

CREATE OR REPLACE TYPE RefEns AS OBJECT(
    enseignant REF typeEns
);
/
CREATE OR REPLACE TYPE ListeEns AS TABLE OF RefEns;
/

------------------------- Semestres ------------------------
DROP TABLE Semestre;
DROP TYPE typSemestre FORCE;

CREATE TYPE typSemestre AS OBJECT (
	annee INTEGER(4),
	saison CHAR
);
/

CREATE TABLE Semestre OF typSemestre (
	PRIMARY KEY (annee, saison),
	CHECK (saison IN ('P', 'A'))
);

-------------------------- Mots clé --------------------------
DROP TABLE motCle;
DROP TYPE typMotCle FORCE;
DROP TYPE refMotCle;
DROP TYPE listeMotCle;

CREATE OR REPLACE TYPE typMotCle AS OBJECT (
	mot_cle VARCHAR(50)
);
/
CREATE TABLE MotCle OF typMotCle(
	PRIMARY KEY(mot_cle)
);
CREATE OR REPLACE TYPE refMotCle AS OBJECT( refMotCle REF typMotCle);
/
CREATE OR REPLACE TYPE listeMotCle AS TABLE OF refMotCle
/

--------------------- Licences -----------------------------
DROP TABLE Licence;
DROP TYPE typLicence FORCE;
DROP TYPE refLicence;
DROP TYPE listeLicence;

CREATE OR REPLACE TYPE typLicence AS OBJECT (
	code VARCHAR(10),
	nom VARCHAR(50)
);
/

CREATE TABLE Licence OF typLicence(
	PRIMARY KEY(code),
	code NOT NULL
);

CREATE OR REPLACE TYPE refLicence AS OBJECT(licence REF typLicence);
/
CREATE OR REPLACE  TYPE listeLicence AS TABLE OF refLicence;
/


---------------------------- Categories --------------------
DROP TABLE Categorie;
DROP TYPE typCategorie FORCE;

CREATE OR REPLACE TYPE typCategorie AS OBJECT (
	nom VARCHAR(50)
);
/

CREATE TABLE Categorie OF typCategorie(
	PRIMARY KEY (nom)
);

---------------------Documents ------------------------
DROP TABLE Documents;
DROP TYPE typDocument FORCE;

CREATE OR REPLACE TYPE typDocument AS OBJECT (
	idDoc VARCHAR(20),
	titre VARCHAR(100),
	date_pb DATE,
	description VARCHAR(500),
	archivedoc CHAR,
    auteur listeEtu,
   	professeur ListeEns,
	semestreDoc REF typSemestre,
	categorie REF typCategorie,
	licencedoc listeLicence,
	motCle  listeMotCle
);
/
CREATE TABLE Documents OF typDocument (
	PRIMARY KEY (idDoc),
	SCOPE FOR (categorie) IS Categorie,
	SCOPE FOR (semestreDoc) IS Semestre,
    CHECK (archivedoc IN ('Y', 'N'))
)
NESTED TABLE motCle STORE AS ntmotCle,
NESTED TABLE auteur STORE AS ntauteur,
NESTED TABLE licencedoc STORE AS ntlicence,
NESTED TABLE professeur STORE AS ntprofesseur
;


