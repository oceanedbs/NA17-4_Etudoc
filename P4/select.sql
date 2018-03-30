--Sélectionner les documents par categorie

SELECT d.titre

FROM Documents d

WHERE d.categorie.nom = 'informatique';



--Sélectionner les documents par mot cle

SELECT d.titre, m.refMotCle.mot_cle

FROM Documents d, TABLE(d.motCle) m

WHERE m.refMotCle.mot_cle= 'reseau';



--Sélectionner les documents par semestre

SELECT d.titre

FROM Documents d

WHERE d.semestredoc.saison = 'A'

AND d.semestredoc.annee = '2017';



--Sélectionner les documents par etudiant

SELECT d.titre,au.Etudiant.nom,au.Etudiant.prenom

FROM Documents d, TABLE(d.auteur) au

WHERE au.Etudiant.login = 'duboisoc';



--Sélectionner les documents par enseignant

SELECT d.titre,p.Enseignant.nom,p.Enseignant.prenom

FROM Documents d, TABLE(d.professeur) p

WHERE p.Enseignant.login = 'crzstph';



--Archiver un document

UPDATE Documents

SET archivedoc = 'Y'

WHERE idDoc = '1';



--Sélectionner les documents qui ne sont pas archivés

SELECT titre FROM Documents

WHERE archivedoc <> 'Y';



--Supprimer un document

DELETE FROM Documents

WHERE idDoc = '1';
