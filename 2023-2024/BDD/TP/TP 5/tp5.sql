CREATE TABLE APPARTENIR (
  id_Cours    INTEGER NOT NULL,
  id_Parcours INTEGER NOT NULL,
  PRIMARY KEY (id_Cours, id_Parcours),
  FOREIGN KEY (id_Parcours) REFERENCES PARCOURS(id_Parcours),
  FOREIGN KEY (id_Cours) REFERENCES COURS(id_Cours)
);

CREATE TABLE COURS (
  id_Cours INTEGER NOT NULL,
  matiere  VARCHAR(30),
  PRIMARY KEY (id_Cours)
);

CREATE TABLE LIVRE (
  id_Livre INTEGER NOT NULL,
  titre    VARCHAR(40),
  auteur   VARCHAR(64),
  date_modif DATE,
  PRIMARY KEY (id_Livre)
);

CREATE TABLE PARCOURS (
  id_Parcours  INTEGER NOT NULL,
  nom_Parcours VARCHAR(30),
  PRIMARY KEY (id_Parcours)
);

CREATE TABLE PROPOSER (
  id_Cours INTEGER NOT NULL,
  id_Livre INTEGER NOT NULL,
  PRIMARY KEY (id_Cours, id_Livre),
  FOREIGN KEY (id_Livre) REFERENCES LIVRE(id_Livre),
  FOREIGN KEY (id_Cours) REFERENCES COURS(id_Cours)
);

CREATE TABLE UTILISER (
  id_Livre    INTEGER NOT NULL,
  id_Parcours INTEGER NOT NULL,
  annee       INTEGER,
  PRIMARY KEY (id_Livre, id_Parcours),
  FOREIGN KEY (id_Livre) REFERENCES LIVRE(id_Livre),
  FOREIGN KEY (id_Parcours) REFERENCES PARCOURS(id_Parcours)
);

CREATE TRIGGER LivresUpdate
AFTER UPDATE ON LIVRE
FOR EACH ROW
BEGIN
UPDATE LIVRE SET date_modif=date('now') WHERE id_Livre=NEW.id_Livre;
END;

CREATE TRIGGER LivresInsert
AFTER INSERT ON LIVRE
FOR EACH ROW
BEGIN
UPDATE LIVRE SET date_modif=date('now') WHERE id_Livre=NEW.id_Livre;
END;

CREATE VIEW VIEW_LIVRES AS
SELECT *
FROM LIVRE;