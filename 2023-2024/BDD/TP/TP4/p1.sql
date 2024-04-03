CREATE TABLE CARACTERISTIQUE (
    Id_caracteristique INTEGER NOT NULL,
    caracteristique    VARCHAR(100) NOT NULL,
    PRIMARY KEY (Id_caracteristique)
);

CREATE TABLE CLIENT (
    Id_Client INTEGER NOT NULL,
    nom_C     VARCHAR(100) NOT NULL,
    adresse_C VARCHAR(255),
    phone_C   VARCHAR(10),
    mail_C    VARCHAR(255),
    PRIMARY KEY (Id_Client)
);

CREATE TABLE COMMANDE (
    Id_Commande INTEGER NOT NULL,
    date        DATE NOT NULL,
    statut      VARCHAR(100) NOT NULL,
    Id_Client   INTEGER NOT NULL,
    PRIMARY KEY (Id_Commande),
    FOREIGN KEY (Id_Client) REFERENCES CLIENT(Id_Client)
);

CREATE TABLE CONTENIR (
    Id_Commande INTEGER NOT NULL,
    Id_Produit  INTEGER NOT NULL,
    quantite    INTEGER NOT NULL,
    PRIMARY KEY (Id_Commande,Id_Produit),
    FOREIGN KEY (Id_Produit) REFERENCES PRODUIT(Id_Produit),
    FOREIGN KEY (Id_Commande) REFERENCES COMMANDE(Id_Commande)

);

CREATE TABLE DECRIRE (
    Id_Produit         INTEGER NOT NULL,
    Id_caracteristique INTEGER NOT NULL,
    PRIMARY KEY (Id_caracteristique,Id_Produit),
    FOREIGN KEY (Id_caracteristique) REFERENCES CARACTERISTIQUE(Id_caracteristique),
    FOREIGN KEY (Id_Produit) REFERENCES PRODUIT(Id_Produit)
);

CREATE TABLE FOURNISSEUR (
    Id_Fournisseur INTEGER NOT NULL,
    nom_F          VARCHAR(100) NOT NULL,
    adresse_F      VARCHAR(255),
    phone_F        VARCHAR(10),
    mail_F         VARCHAR(255),
    PRIMARY KEY (Id_Fournisseur)
);

CREATE TABLE FOURNIR (
    Id_Produit     INTEGER NOT NULL,
    Id_Fournisseur INTEGER NOT NULL,
    PRIMARY KEY (Id_Fournisseur,Id_Produit)
);

CREATE TABLE PRODUIT (
    Id_Produit       INTEGER NOT NULL,
    marque           VARCHAR(100) NOT NULL,
    modele           VARCHAR(100) NOT NULL,
    description      TEXT,
    prix             FLOAT NOT NULL,
    stock            INTEGER NOT NULL,
    PRIMARY KEY (Id_Produit)
);