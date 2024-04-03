CREATE TABLE CLIENT (
  id_C              INTEGER NOT NULL,
  nom               VARCHAR(100) NOT NULL,
  adresse_C         VARCHAR(255),
  phone_C           VARCHAR(10),
  mail_C            VARCHAR(255),
  num_Permis        VARCHAR(9) NOT NULL,
  fonction          VARCHAR(100),
  PRIMARY KEY (id_C)

);

CREATE TABLE PREFERE (
  id_C INTEGER NOT NULL,
  id_P INTEGER NOT NULL,
  PRIMARY KEY (id_C, id_P),
    FOREIGN KEY (id_P) REFERENCES PREFERENCE(id_P),
    FOREIGN KEY (id_C) REFERENCES CLIENT(id_C)
);

CREATE TABLE PREFERENCE (
  id_P         INTEGER NOT NULL,
  marque       VARCHAR(100),
  modele       VARCHAR(100),
  transmission VARCHAR(100),
  couleur      VARCHAR(100),
  carburant    VARCHAR(100),
  PRIMARY KEY (id_P)
);

CREATE TABLE RERSERVATION (
  id_R           INTEGER NOT NULL,
  date_debut     DATE NOT NULL,
  date_fin       DATE NOT NULL,
  ville_location VARCHAR(100) NOT NULL,
  ville_retour   VARCHAR(100) NOT NULL,
  prix_total     FLOAT NOT NULL,
  saison         VARCHAR(100) NOT NULL,
  duree          INTEGER NOT NULL, -- en secondes
  id_C           INTEGER NOT NULL,
  id_V           INTEGER NOT NULL,
  PRIMARY KEY (id_R),
    FOREIGN KEY (id_V) REFERENCES VOITURE(id_V),
    FOREIGN KEY (id_C) REFERENCES CLIENT(id_C)



);

CREATE TABLE SUCCURSALE (
  id_S          INTEGER NOT NULL,
  ville_S       VARCHAR(100) NOT NULL,
  adresse_S     VARCHAR(100) NOT NULL,
  phone_S       VARCHAR(10),
  code_postal_S VARCHAR(5) NOT NULL,
  caution       FLOAT,
  PRIMARY KEY (id_S)
);

CREATE TABLE VOITURE (
    id_V          INTEGER NOT NULL,
    marque        VARCHAR(100),
    modele        VARCHAR(100),
    annee         VARCHAR(4),
    categorie     VARCHAR(50),
    disponibilite BOOLEAN,
    prix          FLOAT,
    transmission  VARCHAR(100),
    couleur       VARCHAR(100),
    carburant     VARCHAR(100),
    id_S          INTEGER NOT NULL,
    PRIMARY KEY (id_V),
    FOREIGN KEY (id_S) REFERENCES SUCCURSALE(id_S)

);