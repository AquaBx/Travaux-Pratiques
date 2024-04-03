CREATE TABLE Clients(
    id_client INT PRIMARY KEY NOT NULL,
    nom_client VARCHAR(50) NOT NULL,
    telephone VARCHAR(10),
    adresse VARCHAR(255)
);

CREATE TABLE Produits(
    id_produit INT PRIMARY KEY NOT NULL,
    nom_produit VARCHAR(50) NOT NULL
);

CREATE TABLE Commandes(
    num_facture INT PRIMARY KEY NOT NULL,
    date_facture DATE NOT NULL,
    id_client INT NOT NULL,
    prix_total FLOAT NOT NULL
);

CREATE TABLE Panier(
    num_facture INT NOT NULL,
    id_produit INT NOT NULL,
    prix_unitaire FLOAT NOT NULL,
    quantite INT NOT NULL,
    TVA FLOAT NOT NULL,
    PRIMARY KEY(num_facture,id_produit)
);

CREATE TRIGGER tarif_total_insert
AFTER INSERT ON Panier
FOR EACH ROW
BEGIN
UPDATE Commandes SET prix_total=(SELECT sum(prix_ttc) FROM (SELECT num_facture,prix_unitaire*TVA*quantite as prix_ttc FROM Panier) GROUP BY num_facture HAVING num_facture=NEW.num_facture) WHERE num_facture=NEW.num_facture;
END;

CREATE TRIGGER tarif_total_update
AFTER UPDATE ON Panier
FOR EACH ROW
BEGIN
UPDATE Commandes SET prix_total=(SELECT sum(prix_ttc) FROM (SELECT num_facture,prix_unitaire*TVA*quantite as prix_ttc FROM Panier) GROUP BY num_facture HAVING num_facture=NEW.num_facture) WHERE num_facture=NEW.num_facture;
END;

INSERT INTO Produits VALUES (0,'pomme');
INSERT INTO Produits VALUES (1,'tomate');
INSERT INTO Produits VALUES (2,'orange');

INSERT INTO Clients VALUES (0,'Alpha Co','1231231231','3, Rue du Thabor, 35000 Rennes');
INSERT INTO Clients VALUES (1,'Beta Co','3213213213','43, Place de la République, 35000 Rennes');
INSERT INTO Clients VALUES (2,'Gamma Co','7417417417','32, Rue dOrléans, 44000 Nantes');

INSERT INTO Commandes VALUES (123,'2013-03-02',0,0);
INSERT INTO Commandes VALUES (124,'2013-04-03',1,0);
INSERT INTO Commandes VALUES (125,'2013-04-04',2,0);

INSERT INTO Panier VALUES (123,0,1,2,1);
INSERT INTO Panier VALUES (124,1,0.5,22,2);
INSERT INTO Panier VALUES (125,2,1,13,2);