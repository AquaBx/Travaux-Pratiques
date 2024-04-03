CREATE TABLE etudiant(etudId INTEGER, nom TEXT, prenom TEXT, adress TEXT);
CREATE TABLE professeur(profId INTEGER, nom TEXT, prenom TEXT);
CREATE TABLE enseignement(ensId INTEGER, sujet TEXT, etudId INTEGER, profId INTEGER);

INSERT INTO etudiant VALUES (0,'Baron','Nicolas','Rennes');
INSERT INTO etudiant VALUES (1,'Chauvel','Tom','Rennes');

INSERT INTO professeur VALUES (0,'Lamarche','Fabrice');
INSERT INTO professeur VALUES (1,'Feuillatre','Hélene');

INSERT INTO enseignement VALUES (0,'IHM',1,1);
INSERT INTO enseignement VALUES (1,'CPP',0,0);
INSERT INTO enseignement VALUES (1,'CPP',1,0);

SELECT * from etudiant JOIN enseignement USING(etudId) WHERE sujet='IHM';
SELECT nom,prenom from etudiant JOIN enseignement USING(etudId) WHERE sujet='CPP';