
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
    PRIMARY KEY (login)
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
    PRIMARY KEY (login)
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
	PRIMARY KEY(code)
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
NESTED TABLE MotCle STORE AS ntmotCle,
NESTED TABLE auteur STORE AS ntauteur,
NESTED TABLE licencedoc STORE AS ntlicence,
NESTED TABLE professeur STORE AS ntprofesseur
;




------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------


INSERT INTO Categorie (nom) VALUES ('informatique');
INSERT INTO Categorie (nom) VALUES ('mecanique');
INSERT INTO Categorie (nom) VALUES ('biologie');

INSERT INTO Licence(code, nom) VALUES ('cc-by', 'Attribution');
INSERT INTO Licence(code, nom) VALUES ('cc-nc', 'Non-commercial');
INSERT INTO Licence(code, nom) VALUES ('cc-nd', 'No derivative works');
INSERT INTO Licence(code, nom) VALUES ('cc-sa', 'Share alike');

INSERT INTO MotCle(mot_cle) VALUES ('base de données');
INSERT INTO MotCle(mot_cle) VALUES ('serveur');
INSERT INTO MotCle(mot_cle) VALUES ('reseau');
INSERT INTO MotCle(mot_cle) VALUES ('assembleur');
INSERT INTO MotCle(mot_cle) VALUES ('système embarqué');

INSERT INTO Semestre (annee, saison) VALUES (2017, 'A');
INSERT INTO Semestre (annee, saison) VALUES (2017, 'P');
INSERT INTO Semestre (annee, saison) VALUES (2016, 'A');
INSERT INTO Semestre (annee, saison) VALUES (2016, 'P');
INSERT INTO Semestre (annee, saison) VALUES (2015, 'A');

INSERT INTO Etudiant (login, nom, prenom) VALUES ('duboisoc', 'Dubois', 'Oceane');
INSERT INTO Etudiant (login, nom, prenom) VALUES ('jcampred', 'Campredon', 'Justine');
INSERT INTO Etudiant (login, nom, prenom) VALUES ('cimtierm', 'Cimetière', 'Maud');
INSERT INTO Etudiant (login, nom, prenom) VALUES ('cmenioux', 'Menioux', 'Clémentine');

INSERT INTO Enseignant (login, nom, prenom) VALUES ('crzstph', 'Crozat', 'Stéphane');
INSERT INTO Enseignant (login, nom, prenom) VALUES ('jbouffl', 'Boufflet', 'Jean-Paul');
INSERT INTO Enseignant (login, nom, prenom) VALUES ('bonnets', 'Bonnet', 'Stéphane');

------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------

DECLARE 
	osemestre1 REF typSemestre;
	ocategorie1 REF typCategorie;
	oens1 REF typeEns;
	oetu1 REF typeEtu;
	oetu2 REF typeEtu;
	olicence1 REF typLicence;
	omotcle1 REF typMotCle;
    osemestre2 REF typSemestre;
	ocategorie2 REF typCategorie;
	oens2 REF typeEns;
	oetu3 REF typeEtu;
	oetu4 REF typeEtu;
	olicence2 REF typLicence;
	omotcle2 REF typMotCle;
BEGIN 
	SELECT REF(s) INTO osemestre1
	FROM Semestre s
	WHERE s.annee=2017 AND s.saison='A';

	SELECT REF(c) INTO ocategorie1
	FROM Categorie c
	WHERE c.nom='informatique';

	SELECT REF(s) INTO oetu1
	FROM Etudiant s
	WHERE s.login='duboisoc';

	SELECT REF(etu) INTO oetu2
	FROM Etudiant etu
	WHERE etu.login='cimtierm';

	SELECT REF(ens) INTO oens1
	FROM Enseignant ens
	WHERE ens.login='crzstph';

	SELECT REF(l) INTO olicence1
	FROM Licence l
	WHERE l.code='cc-by';

	SELECT REF(m) INTO omotcle1
	FROM MotCle m
	WHERE m.mot_cle='reseau';
    
    SELECT REF(s) INTO osemestre2
	FROM Semestre s
	WHERE s.annee=2016 AND s.saison='P';

	SELECT REF(c) INTO ocategorie2
	FROM Categorie c
	WHERE c.nom='biologie';

	SELECT REF(s) INTO oetu3
	FROM Etudiant s
	WHERE s.login='cmenioux';

	SELECT REF(etu) INTO oetu4
	FROM Etudiant etu
	WHERE etu.login='cimtierm';

	SELECT REF(ens) INTO oens2
	FROM Enseignant ens
	WHERE ens.login='jbouffl';

	SELECT REF(l) INTO olicence2
	FROM Licence l
	WHERE l.code='cc-by';

	SELECT REF(m) INTO omotcle2
	FROM MotCle m
	WHERE m.mot_cle='assembleur';

	INSERT INTO Documents (idDoc, titre, date_pb, auteur, professeur, description, archivedoc, semestredoc, categorie, licencedoc, motCle) 
    VALUES (1, 'Compte-rendu projet P2', to_date('13102017', 'DDMMYYYY'), listeEtu(refetu(oetu3), refetu(oetu4)),listeEns(refens(oens2)), 'Rapport réalisé dans le cadre de de NF16, P2 comporte le modèle logique et le modèle conceptuel de données', 'Y', osemestre2,  ocategorie2, listeLicence(refLicence(olicence2)), listeMotCle(refMotCle(omotcle2)));


	INSERT INTO Documents (idDoc, titre, date_pb, auteur,professeur, description, archivedoc, semestredoc, categorie, licencedoc, motCle) 
    VALUES (2, 'Compte-rendu projet P2', to_date('04062017', 'DDMMYYYY'), listeEtu(refetu(oetu1), refetu(oetu2)),listeEns(refens(oens1)), 'Rapport réalisé dans le cadre de de NF16, P2 comporte le modèle logique et le modèle conceptuel de données', 'N', osemestre1,  ocategorie1, listeLicence(refLicence(olicence1)), listeMotCle(refMotCle(omotcle1)));

END;



------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------

SELECT d.titre
FROM Documents d
WHERE d.categorie.nom = 'informatique';

SELECT d.titre
FROM Documents d
WHERE d.semestredoc.saison = 'A'
    AND d.semestredoc.annee = '2017';

