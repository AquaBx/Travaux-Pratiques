CREATE TABLE Fournisseur(f TEXT, nom_f TEXT, remise INTEGER, ville TEXT);
CREATE TABLE Produit(p TEXT, nom_p TEXT, couleur TEXT, origine TEXT);
CREATE TABLE Fourniture(f TEXT, p TEXT, qte INTEGER);

INSERT INTO Fournisseur VALUES ('f1','Bornibus',5,'Paris');
INSERT INTO Fournisseur VALUES ('f2','Mercier',7,'Paris');
INSERT INTO Fournisseur VALUES ('f3','Colbert',3,'Reims');
INSERT INTO Fournisseur VALUES ('f4','Bossuet',6,'Dijon');
INSERT INTO Fournisseur VALUES ('f5','Tanguy',10,'Riec');
INSERT INTO Fournisseur VALUES ('f6','Dupont',0,'Paris');

INSERT INTO Produit VALUES ('p1','cassis','rouge','Dijon');
INSERT INTO Produit VALUES ('p2','champagne','blanc','Reims');
INSERT INTO Produit VALUES ('p3','huitre','vert','Riec');
INSERT INTO Produit VALUES ('p4','moutarde','jaune','Dijon');
INSERT INTO Produit VALUES ('p5','salade','vert','Nice');
INSERT INTO Produit VALUES ('p6','cornichon','vert','Dijon');
INSERT INTO Produit VALUES ('p7','muscadet','blanc','Nantes');

INSERT INTO Fourniture VALUES ('f1','p1',1);
INSERT INTO Fourniture VALUES ('f1','p4',1);
INSERT INTO Fourniture VALUES ('f1','p5',8);
INSERT INTO Fourniture VALUES ('f1','p6',2);
INSERT INTO Fourniture VALUES ('f2','p2',1);
INSERT INTO Fourniture VALUES ('f2','p4',1);
INSERT INTO Fourniture VALUES ('f3','p2',5);
INSERT INTO Fourniture VALUES ('f3','p4',1);
INSERT INTO Fourniture VALUES ('f4','p4',2);
INSERT INTO Fourniture VALUES ('f4','p5',7);
INSERT INTO Fourniture VALUES ('f4','p6',3);
INSERT INTO Fourniture VALUES ('f5','p7',10);