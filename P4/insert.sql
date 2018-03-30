--Insersion dans la table Catégorie

INSERT INTO Categorie (nom) VALUES ('informatique');

INSERT INTO Categorie (nom) VALUES ('mecanique');

INSERT INTO Categorie (nom) VALUES ('biologie');



--Insersion dans la table Licence

INSERT INTO Licence(code, nom) VALUES ('cc-by', 'Attribution');

INSERT INTO Licence(code, nom) VALUES ('cc-nc', 'Non-commercial');

INSERT INTO Licence(code, nom) VALUES ('cc-nd', 'No derivative works');

INSERT INTO Licence(code, nom) VALUES ('cc-sa', 'Share alike');



--Insersion dans la table Mot Clé

INSERT INTO MotCle(mot_cle) VALUES ('base de données');

INSERT INTO MotCle(mot_cle) VALUES ('serveur');

INSERT INTO MotCle(mot_cle) VALUES ('reseau');

INSERT INTO MotCle(mot_cle) VALUES ('assembleur');

INSERT INTO MotCle(mot_cle) VALUES ('système embarqué');



--Insersion dans la table Semestres

INSERT INTO Semestre (annee, saison) VALUES (2017, 'A');

INSERT INTO Semestre (annee, saison) VALUES (2017, 'P');

INSERT INTO Semestre (annee, saison) VALUES (2016, 'A');

INSERT INTO Semestre (annee, saison) VALUES (2016, 'P');

INSERT INTO Semestre (annee, saison) VALUES (2015, 'A');



--Insersion dans la table Etudiant

INSERT INTO Etudiant (login, nom, prenom) VALUES ('duboisoc', 'Dubois', 'Oceane');

INSERT INTO Etudiant (login, nom, prenom) VALUES ('jcampred', 'Campredon', 'Justine');

INSERT INTO Etudiant (login, nom, prenom) VALUES ('cimtierm', 'Cimetière', 'Maud');

INSERT INTO Etudiant (login, nom, prenom) VALUES ('cmenioux', 'Menioux', 'Clémentine');



--Insersion dans la table Enseignant

INSERT INTO Enseignant (login, nom, prenom) VALUES ('crzstph', 'Crozat', 'Stéphane');

INSERT INTO Enseignant (login, nom, prenom) VALUES ('jbouffl', 'Boufflet', 'Jean-Paul');

INSERT INTO Enseignant (login, nom, prenom) VALUES ('bonnets', 'Bonnet', 'Stéphane');



--Insersion dans la table Documents

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



	INSERT INTO Documents (idDoc, titre, date_pb, auteur, description, archivedoc, semestredoc, categorie, licencedoc, motCle)

    VALUES (1, 'Compte-rendu projet P2', to_date('13102017', 'DDMMYYYY'), listeEtu(refetu(oetu3), refetu(oetu4)), 'Rapport réalisé dans le cadre de de NF16, P2 comporte le modèle logique et le modèle conceptuel de données', 'Y', osemestre2,  ocategorie2, listeLicence(refLicence(olicence2)), listeMotCle(refMotCle(omotcle2)));





	INSERT INTO Documents (idDoc, professeur, titre, date_pb, auteur, description, archivedoc, semestredoc, categorie, licencedoc, motCle)

    VALUES (2, listeEns(refens(oens1)), 'Compte-rendu projet P2', to_date('04062017', 'DDMMYYYY'), listeEtu(refetu(oetu1), refetu(oetu2)), 'Rapport réalisé dans le cadre de de NF16, P2 comporte le modèle logique et le modèle conceptuel de données', 'N', osemestre1,  ocategorie1, listeLicence(refLicence(olicence1)), listeMotCle(refMotCle(omotcle1)));



END;
